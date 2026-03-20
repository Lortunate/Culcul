// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unread_count_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UnreadCount)
final unreadCountProvider = UnreadCountProvider._();

final class UnreadCountProvider
    extends $AsyncNotifierProvider<UnreadCount, UnreadCountModel> {
  UnreadCountProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'unreadCountProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$unreadCountHash();

  @$internal
  @override
  UnreadCount create() => UnreadCount();
}

String _$unreadCountHash() => r'aacd62f278074c8f5cdec46619b619f4ed2c4c6d';

abstract class _$UnreadCount extends $AsyncNotifier<UnreadCountModel> {
  FutureOr<UnreadCountModel> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<UnreadCountModel>, UnreadCountModel>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<UnreadCountModel>, UnreadCountModel>,
              AsyncValue<UnreadCountModel>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
