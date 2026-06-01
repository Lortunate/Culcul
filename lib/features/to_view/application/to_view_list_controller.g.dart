// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'to_view_list_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ToViewList)
final toViewListProvider = ToViewListProvider._();

final class ToViewListProvider
    extends $AsyncNotifierProvider<ToViewList, List<ToViewEntry>> {
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

String _$toViewListHash() => r'b097dfc35f8a688cba7999b3575d6a356ce645be';

abstract class _$ToViewList extends $AsyncNotifier<List<ToViewEntry>> {
  FutureOr<List<ToViewEntry>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<ToViewEntry>>, List<ToViewEntry>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<ToViewEntry>>, List<ToViewEntry>>,
              AsyncValue<List<ToViewEntry>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
