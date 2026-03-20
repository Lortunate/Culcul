// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'at_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AtList)
final atListProvider = AtListProvider._();

final class AtListProvider
    extends $AsyncNotifierProvider<AtList, List<ReplyItem>> {
  AtListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'atListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$atListHash();

  @$internal
  @override
  AtList create() => AtList();
}

String _$atListHash() => r'7ded56472a57cced08bc96092f2c422902c4132c';

abstract class _$AtList extends $AsyncNotifier<List<ReplyItem>> {
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
