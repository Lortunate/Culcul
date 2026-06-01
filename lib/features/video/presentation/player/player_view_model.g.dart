// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_view_model.dart';

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

String _$playerControllerHash() => r'1d4de5933a301d7e1d16b993f5f8d91c9f3ad7fe';

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
