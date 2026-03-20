// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'danmaku_mask_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(danmakuMask)
final danmakuMaskProvider = DanmakuMaskFamily._();

final class DanmakuMaskProvider
    extends
        $FunctionalProvider<
          AsyncValue<DanmakuMasks?>,
          DanmakuMasks?,
          FutureOr<DanmakuMasks?>
        >
    with $FutureModifier<DanmakuMasks?>, $FutureProvider<DanmakuMasks?> {
  DanmakuMaskProvider._({
    required DanmakuMaskFamily super.from,
    required ({int oid, int pid}) super.argument,
  }) : super(
         retry: null,
         name: r'danmakuMaskProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$danmakuMaskHash();

  @override
  String toString() {
    return r'danmakuMaskProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<DanmakuMasks?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<DanmakuMasks?> create(Ref ref) {
    final argument = this.argument as ({int oid, int pid});
    return danmakuMask(ref, oid: argument.oid, pid: argument.pid);
  }

  @override
  bool operator ==(Object other) {
    return other is DanmakuMaskProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$danmakuMaskHash() => r'052cb166ba3d43d540cb4ab374540062bae81420';

final class DanmakuMaskFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<DanmakuMasks?>,
          ({int oid, int pid})
        > {
  DanmakuMaskFamily._()
    : super(
        retry: null,
        name: r'danmakuMaskProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  DanmakuMaskProvider call({required int oid, required int pid}) =>
      DanmakuMaskProvider._(argument: (oid: oid, pid: pid), from: this);

  @override
  String toString() => r'danmakuMaskProvider';
}
