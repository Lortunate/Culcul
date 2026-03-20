// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emote_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(emotePackages)
final emotePackagesProvider = EmotePackagesProvider._();

final class EmotePackagesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<EmotePackage>>,
          List<EmotePackage>,
          FutureOr<List<EmotePackage>>
        >
    with
        $FutureModifier<List<EmotePackage>>,
        $FutureProvider<List<EmotePackage>> {
  EmotePackagesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'emotePackagesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$emotePackagesHash();

  @$internal
  @override
  $FutureProviderElement<List<EmotePackage>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<EmotePackage>> create(Ref ref) {
    return emotePackages(ref);
  }
}

String _$emotePackagesHash() => r'61301fdc4624f11de230982ab6dcf08086a62f5e';
