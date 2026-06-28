import 'package:culcul/features/dynamic/application/models/dynamic_response.dart';
import 'package:culcul/features/dynamic/application/models/dynamic_item_extensions.dart';
import 'package:culcul/features/dynamic/data/dynamic_repository_impl.dart';
import 'package:riverpod/riverpod.dart';

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

    final item = items[index];
    if (item.modules.moduleStat?.like == null) {
      return;
    }
    final updatedItem = item.copyWithLike(!isLiked);

    final nextItems = List<DynamicItem>.from(items);
    nextItems[index] = updatedItem;
    state = AsyncData(nextItems);

    final result = await ref.read(dynamicRepositoryProvider).likeDynamic(id, !isLiked);
    if (result.isFailure) {
      state = previousState;
    }
  }
}
