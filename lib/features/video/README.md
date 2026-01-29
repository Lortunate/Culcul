# 视频播放页面使用指南

## 快速开始

### 基本用法

```dart
// 导航到视频播放页面
context.push('/video/$bvid');
```

## 核心功能

### 1. 画质切换

播放器支持自动检测的多档位清晰度：

| 代码 | 标签 | 说明 |
|------|------|------|
| 125 | 4K 超清 | 2160p 超高清 |
| 120 | 1080P 高清 | Full HD |
| 112 | 720P 高清 | HD |
| 80 | 480P 清晰 | 标清 |
| 64 | 360P 流畅 | 流畅 |
| 32 | 240P 流畅 | 极速 |
| 16 | 144P 极速 | 最低质量 |

**实现方式：**
- 自动从 API 响应获取 `acceptQuality` 列表
- 用户点击设置按钮打开菜单
- 选择新画质自动获取新的播放 URL
- 倍速设置保持不变

### 2. 倍速播放

支持 6 档播放速度：

```dart
const List<double> playbackSpeeds = [0.5, 0.75, 1.0, 1.25, 1.5, 2.0];
```

**使用：**
- 点击播放器上的设置菜单
- 在"倍速"部分选择所需速度
- 实时应用到正在播放的视频

### 3. 视频标签

显示与视频相关的分类标签：

```dart
VideoTag(
  tagId: 123,
  tagName: '动画',
  likes: 1000,
  cover: 'image_url',
  uri: 'tag_url',
)
```

**特性：**
- 自动过滤空标签
- 响应式 Wrap 布局
- 支持点击跳转（预留）
- 显示标签热度

## 状态管理

### VideoDetailState

```dart
@freezed
abstract class VideoDetailState with _$VideoDetailState {
  const factory VideoDetailState({
    @Default(true) bool isLoading,
    VideoDetail? videoDetail,
    PlayUrl? playUrl,
    Object? error,
    @Default(0) int currentCid,
    @Default([]) List<RelatedVideo> relatedVideos,
    @Default([]) List<CommentItem> comments,
    @Default(1) int commentSort,
    @Default(1) int commentPage,
    @Default(false) bool isCommentLoading,
    @Default(true) bool hasMoreComments,
    @Default(80) int selectedQuality,        // 新增
    @Default(1.0) double playbackSpeed,      // 新增
    @Default([]) List<int> availableQualities, // 新增
  }) = _VideoDetailState;
}
```

### 控制器方法

```dart
// 切换画质
await notifier.switchQuality(80);

// 设置倍速
notifier.setPlaybackSpeed(1.5);

// 切换分段
await notifier.switchPart(cid);

// 切换评论排序
await notifier.switchCommentSort(1); // 1=热度, 0=时间
```

## UI 组件

### 播放器界面

```dart
_VideoPlayerSection(
  controller: controller,
  player: player,
  isLoading: state.isLoading,
  error: state.error,
  onRetry: () => notifier.retry(),
  aspectRatio: aspectRatio,
  selectedQuality: state.selectedQuality,
  availableQualities: state.availableQualities,
  playbackSpeed: state.playbackSpeed,
  onQualityChanged: (qn) => notifier.switchQuality(qn),
  onSpeedChanged: (speed) => notifier.setPlaybackSpeed(speed),
)
```

### 视频信息区域

```dart
_VideoInfoView(
  detail: videoDetail,
  relatedVideos: relatedVideos,
  currentCid: currentCid,
  onPartChanged: (cid) => notifier.switchPart(cid),
)
```

包含的子组件：
- `_UploaderInfoRow` - UP主信息和关注按钮
- `_VideoMetaRow` - 播放量、弹幕数、发布时间等
- `_VideoPartsList` - 视频分段列表
- `_VideoTagsSection` - 视频标签区域
- `_ExpandableDescription` - 可展开的视频描述
- `_VideoActionsRow` - 点赞、投币、收藏、分享
- `_RecommendationItem` - 推荐视频列表

## 常量定义

### 画质标签

```dart
const Map<int, String> qualityLabels = {
  125: '4K 超清',
  120: '1080P 高清',
  112: '720P 高清',
  80: '480P 清晰',
  64: '360P 流畅',
  32: '240P 流畅',
  16: '144P 极速',
};
```

### 播放速度

```dart
const List<double> playbackSpeeds = [
  0.5,   // 半速
  0.75,  // 四分之三速
  1.0,   // 正常速度
  1.25,  // 四分之五速
  1.5,   // 一点五倍速
  2.0,   // 二倍速
];
```

## 数据流

```
VideoDetailPage (UI)
        ↓
videoDetailControllerProvider(bvid) (Riverpod)
        ↓
VideoDetailController (业务逻辑)
        ↓
VideoRepository (数据获取)
        ↓
VideoApi (网络请求)
        ↓
Bilibili API
```

### 初始化流程

1. 用户打开视频页面 → `VideoDetailPage(bvid)`
2. Controller 初始化 → 调用 `_init()`
3. 获取视频详情 → `fetchVideoView(bvid)`
4. 获取推荐视频 → `fetchRelatedVideos(bvid)`
5. 获取评论 → `fetchComments(aid)`
6. 获取播放 URL → `fetchVideoPlayUrl(aid, cid, qn)`
7. UI 订阅状态 → 实时更新显示

### 画质切换流程

1. 用户选择新画质
2. `switchQuality(qn)` 被调用
3. `_fetchPlayUrl(aid, cid, qn: qn)` 重新获取
4. 新的 `PlayUrl` 对象被返回
5. `VideoDetailState` 更新
6. 视频播放器自动加载新 URL

## 网络请求

### 获取播放 URL

```dart
Future<PlayUrl> fetchVideoPlayUrl({
  required int aid,
  required int cid,
  int qn = 80,      // 画质代码
  int fnval = 1,    // 格式（1=MP4）
  int fnver = 0,
  int fourk = 0,
})
```

**请求头：**
```dart
httpHeaders: {
  'User-Agent': 'Mozilla/5.0 ...',
  'Referer': 'https://www.bilibili.com/',
}
```

**WBI 签名：**
需要 WBI 签名以获得有效的播放链接。

## 深色模式

所有组件都支持深色/浅色主题自适应：

```dart
final isDark = Theme.of(context).brightness == Brightness.dark;

// 根据主题选择颜色
backgroundColor: isDark ? Color(0xFF2C2C2E) : Color(0xFFF1F2F3)
```

## 性能优化

### 播放器管理

```dart
final player = useMemoized(() => Player());
final controller = useMemoized(() => VideoController(player));

useEffect(() {
  return player.dispose;  // 及时清理资源
}, [player]);
```

### 状态更新

- 只在必要时更新状态
- 使用 `copyWith` 创建新状态对象
- 避免不必要的重建

### 图片加载

使用 `ExtendedImage` 实现：
- 图片缓存
- 懒加载
- 加载状态占位符

## 常见问题

### Q: 如何添加新的画质？
A: 在 `video_repository.dart` 中的 `fetchVideoPlayUrl` 方法中修改 `qn` 参数的默认值或范围。

### Q: 倍速播放对所有视频都有效吗？
A: 是的，倍速由 media_kit 播放器控制，对所有视频有效。

### Q: 画质切换需要重新加载视频吗？
A: 是的，需要获取新画质的播放 URL 并重新加载。

### Q: 如何自定义标签显示？
A: 编辑 `_VideoTagsSection` 组件中的样式和布局代码。

## 扩展建议

1. **添加弹幕显示**：集成弹幕库
2. **字幕支持**：获取字幕数据并显示
3. **截图功能**：使用播放器截图功能
4. **画面比例调整**：添加宽屏/全屏选项
5. **观看历史**：记录用户观看进度