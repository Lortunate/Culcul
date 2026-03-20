// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_space_extras_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(userStickyVideo)
final userStickyVideoProvider = UserStickyVideoFamily._();

final class UserStickyVideoProvider
    extends
        $FunctionalProvider<
          AsyncValue<UserSpaceVideoModel?>,
          UserSpaceVideoModel?,
          FutureOr<UserSpaceVideoModel?>
        >
    with
        $FutureModifier<UserSpaceVideoModel?>,
        $FutureProvider<UserSpaceVideoModel?> {
  UserStickyVideoProvider._({
    required UserStickyVideoFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'userStickyVideoProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$userStickyVideoHash();

  @override
  String toString() {
    return r'userStickyVideoProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<UserSpaceVideoModel?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<UserSpaceVideoModel?> create(Ref ref) {
    final argument = this.argument as int;
    return userStickyVideo(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is UserStickyVideoProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$userStickyVideoHash() => r'08706ff04f257bf30642c25823c28d7f860f9987';

final class UserStickyVideoFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<UserSpaceVideoModel?>, int> {
  UserStickyVideoFamily._()
    : super(
        retry: null,
        name: r'userStickyVideoProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  UserStickyVideoProvider call(int vmid) =>
      UserStickyVideoProvider._(argument: vmid, from: this);

  @override
  String toString() => r'userStickyVideoProvider';
}

@ProviderFor(userMasterpieces)
final userMasterpiecesProvider = UserMasterpiecesFamily._();

final class UserMasterpiecesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<UserSpaceVideoModel>>,
          List<UserSpaceVideoModel>,
          FutureOr<List<UserSpaceVideoModel>>
        >
    with
        $FutureModifier<List<UserSpaceVideoModel>>,
        $FutureProvider<List<UserSpaceVideoModel>> {
  UserMasterpiecesProvider._({
    required UserMasterpiecesFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'userMasterpiecesProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$userMasterpiecesHash();

  @override
  String toString() {
    return r'userMasterpiecesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<UserSpaceVideoModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<UserSpaceVideoModel>> create(Ref ref) {
    final argument = this.argument as int;
    return userMasterpieces(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is UserMasterpiecesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$userMasterpiecesHash() => r'656007edce0f514be7e55b0c88c9d6b203fcca59';

final class UserMasterpiecesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<UserSpaceVideoModel>>, int> {
  UserMasterpiecesFamily._()
    : super(
        retry: null,
        name: r'userMasterpiecesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  UserMasterpiecesProvider call(int vmid) =>
      UserMasterpiecesProvider._(argument: vmid, from: this);

  @override
  String toString() => r'userMasterpiecesProvider';
}
