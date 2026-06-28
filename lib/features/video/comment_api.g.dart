// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(commentService)
final commentServiceProvider = CommentApiProvider._();

final class CommentApiProvider
    extends $FunctionalProvider<CommentApi, CommentApi, CommentApi>
    with $Provider<CommentApi> {
  CommentApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'commentServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$commentServiceHash();

  @$internal
  @override
  $ProviderElement<CommentApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CommentApi create(Ref ref) {
    return commentService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CommentApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CommentApi>(value),
    );
  }
}

String _$commentServiceHash() => r'181e2971b35c1a66dec6e3f867a37a7f69f0343b';
