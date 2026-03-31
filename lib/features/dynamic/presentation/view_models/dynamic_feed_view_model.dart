import 'package:culcul/features/dynamic/domain/entities/dynamic_entities.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:culcul/features/dynamic/application/dynamic_workflows.dart';

mixin DynamicFeedController {
  Ref get ref;
  AsyncValue<List<DynamicItem>> get state;
  set state(AsyncValue<List<DynamicItem>> value);

  Future<void> toggleLike(String id, bool isLiked) async {
    final previousState = state;
    final items = previousState.asData?.value;
    if (items == null) {
      return;
    }

    final index = items.indexWhere((item) => item.idStr == id);
    if (index == -1) {
      return;
    }

    final updatedItem = _buildLikedItem(items[index], isLiked);
    if (updatedItem == null) {
      return;
    }

    final nextItems = List<DynamicItem>.from(items);
    nextItems[index] = updatedItem;
    state = AsyncData(nextItems);

    final result = await ref
        .read(toggleDynamicLikeWorkflowProvider)
        .call(id: id, newStatus: !isLiked);
    if (result.isFailure) {
      state = previousState;
    }
  }

  DynamicItem? _buildLikedItem(DynamicItem item, bool isLiked) {
    if (item.modules.moduleStat?.like == null) {
      return null;
    }
    return item.copyWithLike(!isLiked);
  }
}
