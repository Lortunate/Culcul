// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subtitle_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SubtitleController)
final subtitleControllerProvider = SubtitleControllerFamily._();

final class SubtitleControllerProvider
    extends $NotifierProvider<SubtitleController, SubtitleState> {
  SubtitleControllerProvider._({
    required SubtitleControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'subtitleControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$subtitleControllerHash();

  @override
  String toString() {
    return r'subtitleControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  SubtitleController create() => SubtitleController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SubtitleState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SubtitleState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SubtitleControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$subtitleControllerHash() =>
    r'4ef561c923cefc0a62c56f7b4adc7661df4b77ea';

final class SubtitleControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          SubtitleController,
          SubtitleState,
          SubtitleState,
          SubtitleState,
          String
        > {
  SubtitleControllerFamily._()
    : super(
        retry: null,
        name: r'subtitleControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SubtitleControllerProvider call(String bvid) =>
      SubtitleControllerProvider._(argument: bvid, from: this);

  @override
  String toString() => r'subtitleControllerProvider';
}

abstract class _$SubtitleController extends $Notifier<SubtitleState> {
  late final _$args = ref.$arg as String;
  String get bvid => _$args;

  SubtitleState build(String bvid);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<SubtitleState, SubtitleState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SubtitleState, SubtitleState>,
              SubtitleState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
