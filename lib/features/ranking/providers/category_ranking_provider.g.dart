// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_ranking_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(categoryRankingList)
final categoryRankingListProvider = CategoryRankingListFamily._();

final class CategoryRankingListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<VideoModel>>,
          List<VideoModel>,
          FutureOr<List<VideoModel>>
        >
    with $FutureModifier<List<VideoModel>>, $FutureProvider<List<VideoModel>> {
  CategoryRankingListProvider._({
    required CategoryRankingListFamily super.from,
    required int? super.argument,
  }) : super(
         retry: null,
         name: r'categoryRankingListProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$categoryRankingListHash();

  @override
  String toString() {
    return r'categoryRankingListProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<VideoModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<VideoModel>> create(Ref ref) {
    final argument = this.argument as int?;
    return categoryRankingList(ref, rid: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CategoryRankingListProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$categoryRankingListHash() =>
    r'04c8f51b553b4e01f76d81b029e9ce4a1a42e470';

final class CategoryRankingListFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<VideoModel>>, int?> {
  CategoryRankingListFamily._()
    : super(
        retry: null,
        name: r'categoryRankingListProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CategoryRankingListProvider call({int? rid}) =>
      CategoryRankingListProvider._(argument: rid, from: this);

  @override
  String toString() => r'categoryRankingListProvider';
}
