## 全项目统一错误组件改造计划（无旧版兼容）

### Summary
- 将 `AppErrorWidget` 升级为全项目唯一的“可见错误展示组件”，统一行为为：打印错误日志、展示简短错误信息、始终提供“查看详情”和“重试”按钮。
- 统一错误展示与日志逻辑收口到组件内部，移除页面层分散的错误打印与自定义错误 UI。
- 同步拆分空状态与错误状态，避免继续用错误组件承载 `no_content` 等非错误语义。

### Key Changes
- 组件与接口改造（核心变更）
  - 在 [app_error_widget.dart](/d:/Projects/Flutter/Culcul/lib/ui/widgets/app_error_widget.dart) 中重构 `AppErrorWidget`：
    - `error`、`onRetry` 改为必填。
    - 保留 `stackTrace`，新增紧凑布局参数（`compact`/`variant`）。
    - 删除 `message` 入参（不再兼容旧用法）。
    - 组件内部统一触发日志打印（去重策略：同一错误签名仅打印一次，避免 rebuild 噪音）。
- 错误信息与日志策略收敛
  - 在 [error_handler.dart](/d:/Projects/Flutter/Culcul/lib/core/errors/error_handler.dart) 增加统一能力：
    - `getShortErrorMessage(...)`：首行提取 + 120 字截断。
    - `buildErrorDetails(...)`：生成完整详情文本（原始错误、类型、堆栈）。
    - `logError(...)`：统一 `debugPrint` 结构化输出。
- 空状态拆分
  - 新增统一空状态组件（`AppEmptyStateWidget`），替换 `AppErrorWidget(message: ...)` 旧写法。
  - 在 [content.dart](/d:/Projects/Flutter/Culcul/lib/ui/widgets/smart_paging_view/content.dart) 将 empty 分支改为空状态组件。
- 全量迁移可见错误入口
  - 替换仍使用 `Text/Column/ElevatedButton` 的错误块为 `AppErrorWidget`，覆盖搜索、排行、动态、通知、首页、视频等可见错误场景。
  - 所有能拿到 `stack` 的 `error: (err, stack)` 分支统一传入 `stackTrace`。
  - 删除已被组件接管的页面级重复 `debugPrint`。
  - 小区域（如热搜块）统一使用 compact 形态，同时保留“查看+重试”按钮。

### Test Plan
- 新增 `AppErrorWidget` 组件测试：
  - 展示短错误信息（首行+120 截断）。
  - 始终渲染“查看详情”“重试”按钮。
  - 点击“查看详情”弹出对话框并显示完整错误与堆栈。
  - 点击“重试”触发回调。
  - compact 形态下按钮仍可见。
  - 同一错误重复 build 不重复刷日志。
- 回归测试：
  - `SmartPagingView` empty 分支改为 `AppEmptyStateWidget`。
  - 抽样验证至少 2 个已迁移页面的错误分支渲染统一组件。
- 质量检查：
  - `flutter analyze`（先对改动文件，后全量）。
  - `flutter test`（至少执行 `test/smart_paging_view_test.dart` + 新增错误组件测试）。

### Assumptions
- 仅统一“可见错误占位”；当前故意静默的 `SizedBox.shrink` 错误分支保持不变。
- `PrivacyErrorWidget` 等非错误语义组件保留。
- 日志统一使用 `debugPrint`（组件内集中打印）。
- 不做旧 API 兼容：移除 `AppErrorWidget(message: ...)` 并一次性修正调用点，清理历史遗留混用。
