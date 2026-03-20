# Flutter 项目目录结构重构方案

## 1. 当前结构的核心问题

当前 `lib` 的主要问题不是单个目录太大，而是**同一业务被按技术层拆散后，又在 UI 内继续细拆**，导致查找路径长、理解成本高、功能边界模糊。

### 1.1 目录重复按“技术类型”切分

当前顶层同时存在：

- `core/`
- `data/`
- `domain/`
- `providers/`
- `repositories/`
- `services/`
- `shared/`
- `ui/`

这意味着一个功能通常会分散在：

- `ui/pages/video/...`
- `providers/video/...`
- `repositories/video_repository.dart`
- `data/api/video_api.dart`
- `data/models/video/...`

结果是：

- 改一个功能要跨 4 到 6 个目录跳转
- 目录名表达的是“技术实现方式”，不是“业务能力”
- 业务链路无法在一个地方看全

### 1.2 过度分层，存在“为分层而分层”

当前结构里有明显的过度抽象：

- `data/api` + `repositories` + `providers` 三层对多数功能来说过重
- `domain/entities` 很薄，只有少量实体，不足以支撑完整 DDD 分层
- `core/repositories/base_repository.dart`、`core/types/result.dart`、`core/errors/...` 等基础层与具体业务调用深度耦合

问题在于：

- 项目规模还没到必须强制分 `domain/data/presentation` 的程度
- 大量 feature 只是“接口 + 状态 + 页面”，却被迫拆成多个横向层
- 抽象层带来的复杂度，大于它带来的收益

### 1.3 `core/shared/common` 边界不清

当前全局能力被分散到多个“看起来都像公共层”的目录：

- `core/utils`
- `core/widgets`
- `shared/extensions`
- `ui/widgets`
- `ui/theme`

这会导致两个问题：

- 新文件不知道放哪
- 本该 feature 私有的东西被提前提升为全局共享

典型表现：

- `ui/widgets/video_card.dart`、`follow_button.dart`、`profile_stat_item.dart` 其实具备明显业务语义，不是纯通用组件
- `ui/widgets/danmaku/...` 更接近播放器能力或独立 feature，不适合挂在全局 widgets 下
- `core/utils/danmaku_mask_parser.dart`、`share_utils.dart`、`toast_utils.dart`、`timeago_utils.dart` 混放在一起，职责跨度过大

### 1.4 UI 层内部再次过细拆分

例如：

- `ui/pages/video/widgets/controls/bottom_bar/...`
- `ui/pages/search/widgets/items/...`
- `ui/pages/profile/widgets/home_tab/...`

这些目录拆分深度已经超过“可读性提升”的收益，反而导致：

- 打开目录才能继续找目录
- 组件数量不多，却被多层文件夹包裹
- 很多“只服务一个页面”的部件被拆得像共享库

### 1.5 feature 之间边界不稳定

目前一些功能被拆散在多个 feature 之间：

- `home` 下有 `live/weekly`
- `profile` 与 `relation`、`user_space` 存在业务交叉
- `notification`、`chat`、`private_session` 聚合不彻底

这说明当前 feature 划分与用户心智模型不完全一致。

### 1.6 存在无效目录和空目录

例如：

- `ui/pages/subscription/`
- `ui/pages/dynamic/utils/`
- `ui/widgets/refresh_indicator/`
- `data/models/bangumi/`

这类目录会不断制造“这里应该还有内容”的错觉，增加噪音。

### 1.7 生成物与源码摆放不够收敛

例如：

- `lib/protos/` 下同时出现源码与生成后的 `lib/protos/...`

这会让源码边界变得不清晰，也不利于后续维护。

## 2. 重构目标

新的结构应满足：

- 按功能模块组织
- 一个 feature 内能看到页面、状态、仓储、模型
- 共享目录只保留真正全局复用的能力
- 降低目录深度，减少中间层
- 允许简单 feature 保持简单，不强制套模板

## 3. 建议的新目录结构

推荐将 `lib` 收敛为下面这套结构：

```text
lib/
├── app/
│   ├── app.dart
│   ├── bootstrap.dart
│   ├── router/
│   │   ├── app_router.dart
│   │   └── app_routes.dart
│   ├── theme/
│   │   ├── app_theme.dart
│   │   ├── app_colors.dart
│   │   ├── app_text_theme.dart
│   │   └── app_component_theme.dart
│   └── l10n/
│       ├── en.i18n.json
│       ├── zh.i18n.json
│       └── zh_Hant.i18n.json
├── foundation/
│   ├── network/
│   │   ├── dio_client.dart
│   │   └── interceptors/
│   ├── storage/
│   │   ├── shared_prefs.dart
│   │   ├── hive_box.dart
│   │   └── cookie_jar.dart
│   ├── errors/
│   │   ├── exceptions.dart
│   │   └── error_handler.dart
│   ├── result/
│   │   └── result.dart
│   ├── config/
│   │   ├── api_constants.dart
│   │   ├── api_cache_config.dart
│   │   ├── app_constants.dart
│   │   └── app_dimens.dart
│   └── utils/
│       ├── format_utils.dart
│       ├── json_utils.dart
│       ├── validation_utils.dart
│       └── toast_utils.dart
├── shared/
│   ├── widgets/
│   │   ├── app_network_image.dart
│   │   ├── app_error_widget.dart
│   │   ├── app_bottom_sheet.dart
│   │   ├── app_shimmer.dart
│   │   ├── smart_paging_view.dart
│   │   └── refresh_header_footer.dart
│   ├── extensions/
│   │   └── format_extensions.dart
│   └── services/
│       ├── audio_handler.dart
│       └── media_service.dart
├── features/
│   ├── auth/
│   │   ├── data/
│   │   │   ├── auth_api.dart
│   │   │   ├── auth_repository.dart
│   │   │   └── models/
│   │   ├── logic/
│   │   │   └── auth_provider.dart
│   │   └── presentation/
│   │       ├── login_page.dart
│   │       ├── country_code_selection_page.dart
│   │       ├── hooks/
│   │       └── widgets/
│   ├── home/
│   │   ├── data/
│   │   ├── logic/
│   │   └── presentation/
│   ├── dynamic/
│   │   ├── data/
│   │   ├── logic/
│   │   └── presentation/
│   ├── video/
│   │   ├── data/
│   │   │   ├── video_api.dart
│   │   │   ├── video_repository.dart
│   │   │   ├── danmaku_repository.dart
│   │   │   └── models/
│   │   ├── logic/
│   │   │   ├── video_detail_controller.dart
│   │   │   ├── video_detail_state.dart
│   │   │   ├── player_controller.dart
│   │   │   ├── subtitle_controller.dart
│   │   │   └── comment_reply_controller.dart
│   │   └── presentation/
│   │       ├── video_detail_page.dart
│   │       ├── vertical_video_page.dart
│   │       ├── comment_reply_page.dart
│   │       ├── hooks/
│   │       └── widgets/
│   ├── live/
│   ├── profile/
│   ├── relation/
│   ├── search/
│   ├── notification/
│   ├── favorites/
│   ├── history/
│   ├── ranking/
│   ├── settings/
│   ├── scanner/
│   └── to_view/
├── integrations/
│   └── protos/
│       ├── dm.proto
│       ├── dm.pb.dart
│       ├── dm.pbenum.dart
│       ├── dm.pbjson.dart
│       └── dm.pbserver.dart
└── main.dart
```

## 4. 每个目录存在的必要性

### `app/`

只放应用装配层代码：

- 应用入口 Widget
- 路由注册
- Theme
- 国际化资源
- 启动初始化协调

它不承载业务逻辑，只负责“把应用拼起来”。

### `foundation/`

只放真正跨 feature 的底层基础设施：

- 网络客户端
- 存储适配
- 通用异常与结果类型
- 全局配置
- 无业务语义的纯工具函数

这里是基础设施层，不是“什么都能放”的杂物间。

### `shared/`

只放多个 feature 重复使用、且不绑定某个具体业务的内容：

- 通用 UI 组件
- 通用扩展
- 跨 feature 服务

如果一个组件带有明确业务语义，例如“视频卡片”“关注按钮”“用户标签”，原则上不应该优先放这里。

### `features/`

这是核心目录。每个 feature 对外是一个完整模块，内部自己管理：

- `data/`：接口、仓储、本地数据源、feature 专属模型
- `logic/`：Riverpod provider、controller、state、业务组合逻辑
- `presentation/`：页面、局部 widgets、hooks

注意：**不是每个 feature 都必须三个子目录都齐全**。

例如：

- 很小的 `scanner` 可以只有 `presentation/`
- 很简单的 `history` 可能 `data/logic/presentation` 也足够，不要继续拆 `domain`

### `integrations/`

放外部协议或第三方生成代码，例如 protobuf。它们既不是业务 feature，也不是通用 UI。

## 5. 合并建议：哪些目录应该直接取消

建议逐步取消这些顶层目录：

- `data/`
- `domain/`
- `providers/`
- `repositories/`
- `services/`
- `ui/pages/`

它们的内容迁移方式如下：

- `data/api/*` -> 对应 feature 的 `data/`
- `data/models/*` -> 对应 feature 的 `data/models/`
- `providers/*` -> 对应 feature 的 `logic/`
- `repositories/*` -> 对应 feature 的 `data/`
- `services/live_socket_service.dart` -> `features/live/data/` 或 `features/live/logic/`
- `ui/pages/*` -> 对应 feature 的 `presentation/`
- `ui/theme/*` -> `app/theme/`
- `core/router/*` -> `app/router/`
- `i18n/*` -> `app/l10n/`

## 6. 页面、状态管理、数据层、通用组件等的合理归属

### 页面

放在 feature 内的 `presentation/`。

例如：

- `features/video/presentation/video_detail_page.dart`
- `features/profile/presentation/user_profile_page.dart`

### 页面私有组件

放在对应 feature 的 `presentation/widgets/`。

例如：

- `video_info_view.dart`
- `video_comments_view.dart`
- `profile_menu.dart`

如果只被一个页面使用，甚至可以直接与页面放在同级，不必强行再套多层目录。

### 状态管理

Riverpod 的 provider、controller、state 放在 feature 的 `logic/`。

例如：

- `features/video/logic/video_detail_controller.dart`
- `features/video/logic/video_detail_state.dart`

不要再单独放到全局 `providers/`。

### 数据层

与 feature 强相关的数据获取逻辑放在 feature 的 `data/`：

- api
- repository
- local data source
- DTO / model

例如视频相关：

- `video_api.dart`
- `video_repository.dart`
- `video_detail.dart`
- `play_url.dart`

都应收敛到 `features/video/data/`。

### 通用组件

只有满足这两个条件才放 `shared/widgets/`：

- 至少被两个以上 feature 使用
- 不带明显业务语义

适合放共享层的典型例子：

- `app_network_image.dart`
- `app_bottom_sheet.dart`
- `app_error_widget.dart`
- `app_shimmer.dart`
- `smart_paging_view.dart`

不适合放共享层的例子：

- `video_card.dart`
- `follow_button.dart`
- `profile_stat_item.dart`
- `user_tags.dart`

这些都带业务含义，应放回对应 feature。

### 工具类

按规则归属：

- 纯基础能力 -> `foundation/utils/`
- 强业务语义 -> feature 内部 `utils/` 或 `logic/`

例如：

- `format_utils.dart` 可放 `foundation/utils/`
- `danmaku_mask_parser.dart` 更适合 `features/video/` 或 `features/live/`
- `share_utils.dart` 如果主要服务视频分享，应移入 `features/video/logic/` 或 `presentation/`

### 路由

集中放 `app/router/`，但路由页面引用 feature。

可进一步优化为：

- `app_router.dart` 负责 `GoRouter`
- `app_routes.dart` 负责 typed routes

如果后续 feature 很多，也可以拆成：

- `app/router/routes/video_routes.dart`
- `app/router/routes/profile_routes.dart`

### 主题

属于应用级能力，放 `app/theme/`。

### 常量

归属规则要收紧：

- 全局配置常量 -> `foundation/config/`
- 只服务某个模块的常量 -> feature 内部

例如：

- `player_constants.dart` 应放 `features/video/`
- 不应放全局 `core/constants/`

### 网络层

底层网络客户端放 `foundation/network/`：

- `dio_client.dart`
- `interceptors/...`

但具体业务 API 定义不要放这里，应该跟 feature 走。

### 实体模型

当前项目不建议再保留一个薄弱的全局 `domain/entities/`。

建议规则：

- 接口返回模型、页面使用模型、feature 专属模型 -> 放 feature `data/models/`
- 真正跨模块复用的稳定模型，再考虑提升到 `shared/models/` 或 `foundation/`

如果一个模型只被一个 feature 使用，就不要上升到全局。

## 7. 哪些应该放在 feature 内，哪些才应该放在 shared/core/common

### 应该放在 feature 内部的内容

- 页面
- 页面私有组件
- feature 的 provider / controller / state
- feature 的 repository
- feature 的 api
- feature 的模型
- feature 专属 hooks
- feature 专属 constants
- feature 专属 utils
- feature 专属 service

判断标准只有一个：

**离开这个 feature，文件是否仍然成立。**

如果答案是否定的，就不应该提升到共享层。

### 只应放在 `shared/` 或 `foundation/` 的内容

- 与业务无关的基础设施
- 多个 feature 已稳定复用的通用组件
- 全局主题、路由、启动流程
- 全局错误处理、结果类型、存储封装、网络封装

### 不该滥用的目录

不建议再新增：

- `common/`
- `base/`
- `helpers/`
- `utils/` 这种没有范围说明的大杂烩目录

如果必须有 `utils/`，要么放在 `foundation/utils/`，要么放在具体 feature 内部。

## 8. 推荐的 feature 内部结构粒度

不要给所有 feature 强制套同一个复杂模板。建议按规模分级：

### 小 feature

```text
features/scanner/
├── scanner_page.dart
└── scanner_provider.dart
```

### 中等 feature

```text
features/history/
├── data/
├── logic/
└── presentation/
```

### 大 feature

```text
features/video/
├── data/
│   ├── models/
│   ├── video_api.dart
│   └── video_repository.dart
├── logic/
├── presentation/
│   ├── hooks/
│   └── widgets/
└── player/
```

对于 `video`、`notification`、`dynamic` 这类复杂模块，可以在 feature 内允许一层业务子域，但不要继续无节制下钻。

## 9. 从旧结构迁移到新结构的具体步骤

建议按下面顺序迁移，风险最低。

### 第一步：先建立新骨架，不立即全量搬迁

先创建：

- `lib/app/`
- `lib/foundation/`
- `lib/shared/`
- `lib/features/`
- `lib/integrations/`

目标是让新结构先落地，再分批迁移代码。

### 第二步：迁移应用装配层

先移动低风险文件：

- `app.dart` -> `app/app.dart`
- `core/router/*` -> `app/router/`
- `ui/theme/*` -> `app/theme/`
- `i18n/*` -> `app/l10n/`

同时调整 `main.dart` 的引用。

### 第三步：迁移底层基础设施

将真正基础设施收敛到 `foundation/`：

- `core/errors/*`
- `core/types/result.dart`
- `data/network/*`
- `core/constants/*`
- `core/providers` 中与存储/网络初始化相关的 provider

注意：

- 如果某个 provider 明显属于某个 feature，不要一起迁进基础层

### 第四步：按 feature 逐个迁移，不要横向一次搬完

优先顺序建议：

1. `settings`
2. `history`
3. `ranking`
4. `search`
5. `favorites`
6. `profile`
7. `notification`
8. `dynamic`
9. `video`
10. `live`

原因：

- 从简单模块开始，先验证目录策略
- 最后再处理复杂模块，避免前期方案不稳定

### 第五步：每迁一个 feature，就完成整链路收敛

以 `video` 为例，一次性迁移：

- `ui/pages/video/*`
- `providers/video/*`
- `repositories/video_repository.dart`
- `repositories/danmaku_repository.dart`
- `data/api/video_api.dart`
- `data/api/danmaku_api.dart`
- `data/models/video/*`
- `data/models/comment/*` 中仅视频使用的部分

迁移完成后，保证“视频相关代码主要只在 `features/video/` 内查找”。

### 第六步：清理被掏空的旧目录

迁移完成一个 feature 后，及时删除空目录：

- `providers/video/`
- `ui/pages/video/`
- `data/models/video/`

不要让新旧结构长期并存，否则会出现双轨维护。

### 第七步：最后再处理共享提炼

当两个或更多 feature 出现重复实现时，再提炼到 `shared/`。

不要在重构第一阶段就急着抽公共组件，否则很容易把 feature 私有逻辑误抽出去。

## 10. 针对当前项目的具体落点建议

### `video`

这是当前最典型的“被拆散的 feature”，建议优先作为样板模块重构。

应收敛的内容包括：

- 页面
- 播放器控件
- 评论 UI
- 播放状态
- subtitle / player controller
- video api / repository
- video models
- danmaku 相关实现

尤其是：

- `ui/widgets/danmaku/ns_danmaku/...`

更适合迁到：

- `features/video/presentation/widgets/danmaku/`

如果直播也共用，则再抽成：

- `shared/widgets/danmaku/`

### `notification`

建议把通知列表、聊天、私信 session 统一收敛到一个 feature，下设：

- `presentation/`
- `logic/`
- `data/`

不要继续让聊天相关能力散落在 provider 和页面两个横向层。

### `profile`、`relation`、`user_space`

这三块强关联，建议按“用户域”思路整理：

- `profile/` 保留个人主页和用户主页
- `relation/` 如果只服务用户页，可以并入 `profile/`
- `user_space` 如果只是用户视频/动态的一部分，也应并入 `profile/`

### `home`

当前 `home` 下还包了 `live` 和 `weekly` 子目录，建议按业务拆回独立 feature：

- `home`：推荐、热门、主 tab
- `live`：直播列表、直播间
- `ranking`：排行榜
- `weekly`：如果只是一个入口页面，可并回 `home` 或 `ranking`

### `settings`

是很适合作为首批迁移样板的 feature，结构可以很简单。

## 11. 重构后的直接收益

完成后会得到以下结果：

- 结构更直观：开发者优先按业务找代码，不再先猜技术层
- 查找文件更快：一个功能的大多数文件集中在同一个 feature
- 模块边界更清晰：公共层职责收窄，不再泛滥
- 维护成本更低：新增功能时不必同时改多个横向目录
- 扩展成本更低：新 feature 可以直接复制简单模板，不用进入过度分层

## 12. 最终执行原则

后续新增文件时，严格遵循以下原则：

1. 先问“它属于哪个业务模块”，再决定路径。
2. 只有跨多个 feature 稳定复用，才提升到 `shared/`。
3. 只有真正底层无业务语义，才放进 `foundation/`。
4. 小 feature 不强制三层，大 feature 才允许适度细分。
5. 不再新增模糊目录名，例如 `common`、`helpers`、`base`。

---

如果你准备开始真正落地重构，建议第一批直接处理 `settings -> history -> ranking -> video`。这样可以先验证迁移方式，再把最复杂的 `video` 模块作为标准模板固定下来。
