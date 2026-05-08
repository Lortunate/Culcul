import 'package:culcul/core/session/feature_action_providers.dart';
import 'package:culcul/features/to_view/application/watch_later_adapter.dart';
import 'package:riverpod/misc.dart' show Override;

export 'data/to_view_repository_impl.dart' show toViewRepositoryProvider;

class ToViewFeatureScope {
  const ToViewFeatureScope._();

  static List<Override> overrides() {
    return [
      watchLaterActionsProvider.overrideWith((ref) {
        return WatchLaterAdapter(ref);
      }),
    ];
  }
}
