// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weekly_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(weeklyList)
final weeklyListProvider = WeeklyListProvider._();

final class WeeklyListProvider
    extends
        $FunctionalProvider<
          AsyncValue<WeeklyModel>,
          WeeklyModel,
          FutureOr<WeeklyModel>
        >
    with $FutureModifier<WeeklyModel>, $FutureProvider<WeeklyModel> {
  WeeklyListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'weeklyListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$weeklyListHash();

  @$internal
  @override
  $FutureProviderElement<WeeklyModel> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<WeeklyModel> create(Ref ref) {
    return weeklyList(ref);
  }
}

String _$weeklyListHash() => r'4e67e450031338a01607edf790d2de79e0db17a5';
