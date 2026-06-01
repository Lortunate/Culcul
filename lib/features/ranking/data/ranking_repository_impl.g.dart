// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ranking_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(rankingRepository)
final rankingRepositoryProvider = RankingRepositoryProvider._();

final class RankingRepositoryProvider
    extends
        $FunctionalProvider<
          RankingRepositoryImpl,
          RankingRepositoryImpl,
          RankingRepositoryImpl
        >
    with $Provider<RankingRepositoryImpl> {
  RankingRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'rankingRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$rankingRepositoryHash();

  @$internal
  @override
  $ProviderElement<RankingRepositoryImpl> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RankingRepositoryImpl create(Ref ref) {
    return rankingRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RankingRepositoryImpl value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RankingRepositoryImpl>(value),
    );
  }
}

String _$rankingRepositoryHash() => r'c428ebae3492a1615357ab36967617ce5990ff59';
