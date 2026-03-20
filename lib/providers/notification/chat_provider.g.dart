// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Chat)
final chatProvider = ChatFamily._();

final class ChatProvider extends $AsyncNotifierProvider<Chat, ChatState> {
  ChatProvider._({
    required ChatFamily super.from,
    required (int, int) super.argument,
  }) : super(
         retry: null,
         name: r'chatProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$chatHash();

  @override
  String toString() {
    return r'chatProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  Chat create() => Chat();

  @override
  bool operator ==(Object other) {
    return other is ChatProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$chatHash() => r'639ee18cdb5bac105491e1d35ba15c3f19a6bea5';

final class ChatFamily extends $Family
    with
        $ClassFamilyOverride<
          Chat,
          AsyncValue<ChatState>,
          ChatState,
          FutureOr<ChatState>,
          (int, int)
        > {
  ChatFamily._()
    : super(
        retry: null,
        name: r'chatProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ChatProvider call(int talkerId, int sessionType) =>
      ChatProvider._(argument: (talkerId, sessionType), from: this);

  @override
  String toString() => r'chatProvider';
}

abstract class _$Chat extends $AsyncNotifier<ChatState> {
  late final _$args = ref.$arg as (int, int);
  int get talkerId => _$args.$1;
  int get sessionType => _$args.$2;

  FutureOr<ChatState> build(int talkerId, int sessionType);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<ChatState>, ChatState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ChatState>, ChatState>,
              AsyncValue<ChatState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args.$1, _$args.$2));
  }
}
