// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'private_session_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PrivateSessionList)
final privateSessionListProvider = PrivateSessionListProvider._();

final class PrivateSessionListProvider
    extends
        $AsyncNotifierProvider<
          PrivateSessionList,
          List<PrivateMessageSession>
        > {
  PrivateSessionListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'privateSessionListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$privateSessionListHash();

  @$internal
  @override
  PrivateSessionList create() => PrivateSessionList();
}

String _$privateSessionListHash() =>
    r'0285d8565b10a4837d38e5087528f38aca91b0b2';

abstract class _$PrivateSessionList
    extends $AsyncNotifier<List<PrivateMessageSession>> {
  FutureOr<List<PrivateMessageSession>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<PrivateMessageSession>>,
              List<PrivateMessageSession>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<PrivateMessageSession>>,
                List<PrivateMessageSession>
              >,
              AsyncValue<List<PrivateMessageSession>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
