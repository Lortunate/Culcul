// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LikeList)
final likeListProvider = LikeListProvider._();

final class LikeListProvider
    extends $AsyncNotifierProvider<LikeList, List<ReplyItem>> {
  LikeListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'likeListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$likeListHash();

  @$internal
  @override
  LikeList create() => LikeList();
}

String _$likeListHash() => r'bca888feaa38c8594644bcd545214d6f554dec67';

abstract class _$LikeList extends $AsyncNotifier<List<ReplyItem>> {
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
