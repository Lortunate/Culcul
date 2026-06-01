// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_detail_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ArticleDetailViewModel)
final articleDetailViewModelProvider = ArticleDetailViewModelFamily._();

final class ArticleDetailViewModelProvider
    extends $NotifierProvider<ArticleDetailViewModel, ArticleDetailUiState> {
  ArticleDetailViewModelProvider._({
    required ArticleDetailViewModelFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'articleDetailViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$articleDetailViewModelHash();

  @override
  String toString() {
    return r'articleDetailViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ArticleDetailViewModel create() => ArticleDetailViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ArticleDetailUiState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ArticleDetailUiState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ArticleDetailViewModelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$articleDetailViewModelHash() => r'b0559f5fb3d53cba6af5a58e570ee329ee893864';

final class ArticleDetailViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          ArticleDetailViewModel,
          ArticleDetailUiState,
          ArticleDetailUiState,
          ArticleDetailUiState,
          String
        > {
  ArticleDetailViewModelFamily._()
    : super(
        retry: null,
        name: r'articleDetailViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ArticleDetailViewModelProvider call(String url) =>
      ArticleDetailViewModelProvider._(argument: url, from: this);

  @override
  String toString() => r'articleDetailViewModelProvider';
}

abstract class _$ArticleDetailViewModel extends $Notifier<ArticleDetailUiState> {
  late final _$args = ref.$arg as String;
  String get url => _$args;

  ArticleDetailUiState build(String url);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ArticleDetailUiState, ArticleDetailUiState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ArticleDetailUiState, ArticleDetailUiState>,
              ArticleDetailUiState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
