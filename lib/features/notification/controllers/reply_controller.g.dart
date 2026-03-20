// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reply_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ReplyList)
final replyListProvider = ReplyListProvider._();

final class ReplyListProvider
    extends $AsyncNotifierProvider<ReplyList, List<ReplyItem>> {
  ReplyListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'replyListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$replyListHash();

  @$internal
  @override
  ReplyList create() => ReplyList();
}

String _$replyListHash() => r'0851b1ba318d7ee82cf2a8e97bbaf703426e32b2';

abstract class _$ReplyList extends $AsyncNotifier<List<ReplyItem>> {
  FutureOr<List<ReplyItem>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<ReplyItem>>, List<ReplyItem>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<ReplyItem>>, List<ReplyItem>>,
              AsyncValue<List<ReplyItem>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
