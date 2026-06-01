// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_session_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(userProfileCard)
final userProfileCardProvider = UserProfileCardFamily._();

final class UserProfileCardProvider
    extends
        $FunctionalProvider<
          AsyncValue<Result<UserCardModel, AppError>>,
          Result<UserCardModel, AppError>,
          FutureOr<Result<UserCardModel, AppError>>
        >
    with
        $FutureModifier<Result<UserCardModel, AppError>>,
        $FutureProvider<Result<UserCardModel, AppError>> {
  UserProfileCardProvider._({
    required UserProfileCardFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'userProfileCardProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$userProfileCardHash();

  @override
  String toString() {
    return r'userProfileCardProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Result<UserCardModel, AppError>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Result<UserCardModel, AppError>> create(Ref ref) {
    final argument = this.argument as String;
    return userProfileCard(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is UserProfileCardProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$userProfileCardHash() => r'080a80a0d010cfda4b91f1ece82f06d0b077f952';

final class UserProfileCardFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Result<UserCardModel, AppError>>, String> {
  UserProfileCardFamily._()
    : super(
        retry: null,
        name: r'userProfileCardProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  UserProfileCardProvider call(String mid) =>
      UserProfileCardProvider._(argument: mid, from: this);

  @override
  String toString() => r'userProfileCardProvider';
}
