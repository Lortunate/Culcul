// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_detail_workflows.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(loadVideoDetailWorkflow)
final loadVideoDetailWorkflowProvider = LoadVideoDetailWorkflowProvider._();

final class LoadVideoDetailWorkflowProvider
    extends
        $FunctionalProvider<
          LoadVideoDetailWorkflow,
          LoadVideoDetailWorkflow,
          LoadVideoDetailWorkflow
        >
    with $Provider<LoadVideoDetailWorkflow> {
  LoadVideoDetailWorkflowProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'loadVideoDetailWorkflowProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$loadVideoDetailWorkflowHash();

  @$internal
  @override
  $ProviderElement<LoadVideoDetailWorkflow> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LoadVideoDetailWorkflow create(Ref ref) {
    return loadVideoDetailWorkflow(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LoadVideoDetailWorkflow value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LoadVideoDetailWorkflow>(value),
    );
  }
}

String _$loadVideoDetailWorkflowHash() => r'33f78db2b88e6dbf6a2a2e74e1b55badac87c5f4';
