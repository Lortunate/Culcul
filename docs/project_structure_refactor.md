# Culcul 目录结构重构方案

## 1. 基于当前代码的结论

这次重构的核心问题，不是单纯“目录层级深”，而是项目已经进入**半迁移、双轨并存**状态：

- 应用装配层已经迁到 `lib/app/`
- `settings`、`history`、`ranking`、`search`、`favorites`、部分 `video` 已迁到 `lib/features/`
- 但主路由 `lib/app/router/app_routes.dart` 仍然大量引用 `lib/ui/pages/*`
- `providers/`、`repositories/`、`data/api/`、`data/models/` 仍是主数据来源

这意味着现在最大的结构性问题不是“目录多”，而是：

1. 同一业务被拆散在多个横向目录
2. 新旧结构同时有效，维护成本翻倍
3. 某些 feature 已迁一半，职责边界反而更模糊

换句话说，当前项目最需要的是**完成收口**，而不是继续增加一套更复杂的新分层。

---

## 2. 当前结构的主要问题

### 2.1 顶层按技术分层，业务链路被打散

当前 `lib/` 顶层同时存在：

- `app/`
- `core/`
- `data/`
- `domain/`
- `features/`
- `providers/`
- `repositories/`
- `services/`
- `shared/`
- `ui/`

以视频功能为例，相关代码分散在：

- `ui/pages/video/*`
- `features/video/*`
- `providers/video/*`
- `repositories/video_repository.dart`
- `repositories/danmaku_repository.dart`
- `data/api/video_api.dart`
- `data/api/danmaku_api.dart`
- `data/models/video/*`
- `data/models/comment/*`

这是典型的低内聚结构。改一个业务，需要跨 5 到 8 个目录跳转。

### 2.2 新旧结构双轨并存

当前路由文件同时引用：

- 新结构：`features/*`
- 旧结构：`ui/pages/*`
- 旧模型：`data/models/*`

这会带来三个直接问题：

- 开发者不知道新增文件该放 `features` 还是 `ui/pages`
- 同类状态逻辑可能同时存在于 `features/*/logic` 与 `providers/*`
- 后续重构不再是“搬家”，而是在双轨之间来回复制

### 2.3 `core/shared/ui` 的边界不清

当前公共能力被分散在：

- `core/utils`
- `core/widgets`
- `core/services`
- `shared/extensions`
- `ui/widgets`
- `ui/theme`

这不是“公共层丰富”，而是“公共层失控”。

例如下面这些文件并不适合留在全局共享层：

- `ui/widgets/video_card.dart`
- `ui/widgets/follow_button.dart`
- `ui/widgets/profile_stat_item.dart`
- `ui/widgets/user_tags.dart`
- `core/utils/danmaku_mask_parser.dart`

它们都带有明显业务语义，应回收到 feature 内部。

### 2.4 目录深度超过实际收益

典型例子：

- `ui/pages/video/widgets/controls/bottom_bar/*`
- `ui/pages/profile/widgets/home_tab/*`
- `ui/pages/dynamic/widgets/content/*`
- `ui/pages/notification/widgets/chat/*`

这些路径很多都已经超过四层。对实际维护而言，问题不是“文件太多”，而是“打开目录之后还是目录”。

### 2.5 `domain/` 过薄，不足以支撑独立分层

当前 `domain/entities` 非常薄，无法支撑完整 DDD 或 clean architecture 分层收益。继续保留 `domain`，只会让结构看起来“正规”，但不会让项目更简单。

### 2.6 有效 feature 与 feature 之间边界仍不稳定

几个明显交叉点：

- `profile`、`relation`、`user_space`
- `home`、`live`、`weekly`
- `notification`、`chat`、`private_session`
- `video` 与全局 `ui/widgets/danmaku`

说明 feature 划分目前还没有完全基于业务心智。

---

## 3. 重构原则

本项目建议坚持以下原则：

1. 高内聚：同一业务的页面、状态、数据访问尽量放在一个模块里
2. 低耦合：feature 之间通过路由、共享组件、少量稳定模型协作，不直接横向依赖实现细节
3. 按功能组织：优先按“用户能感知的业务模块”组织，而不是按“技术类别”组织
4. 避免过度设计：不要为了分层而分层，小模块允许保持简单
5. 先收口再抽象：先把业务收回 feature，再决定哪些内容真的值得上升到共享层

---

## 4. 目标目录结构

推荐将 `lib/` 收敛为下面这套骨架：

```text
lib/
├── app/
│   ├── app.dart
│   ├── bootstrap.dart
│   ├── router/
│   │   ├── app_router.dart
│   │   ├── app_routes.dart
│   │   └── transitions.dart
│   └── theme/
│       ├── app_theme.dart
│       ├── app_colors.dart
│       ├── app_text_theme.dart
│       └── app_component_theme.dart
├── foundation/
│   ├── config/
│   ├── errors/
│   ├── network/
│   │   ├── dio_client.dart
│   │   └── interceptors/
│   ├── storage/
│   ├── result/
│   └── utils/
├── shared/
│   ├── widgets/
│   ├── extensions/
│   ├── services/
│   └── models/
├── features/
│   ├── auth/
│   ├── home/
│   ├── dynamic/
│   ├── video/
│   ├── live/
│   ├── profile/
│   ├── notification/
│   ├── search/
│   ├── ranking/
│   ├── favorites/
│   ├── history/
│   ├── settings/
│   ├── scanner/
│   └── to_view/
├── integrations/
│   └── protos/
├── i18n/
└── main.dart
```

### 4.1 顶层目录职责

#### `app/`

只负责应用装配：

- 根应用 Widget
- 全局路由
- Theme
- 启动初始化编排

这里不承载业务逻辑。

#### `foundation/`

只放跨 feature 的基础设施：

- 网络客户端与拦截器
- 存储适配
- 全局异常
- 结果类型
- 配置常量
- 无业务语义的工具函数

#### `shared/`

只放稳定复用的共享内容：

- 纯通用 UI 组件
- 跨 feature 扩展方法
- 跨 feature 服务
- 真正稳定的共享模型

判断标准很严格：至少两个 feature 已稳定使用，且不携带明显业务语义。

#### `features/`

这是主战场。每个 feature 自己管理：

- 页面
- 页面局部组件
- provider / controller / state
- repository / api / local data source
- feature 专属 model / utils / constants

#### `integrations/`

放协议文件和第三方生成代码，例如 protobuf。

#### `i18n/`

当前项目已经有成熟生成链路，建议暂时保留在顶层，不强制搬进 `app/`。这样改动更小，也更符合 Flutter 社区常见习惯。

---

## 5. feature 内部推荐粒度

不是每个 feature 都必须长成同一个模板。

### 小 feature

适用于 `scanner`、`to_view` 这类轻模块：

```text
features/scanner/
├── scanner_page.dart
└── scanner_route.dart
```

### 中等 feature

适用于 `history`、`settings`、`ranking`：

```text
features/history/
├── data/
├── logic/
└── presentation/
```

### 大 feature

适用于 `video`、`dynamic`、`notification`、`profile`、`live`：

```text
features/video/
├── data/
│   ├── api/
│   ├── models/
│   ├── repositories/
│   └── services/
├── logic/
├── presentation/
│   ├── pages/
│   ├── widgets/
│   └── hooks/
└── player/
```

注意：大 feature 允许内部再分一层业务子域，但不要继续纵向细拆到五六层。

---

## 6. 面向当前项目的目标模块划分

### 6.1 `auth`

收拢：

- `ui/pages/auth/*`
- `repositories/auth_repository.dart`
- `data/api/auth_api.dart`
- `domain/entities/country_code.dart`

### 6.2 `home`

只保留首页主 tab、本地交互、推荐与热门聚合：

- `ui/pages/home/home_page.dart`
- `ui/pages/home/widgets/*`
- `ui/pages/home/logic/home_scroll_manager.dart`
- `providers/home/home_popular_provider.dart`
- `providers/home/home_recommend_provider.dart`
- `repositories/home_repository.dart`
- `data/models/feed/*`

`weekly` 不建议长期挂在 `home/weekly/` 下，如果只是首页入口，可作为 `home/presentation/pages/weekly_page.dart`。

### 6.3 `dynamic`

收拢：

- `ui/pages/dynamic/*`
- `providers/dynamic/*`
- `repositories/dynamic_repository.dart`
- `data/api/dynamic_api.dart`
- `data/models/dynamic/*`

### 6.4 `video`

这是最关键的样板模块，应完整收口：

- `features/video/*`
- `ui/pages/video/*`
- `providers/video/*`
- `repositories/video_repository.dart`
- `repositories/danmaku_repository.dart`
- `data/api/video_api.dart`
- `data/api/danmaku_api.dart`
- `data/models/video/*`
- `data/models/comment/*`
- `data/models/subtitle*`
- `ui/widgets/danmaku/*`
- `core/utils/danmaku_mask_parser.dart`

建议目标结构：

```text
features/video/
├── data/
│   ├── api/
│   ├── models/
│   ├── repositories/
│   └── services/
├── logic/
├── presentation/
│   ├── pages/
│   ├── widgets/
│   └── hooks/
└── player/
```

其中：

- `player/` 放播放器专属状态、常量、控制层、覆盖层
- 评论相关 UI 可放 `presentation/widgets/comments/`
- 详情信息相关 UI 可放 `presentation/widgets/info/`
- 若弹幕能力未来被 `live` 共用，再上提到 `shared/widgets/danmaku/`

### 6.5 `live`

收拢：

- `ui/pages/live/*`
- `ui/pages/home/live/*`
- `providers/live/*`
- `services/live_socket_service.dart`
- `repositories/live_repository.dart`
- `data/api/live_api.dart`
- `data/models/live/*`

直播列表和直播间都应归入 `features/live/`，不要一半挂在首页，一半单独存在。

### 6.6 `profile`

建议将“用户域”并成一个 feature，而不是继续拆散：

- `ui/pages/profile/*`
- `ui/pages/relation/*`
- `providers/profile/*`
- `providers/relation/*`
- `providers/user_space/*`
- `repositories/profile_repository.dart`
- `repositories/relation_repository.dart`
- `data/api/profile_api.dart`
- `data/api/relation_api.dart`
- `data/models/user/*`
- `data/models/relation/*`

推荐结构：

```text
features/profile/
├── data/
├── logic/
├── presentation/
│   ├── pages/
│   ├── tabs/
│   └── widgets/
└── relation/
```

如果后面证明 `relation` 可独立演化，再拆出去；当前阶段先并入更符合“高内聚”。

### 6.7 `notification`

建议统一为一个“消息中心”模块：

- `ui/pages/notification/*`
- `providers/notification/*`
- `repositories/notification_repository.dart`
- `data/api/notification_api.dart`
- `data/models/notification/*`

聊天、私信 session、点赞/回复/系统通知都不要再散落在不同横向层。

### 6.8 已迁移中的模块

以下模块已经有 `features/*` 雏形，但尚未彻底收口：

- `favorites`
- `history`
- `ranking`
- `search`
- `settings`

这些模块的优先任务不是“继续优化层次”，而是：

1. 迁完残余依赖
2. 删除旧目录同名实现
3. 统一导入方向

---

## 7. 哪些内容该放 feature，哪些才该放 shared/foundation

### 7.1 应该留在 feature 内的内容

- 页面
- 页面私有 widgets
- hooks
- provider / controller / state
- repository
- api
- local cache
- feature model
- feature constants
- feature utils

判断标准：

如果文件脱离该业务就失去意义，它就不应该放到共享层。

### 7.2 应该进入 `shared/` 的内容

建议仅保留这类真正通用的东西：

- `app_network_image.dart`
- `app_bottom_sheet.dart`
- `app_error_widget.dart`
- `app_shimmer.dart`
- `smart_paging_view.dart`
- `refresh_header_footer.dart`
- `format_extensions.dart`

### 7.3 不建议继续挂在共享层的内容

应逐步回收进对应业务模块：

- `video_card.dart`
- `video_list_card.dart`
- `video_thumbnail.dart`
- `follow_button.dart`
- `profile_stat_item.dart`
- `user_tags.dart`
- `guest_view.dart`

这些组件都具有明确业务语义，不是纯共享组件。

### 7.4 应该进入 `foundation/` 的内容

建议迁入：

- `core/constants/*` 中真正全局的配置
- `core/errors/*`
- `core/types/result.dart`
- `data/network/*`
- `core/providers` 中与存储、网络初始化直接相关的 provider

### 7.5 暂不建议保留的顶层目录

最终目标是清空并删除：

- `domain/`
- `providers/`
- `repositories/`
- `services/`
- `ui/pages/`
- `data/api/`
- `data/models/`

如果某个目录还存在，只能表示“迁移尚未完成”，不能作为长期结构。

---

## 8. 旧结构到新结构的映射规则

### 8.1 通用映射

- `ui/pages/<feature>/*` -> `features/<feature>/presentation/*`
- `providers/<feature>/*` -> `features/<feature>/logic/*`
- `repositories/<feature>_repository.dart` -> `features/<feature>/data/repositories/*`
- `data/api/<feature>_api.dart` -> `features/<feature>/data/api/*`
- `data/models/<feature>/*` -> `features/<feature>/data/models/*`

### 8.2 基础设施映射

- `core/errors/*` -> `foundation/errors/*`
- `data/network/*` -> `foundation/network/*`
- `core/types/result.dart` -> `foundation/result/result.dart`
- `core/constants/*` -> `foundation/config/*`
- `core/providers/shared_preferences_provider.dart` -> `foundation/storage/`
- `core/providers/storage_provider.dart` -> `foundation/storage/`
- `core/providers/cookie_jar_provider.dart` -> `foundation/storage/`
- `core/providers/cache_store_provider.dart` -> `foundation/storage/`

### 8.3 共享能力映射

- `ui/widgets/*` 中纯通用组件 -> `shared/widgets/*`
- `shared/extensions/*` 保持不变
- `core/services/audio_handler.dart` -> `shared/services/audio_handler.dart`
- `core/services/media_service.dart` -> `shared/services/media_service.dart`

### 8.4 协议与生成物映射

- `protos/*` -> `integrations/protos/*`

并清理当前这种重复嵌套：

- `lib/protos/lib/protos/*`

这类结构必须消除，否则后续生成链路会继续制造噪音。

---

## 9. 推荐迁移顺序

不建议一次性物理搬动全项目。正确顺序是“先完成已开始的迁移，再做复杂模块”。

### 阶段 1：冻结新旧双轨

规则立即生效：

1. 新代码只允许进入 `features/`、`shared/`、`foundation/`
2. `ui/pages`、`providers`、`repositories`、`data/api`、`data/models` 不再新增业务文件
3. 所有新路由只指向 `features/*`

这是重构成功的前提。

### 阶段 2：完成已部分迁移的模块

顺序建议：

1. `settings`
2. `history`
3. `ranking`
4. `search`
5. `favorites`

原因：

- 这些模块已经有 `features/*` 目录
- 规模较小，适合验证策略
- 完成后可以快速减少双轨面积

### 阶段 3：收口应用装配层

处理：

- `app_routes.dart` 中所有 `ui/pages/*` 依赖
- 统一导入 `features/*`
- 视情况拆分路由文件，例如：
  - `app/router/routes/home_routes.dart`
  - `app/router/routes/video_routes.dart`
  - `app/router/routes/profile_routes.dart`

### 阶段 4：按业务域处理复杂模块

顺序建议：

1. `profile`
2. `notification`
3. `dynamic`
4. `live`
5. `video`

其中 `video` 应作为最终样板，因为它交叉最多、最能暴露结构问题。

### 阶段 5：回收共享层与基础层

当 feature 收口完成后，再做：

- 识别真正可复用组件
- 回收 `ui/widgets` 到 `shared/widgets`
- 回收基础能力到 `foundation`
- 删除空目录

不要在 feature 尚未收口前过早抽公共组件。

---

## 10. 单个 feature 的迁移动作模板

以任意 feature 为例，建议每次迁移都按这 7 步执行：

1. 在 `features/<feature>/` 下建目标目录
2. 先搬 `presentation`
3. 再搬 `logic`
4. 再搬 `data`
5. 修正 imports 和 exports
6. 修改路由与上层调用
7. 删除旧目录与旧文件

关键原则：

- 一个 feature 迁完，就立刻删除旧实现
- 不允许长期保留“同一职责两份代码”

---

## 11. 对当前项目最值得优先执行的样板

### 第一批

- `settings`
- `history`
- `ranking`
- `search`
- `favorites`

目标：

- 把已存在的 `features/*` 做完整
- 把旧依赖从路由和调用处完全切断

### 第二批

- `profile`
- `notification`

目标：

- 按“用户域”和“消息域”完成合并

### 第三批

- `dynamic`
- `live`
- `video`

目标：

- 清理最深层级目录
- 清理播放器、弹幕、评论等交叉实现
- 最终移除 `ui/pages/video` 与 `providers/video`

---

## 12. 最终落地标准

当下面这些条件同时满足，说明重构完成：

1. `app_routes.dart` 不再导入 `ui/pages/*`
2. `providers/` 顶层目录被清空并删除
3. `repositories/` 顶层目录被清空并删除
4. `data/api/` 与 `data/models/` 被 feature 内部目录替代
5. `domain/` 不再存在
6. `ui/widgets/` 只剩真正共享组件，或被完全替换为 `shared/widgets/`
7. 新增功能时，开发者可以先定位 feature，再在 feature 内完成绝大多数修改

---

## 13. 一句话执行策略

对这个项目，最正确的方向不是继续叠加抽象层，而是：

**以 `features` 为中心完成收口，清理双轨结构，压缩顶层目录，把共享层和基础层收紧到真正必要的范围。**
