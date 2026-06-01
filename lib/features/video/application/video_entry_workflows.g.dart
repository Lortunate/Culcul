// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_entry_workflows.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(resolveVideoEntryLayout)
final resolveVideoEntryLayoutProvider = ResolveVideoEntryLayoutFamily._();

final class ResolveVideoEntryLayoutProvider
    extends
        $FunctionalProvider<
          AsyncValue<VideoEntryLayout>,
          VideoEntryLayout,
          FutureOr<VideoEntryLayout>
        >
    with $FutureModifier<VideoEntryLayout>, $FutureProvider<VideoEntryLayout> {
  ResolveVideoEntryLayoutProvider._({
    required ResolveVideoEntryLayoutFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'resolveVideoEntryLayoutProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$resolveVideoEntryLayoutHash();

  @override
  String toString() {
    return r'resolveVideoEntryLayoutProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<VideoEntryLayout> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<VideoEntryLayout> create(Ref ref) {
    final argument = this.argument as String;
    return resolveVideoEntryLayout(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ResolveVideoEntryLayoutProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$resolveVideoEntryLayoutHash() => r'fb33cc27e5ccef48fa0cce499dfc45116a2e66d6';

final class ResolveVideoEntryLayoutFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<VideoEntryLayout>, String> {
  ResolveVideoEntryLayoutFamily._()
    : super(
        retry: null,
        name: r'resolveVideoEntryLayoutProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ResolveVideoEntryLayoutProvider call(String bvid) =>
      ResolveVideoEntryLayoutProvider._(argument: bvid, from: this);

  @override
  String toString() => r'resolveVideoEntryLayoutProvider';
}
