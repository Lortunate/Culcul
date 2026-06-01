// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dynamic_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserDynamicNotifier)
final userDynamicProvider = UserDynamicNotifierFamily._();

final class UserDynamicNotifierProvider
    extends $AsyncNotifierProvider<UserDynamicNotifier, List<DynamicItem>> {
  UserDynamicNotifierProvider._({
    required UserDynamicNotifierFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'userDynamicProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$userDynamicNotifierHash();

  @override
  String toString() {
    return r'userDynamicProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  UserDynamicNotifier create() => UserDynamicNotifier();

  @override
  bool operator ==(Object other) {
    return other is UserDynamicNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$userDynamicNotifierHash() => r'607e4a97ec5b8d1f2836bcaa1c527858b9c9feb7';

final class UserDynamicNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          UserDynamicNotifier,
          AsyncValue<List<DynamicItem>>,
          List<DynamicItem>,
          FutureOr<List<DynamicItem>>,
          int
        > {
  UserDynamicNotifierFamily._()
    : super(
        retry: null,
        name: r'userDynamicProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  UserDynamicNotifierProvider call(int hostMid) =>
      UserDynamicNotifierProvider._(argument: hostMid, from: this);

  @override
  String toString() => r'userDynamicProvider';
}

abstract class _$UserDynamicNotifier extends $AsyncNotifier<List<DynamicItem>> {
  late final _$args = ref.$arg as int;
  int get hostMid => _$args;

  FutureOr<List<DynamicItem>> build(int hostMid);
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
