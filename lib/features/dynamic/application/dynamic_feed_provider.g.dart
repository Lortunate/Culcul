// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dynamic_feed_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DynamicNotifier)
final dynamicProvider = DynamicNotifierFamily._();

final class DynamicNotifierProvider
    extends $AsyncNotifierProvider<DynamicNotifier, List<DynamicItem>> {
  DynamicNotifierProvider._({
    required DynamicNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'dynamicProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$dynamicNotifierHash();

  @override
  String toString() {
    return r'dynamicProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  DynamicNotifier create() => DynamicNotifier();

  @override
  bool operator ==(Object other) {
    return other is DynamicNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$dynamicNotifierHash() => r'89add56cb1a00df421e73b9319da8d36acd8b78f';

final class DynamicNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          DynamicNotifier,
          AsyncValue<List<DynamicItem>>,
          List<DynamicItem>,
          FutureOr<List<DynamicItem>>,
          String
        > {
  DynamicNotifierFamily._()
    : super(
        retry: null,
        name: r'dynamicProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  DynamicNotifierProvider call(String type) =>
      DynamicNotifierProvider._(argument: type, from: this);

  @override
  String toString() => r'dynamicProvider';
}

abstract class _$DynamicNotifier extends $AsyncNotifier<List<DynamicItem>> {
  late final _$args = ref.$arg as String;
  String get type => _$args;

  FutureOr<List<DynamicItem>> build(String type);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<DynamicItem>>, List<DynamicItem>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<DynamicItem>>, List<DynamicItem>>,
              AsyncValue<List<DynamicItem>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
