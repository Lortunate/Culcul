// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dynamic_comment_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DynamicCommentController)
final dynamicCommentControllerProvider = DynamicCommentControllerFamily._();

final class DynamicCommentControllerProvider
    extends $NotifierProvider<DynamicCommentController, CommentListState> {
  DynamicCommentControllerProvider._({
    required DynamicCommentControllerFamily super.from,
    required DynamicItem super.argument,
  }) : super(
         retry: null,
         name: r'dynamicCommentControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$dynamicCommentControllerHash();

  @override
  String toString() {
    return r'dynamicCommentControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  DynamicCommentController create() => DynamicCommentController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CommentListState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CommentListState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is DynamicCommentControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$dynamicCommentControllerHash() => r'c89bc5c627f97b16e435893a226547bc8da8466f';

final class DynamicCommentControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          DynamicCommentController,
          CommentListState,
          CommentListState,
          CommentListState,
          DynamicItem
        > {
  DynamicCommentControllerFamily._()
    : super(
        retry: null,
        name: r'dynamicCommentControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  DynamicCommentControllerProvider call(DynamicItem post) =>
      DynamicCommentControllerProvider._(argument: post, from: this);

  @override
  String toString() => r'dynamicCommentControllerProvider';
}

abstract class _$DynamicCommentController extends $Notifier<CommentListState> {
  late final _$args = ref.$arg as DynamicItem;
  DynamicItem get post => _$args;

  CommentListState build(DynamicItem post);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<CommentListState, CommentListState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CommentListState, CommentListState>,
              CommentListState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
