// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dynamic_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DynamicNotifier)
final dynamicProvider = DynamicNotifierFamily._();

final class DynamicNotifierProvider
    extends $NotifierProvider<DynamicNotifier, AsyncValue<List<DynamicItem>>> {
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

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<List<DynamicItem>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<List<DynamicItem>>>(
        value,
      ),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is DynamicNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$dynamicNotifierHash() => r'4d35667a690ebdb35fa1af2359a85c9c238065ea';

final class DynamicNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          DynamicNotifier,
          AsyncValue<List<DynamicItem>>,
          AsyncValue<List<DynamicItem>>,
          AsyncValue<List<DynamicItem>>,
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

abstract class _$DynamicNotifier
    extends $Notifier<AsyncValue<List<DynamicItem>>> {
  late final _$args = ref.$arg as String;
  String get type => _$args;

  AsyncValue<List<DynamicItem>> build(String type);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<DynamicItem>>,
              AsyncValue<List<DynamicItem>>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<DynamicItem>>,
                AsyncValue<List<DynamicItem>>
              >,
              AsyncValue<List<DynamicItem>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
