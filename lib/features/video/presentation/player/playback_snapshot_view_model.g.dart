// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playback_snapshot_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(playbackSnapshot)
final playbackSnapshotProvider = PlaybackSnapshotProvider._();

final class PlaybackSnapshotProvider
    extends
        $FunctionalProvider<
          AsyncValue<PlaybackSnapshot>,
          PlaybackSnapshot,
          Stream<PlaybackSnapshot>
        >
    with $FutureModifier<PlaybackSnapshot>, $StreamProvider<PlaybackSnapshot> {
  PlaybackSnapshotProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'playbackSnapshotProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$playbackSnapshotHash();

  @$internal
  @override
  $StreamProviderElement<PlaybackSnapshot> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<PlaybackSnapshot> create(Ref ref) {
    return playbackSnapshot(ref);
  }
}

String _$playbackSnapshotHash() => r'9c294f0ed9db23752bd4d0fd301848f10873c708';

@ProviderFor(playbackSnapshotValue)
final playbackSnapshotValueProvider = PlaybackSnapshotValueProvider._();

final class PlaybackSnapshotValueProvider
    extends $FunctionalProvider<PlaybackSnapshot, PlaybackSnapshot, PlaybackSnapshot>
    with $Provider<PlaybackSnapshot> {
  PlaybackSnapshotValueProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'playbackSnapshotValueProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$playbackSnapshotValueHash();

  @$internal
  @override
  $ProviderElement<PlaybackSnapshot> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PlaybackSnapshot create(Ref ref) {
    return playbackSnapshotValue(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PlaybackSnapshot value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PlaybackSnapshot>(value),
    );
  }
}

String _$playbackSnapshotValueHash() => r'6dee2444662b7a7bb5907ef83759f9e83d468bf6';

@ProviderFor(playbackPosition)
final playbackPositionProvider = PlaybackPositionProvider._();

final class PlaybackPositionProvider
    extends $FunctionalProvider<Duration, Duration, Duration>
    with $Provider<Duration> {
  PlaybackPositionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'playbackPositionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$playbackPositionHash();

  @$internal
  @override
  $ProviderElement<Duration> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Duration create(Ref ref) {
    return playbackPosition(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Duration value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Duration>(value),
    );
  }
}

String _$playbackPositionHash() => r'38139d3cab9540719671b054d4e269ce392a423f';

@ProviderFor(playbackDuration)
final playbackDurationProvider = PlaybackDurationProvider._();

final class PlaybackDurationProvider
    extends $FunctionalProvider<Duration, Duration, Duration>
    with $Provider<Duration> {
  PlaybackDurationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'playbackDurationProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$playbackDurationHash();

  @$internal
  @override
  $ProviderElement<Duration> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Duration create(Ref ref) {
    return playbackDuration(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Duration value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Duration>(value),
    );
  }
}

String _$playbackDurationHash() => r'6682f570fcc724945174e2ab5a6f2d7f27c11476';

@ProviderFor(playbackBuffer)
final playbackBufferProvider = PlaybackBufferProvider._();

final class PlaybackBufferProvider
    extends $FunctionalProvider<Duration, Duration, Duration>
    with $Provider<Duration> {
  PlaybackBufferProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'playbackBufferProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$playbackBufferHash();

  @$internal
  @override
  $ProviderElement<Duration> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Duration create(Ref ref) {
    return playbackBuffer(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Duration value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Duration>(value),
    );
  }
}

String _$playbackBufferHash() => r'2caf4fa6e2129787879060b744e9c2cf62d89869';
