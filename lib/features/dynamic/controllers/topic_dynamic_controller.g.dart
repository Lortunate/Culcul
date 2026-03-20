// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic_dynamic_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TopicDynamicNotifier)
final topicDynamicProvider = TopicDynamicNotifierFamily._();

final class TopicDynamicNotifierProvider
    extends $AsyncNotifierProvider<TopicDynamicNotifier, List<DynamicItem>> {
  TopicDynamicNotifierProvider._({
    required TopicDynamicNotifierFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'topicDynamicProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$topicDynamicNotifierHash();

  @override
  String toString() {
    return r'topicDynamicProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  TopicDynamicNotifier create() => TopicDynamicNotifier();

  @override
  bool operator ==(Object other) {
    return other is TopicDynamicNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$topicDynamicNotifierHash() =>
    r'6675d7e25c32e49fa8c1353ea30dff52b23f678b';

final class TopicDynamicNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          TopicDynamicNotifier,
          AsyncValue<List<DynamicItem>>,
          List<DynamicItem>,
          FutureOr<List<DynamicItem>>,
          int
        > {
  TopicDynamicNotifierFamily._()
    : super(
        retry: null,
        name: r'topicDynamicProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  TopicDynamicNotifierProvider call({required int topicId}) =>
      TopicDynamicNotifierProvider._(argument: topicId, from: this);

  @override
  String toString() => r'topicDynamicProvider';
}

abstract class _$TopicDynamicNotifier
    extends $AsyncNotifier<List<DynamicItem>> {
  late final _$args = ref.$arg as int;
  int get topicId => _$args;

  FutureOr<List<DynamicItem>> build({required int topicId});
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<DynamicItem>>, List<DynamicItem>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<DynamicItem>>, List<DynamicItem>>,
              AsyncValue<List<DynamicItem>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(topicId: _$args));
  }
}
