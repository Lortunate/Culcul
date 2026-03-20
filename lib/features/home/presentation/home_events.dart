import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_events.g.dart';

class HomeTabTapEvent {
  final int index;
  final int timestamp;

  HomeTabTapEvent(this.index)
    : timestamp = DateTime.now().millisecondsSinceEpoch;
}

@riverpod
class HomeTabTap extends _$HomeTabTap {
  @override
  HomeTabTapEvent? build() {
    return null;
  }

  void update(HomeTabTapEvent event) {
    state = event;
  }
}
