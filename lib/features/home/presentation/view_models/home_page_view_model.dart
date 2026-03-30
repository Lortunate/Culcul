import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_page_view_model.freezed.dart';
part 'home_page_view_model.g.dart';

@freezed
sealed class HomePageState with _$HomePageState {
  const factory HomePageState({@Default(0) int syncToken, @Default(0) int tabIndex}) =
      _HomePageState;
}

@Riverpod(keepAlive: true)
class HomePageViewModel extends _$HomePageViewModel {
  @override
  HomePageState build() => const HomePageState();

  void onTabTapped(int index, {required bool isChanging}) {
    if (isChanging) return;
    state = state.copyWith(tabIndex: index, syncToken: state.syncToken + 1);
  }
}
