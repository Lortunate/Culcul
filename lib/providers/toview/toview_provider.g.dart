// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'toview_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ToViewList)
final toViewListProvider = ToViewListProvider._();

final class ToViewListProvider
    extends $AsyncNotifierProvider<ToViewList, List<ToViewModel>> {
  ToViewListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'toViewListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$toViewListHash();

  @$internal
  @override
  ToViewList create() => ToViewList();
}

String _$toViewListHash() => r'525974ff1900737aff854b35c1bc0fa467d7039d';

abstract class _$ToViewList extends $AsyncNotifier<List<ToViewModel>> {
  FutureOr<List<ToViewModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<ToViewModel>>, List<ToViewModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<ToViewModel>>, List<ToViewModel>>,
              AsyncValue<List<ToViewModel>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
