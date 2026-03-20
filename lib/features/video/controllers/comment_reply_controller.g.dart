// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_reply_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CommentReplyController)
final commentReplyControllerProvider = CommentReplyControllerFamily._();

final class CommentReplyControllerProvider
    extends $NotifierProvider<CommentReplyController, CommentReplyState> {
  CommentReplyControllerProvider._({
    required CommentReplyControllerFamily super.from,
    required (int, int) super.argument,
  }) : super(
         retry: null,
         name: r'commentReplyControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$commentReplyControllerHash();

  @override
  String toString() {
    return r'commentReplyControllerProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  CommentReplyController create() => CommentReplyController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CommentReplyState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CommentReplyState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CommentReplyControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$commentReplyControllerHash() =>
    r'4353ec36506e9363b9e4ffd9200b83bad1df98c5';

final class CommentReplyControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          CommentReplyController,
          CommentReplyState,
          CommentReplyState,
          CommentReplyState,
          (int, int)
        > {
  CommentReplyControllerFamily._()
    : super(
        retry: null,
        name: r'commentReplyControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CommentReplyControllerProvider call(int oid, int rootId) =>
      CommentReplyControllerProvider._(argument: (oid, rootId), from: this);

  @override
  String toString() => r'commentReplyControllerProvider';
}

abstract class _$CommentReplyController extends $Notifier<CommentReplyState> {
  late final _$args = ref.$arg as (int, int);
  int get oid => _$args.$1;
  int get rootId => _$args.$2;

  CommentReplyState build(int oid, int rootId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<CommentReplyState, CommentReplyState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CommentReplyState, CommentReplyState>,
              CommentReplyState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args.$1, _$args.$2));
  }
}
