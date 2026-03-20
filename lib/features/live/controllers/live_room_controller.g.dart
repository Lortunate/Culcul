// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_room_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LiveRoomController)
final liveRoomControllerProvider = LiveRoomControllerFamily._();

final class LiveRoomControllerProvider
    extends $NotifierProvider<LiveRoomController, LiveRoomState> {
  LiveRoomControllerProvider._({
    required LiveRoomControllerFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'liveRoomControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$liveRoomControllerHash();

  @override
  String toString() {
    return r'liveRoomControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  LiveRoomController create() => LiveRoomController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LiveRoomState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LiveRoomState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is LiveRoomControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$liveRoomControllerHash() =>
    r'1d48930e18e387ab8deb6d47455b4ae59613af4e';

final class LiveRoomControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          LiveRoomController,
          LiveRoomState,
          LiveRoomState,
          LiveRoomState,
          int
        > {
  LiveRoomControllerFamily._()
    : super(
        retry: null,
        name: r'liveRoomControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  LiveRoomControllerProvider call(int roomId) =>
      LiveRoomControllerProvider._(argument: roomId, from: this);

  @override
  String toString() => r'liveRoomControllerProvider';
}

abstract class _$LiveRoomController extends $Notifier<LiveRoomState> {
  late final _$args = ref.$arg as int;
  int get roomId => _$args;

  LiveRoomState build(int roomId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<LiveRoomState, LiveRoomState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<LiveRoomState, LiveRoomState>,
              LiveRoomState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
