import 'package:culcul/features/home/data/home_feed_data_source.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_facade.g.dart';

@riverpod
HomeFacade homeFacade(Ref ref) {
  return HomeFacade(ref.watch(homeFeedDataSourceProvider));
}

class HomeFacade {
  HomeFacade(this._dataSource);

  final HomeFeedDataSource _dataSource;

  // Re-expose needed methods or providers if any.
  // For now it might just be a holder.
}
