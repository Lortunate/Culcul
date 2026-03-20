// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HistoryList)
final historyListProvider = HistoryListProvider._();

final class HistoryListProvider
    extends $AsyncNotifierProvider<HistoryList, List<HistoryItem>> {
  HistoryListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'historyListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$historyListHash();

  @$internal
  @override
  HistoryList create() => HistoryList();
}

String _$historyListHash() => r'658ff2f2101fcc7dca30b0955806226afbd734d1';

abstract class _$HistoryList extends $AsyncNotifier<List<HistoryItem>> {
  FutureOr<List<HistoryItem>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<HistoryItem>>, List<HistoryItem>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<HistoryItem>>, List<HistoryItem>>,
              AsyncValue<List<HistoryItem>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
