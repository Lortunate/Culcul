// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_handler.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(audioHandler)
final audioHandlerProvider = AudioHandlerProvider._();

final class AudioHandlerProvider
    extends
        $FunctionalProvider<
          CilixiliAudioHandler,
          CilixiliAudioHandler,
          CilixiliAudioHandler
        >
    with $Provider<CilixiliAudioHandler> {
  AudioHandlerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'audioHandlerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$audioHandlerHash();

  @$internal
  @override
  $ProviderElement<CilixiliAudioHandler> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CilixiliAudioHandler create(Ref ref) {
    return audioHandler(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CilixiliAudioHandler value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CilixiliAudioHandler>(value),
    );
  }
}

String _$audioHandlerHash() => r'754cd3c921c18a12d9836f714072df5adb527cde';
