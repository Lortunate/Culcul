# Culcul 合并总计划 + PLAN16（下一阶段执行版）

## Summary
- 将 `PLAN.md` 到 `PLAN15.md` 合并为一条主线：先统一边界与错误流，再做 API 收敛与并发化，最后完成性能与结构收口。
- 目标不变：不做兼容层、不换技术栈、一次性收敛历史分叉实现。
- 下一计划定义为 `PLAN16`，用于把前 15 版中的“未完全闭环项”一次落地并验收。

## Implementation Changes
1. 主计划（合并版）固定执行顺序  
- 阶段 A：架构边界收敛  
  - 固化 feature-first 三层边界，禁止 `presentation -> data`、禁止跨 feature domain 直引。  
  - 跨模块共享统一走 `core/contracts`，并保持纯结构（无 JSON 注解、无 UI 格式化逻辑）。  
- 阶段 B：错误流与 Result 统一  
  - 远程仓储接口统一为 `Future<Result<T, AppError>>`。  
  - 页面/状态层统一只使用 `AppError`，移除 `AppException` 暴露与 throw 驱动 UI。  
  - `RequestExecutor` 作为唯一请求执行与错误映射入口。  
- 阶段 C：API 语义化与去冗余  
  - 删除透传 workflow、重复 mapper、无语义参数与中转导出。  
  - 魔法参数替换为语义类型（关系动作、评论排序、清晰度、动态流类型、私信类型等）。  
- 阶段 D：并发化与分页一致性  
  - 建立统一并发执行器（限流 + 首错快速失败 + optional 降级）。  
  - 全仓分页入口统一 `PaginationLoadGate`/触底触发器，消除重复并发加载与 footer 语义不一致。  
- 阶段 E：性能与结构收口  
  - 优先优化视频链路（弹幕、字幕、手势、控制层重建）。  
  - 完成热点大文件按职责拆分，删除壳层与死代码，降低重建与维护成本。  

2. `PLAN16`（下一阶段，执行闭环）  
- 批次 1：阻断继续分叉（必须先做）  
  - 全量替换 state/view_model 中 `AppException` 为 `AppError`。  
  - 清零 presentation 层 `throw ...toException()` 与 `throw Exception(...)`。  
  - 清零远程 repository 裸 `Future<T>` / `Future<void>`。  
- 批次 2：性能热点二次落地  
  - 弹幕时间线改批量 merge（保留 seek/预加载语义）。  
  - 搜索建议改列表级动画，移除逐 item 重动画。  
  - 评论图片加按展示尺寸解码约束。  
  - Profile/Live/Notification/Dynamic 按并发策略改受控并发。  
- 批次 3：结构与文件收口  
  - 拆分 `dynamic_repository_impl`、`danmaku_layer`、`article_detail_parser`、`favorite_detail_page` 等热点文件。  
  - 删除 `features/*/domain.dart`、`features/*/presentation.dart`、`*_providers.dart` 等低价值入口（保留 `<feature>.dart` + `feature_scope.dart` + `route_entry.dart`）。  
- 批次 4：门禁与数据闭环  
  - 升级 `architecture_guard`（错误流、边界、目录、接口规则）。  
  - 统一 perf 对比脚本输出文本+JSON，要求 before/after 可复现对比。  

## Public API / Interface Changes
- 统一破坏性变更（无兼容层）：
- 远程仓储：`Future<Result<T, AppError>>`。
- 状态错误类型：`AppError`（移除 `AppException` 暴露）。
- feature 公共导入：仅 `<feature>.dart`。
- 路由与仓储入参：语义化类型/参数对象替代魔法值。
- 错误展示：统一错误组件协议（查看详情 + 重试）。

## Test Plan
- 每批次必跑：`build_runner`、`architecture_guard`、`flutter analyze`、受影响测试子集。  
- `PLAN16` 完成验收门槛：  
- `architecture_guard` 0 失败；`flutter analyze` 0 issue。  
- presentation throw 模式 = 0；远程 repository 裸返回 = 0。  
- 列表 `load_trigger/load_complete` 比值 <= 1.10。  
- 视频/列表关键性能无回退，且至少 2 项指标达到改进阈值（首屏/首帧/卡顿率）。  
- 非生成文件体量目标：`>=300` 行文件 `11 -> <=6`，`>=200` 行文件 `39 -> <=30`。  

## Assumptions
- 仅合并你点名的 `PLAN.md` 到 `PLAN15.md`；未纳入 `PLAN-MINNOW*`。  
- 不新增框架，不改路由语义与业务规则，仅收敛结构/API/错误流与性能路径。  
- `PLAN16` 作为下一份计划文件名与执行入口（建议文件名：`PLAN16.md`）。  
