// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PlayerController)
final playerControllerProvider = PlayerControllerProvider._();

final class PlayerControllerProvider
    extends $NotifierProvider<PlayerController, PlayerUiState> {
  PlayerControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'playerControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$playerControllerHash();

  @$internal
  @override
  PlayerController create() => PlayerController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PlayerUiState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PlayerUiState>(value),
    );
  }
}

String _$playerControllerHash() => r'd9131187d5d69489908df76c3c9d76311bd05c16';

abstract class _$PlayerController extends $Notifier<PlayerUiState> {
  PlayerUiState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<PlayerUiState, PlayerUiState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PlayerUiState, PlayerUiState>,
              PlayerUiState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
