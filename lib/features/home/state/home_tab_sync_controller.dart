import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_tab_sync_controller.freezed.dart';
part 'home_tab_sync_controller.g.dart';

@freezed
sealed class HomeTabSyncState with _$HomeTabSyncState {
  const factory HomeTabSyncState({@Default(0) int syncToken, @Default(0) int tabIndex}) =
      _HomeTabSyncState;
}

@Riverpod(keepAlive: true)
class HomeTabSyncController extends _$HomeTabSyncController {
  @override
  HomeTabSyncState build() => const HomeTabSyncState();

  void onTabTapped(int index, {required bool isChanging}) {
    if (isChanging) {
      return;
    }
    state = state.copyWith(tabIndex: index, syncToken: state.syncToken + 1);
  }
}
