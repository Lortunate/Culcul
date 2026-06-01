// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_danmaku_feed_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LiveDanmakuFeedController)
final liveDanmakuFeedControllerProvider = LiveDanmakuFeedControllerFamily._();

final class LiveDanmakuFeedControllerProvider
    extends $NotifierProvider<LiveDanmakuFeedController, LiveDanmakuFeedState> {
  LiveDanmakuFeedControllerProvider._({
    required LiveDanmakuFeedControllerFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'liveDanmakuFeedControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$liveDanmakuFeedControllerHash();

  @override
  String toString() {
    return r'liveDanmakuFeedControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  LiveDanmakuFeedController create() => LiveDanmakuFeedController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LiveDanmakuFeedState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LiveDanmakuFeedState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is LiveDanmakuFeedControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$liveDanmakuFeedControllerHash() => r'b486f8ab2de7ac0221b185289324fe0b42b068cc';

final class LiveDanmakuFeedControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          LiveDanmakuFeedController,
          LiveDanmakuFeedState,
          LiveDanmakuFeedState,
          LiveDanmakuFeedState,
          int
        > {
  LiveDanmakuFeedControllerFamily._()
    : super(
        retry: null,
        name: r'liveDanmakuFeedControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  LiveDanmakuFeedControllerProvider call(int roomId) =>
      LiveDanmakuFeedControllerProvider._(argument: roomId, from: this);

  @override
  String toString() => r'liveDanmakuFeedControllerProvider';
}

abstract class _$LiveDanmakuFeedController extends $Notifier<LiveDanmakuFeedState> {
  late final _$args = ref.$arg as int;
  int get roomId => _$args;

  LiveDanmakuFeedState build(int roomId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<LiveDanmakuFeedState, LiveDanmakuFeedState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<LiveDanmakuFeedState, LiveDanmakuFeedState>,
              LiveDanmakuFeedState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
