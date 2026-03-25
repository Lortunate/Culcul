import 'package:freezed_annotation/freezed_annotation.dart';

part 'live_gold_rank_model.freezed.dart';
part 'live_gold_rank_model.g.dart';

@freezed
sealed class LiveGoldRankModel with _$LiveGoldRankModel {
  const factory LiveGoldRankModel({
    @JsonKey(name: 'onlineNum') required int onlineNum,
    @JsonKey(name: 'OnlineRankItem') required List<LiveRankItem> list,
  }) = _LiveGoldRankModel;

  factory LiveGoldRankModel.fromJson(Map<String, dynamic> json) =>
      _$LiveGoldRankModelFromJson(json);
}

@freezed
sealed class LiveRankItem with _$LiveRankItem {
  const factory LiveRankItem({
    required int userRank,
    required int uid,
    required String name,
    required String face,
    required int score,
    required LiveRankMedalInfo medalInfo,
    @JsonKey(name: 'guard_level') required int guardLevel,
    @JsonKey(name: 'wealth_level') required int wealthLevel,
  }) = _LiveRankItem;

  factory LiveRankItem.fromJson(Map<String, dynamic> json) =>
      _$LiveRankItemFromJson(json);
}

@freezed
sealed class LiveRankMedalInfo with _$LiveRankMedalInfo {
  const factory LiveRankMedalInfo({
    required int guardLevel,
    required int medalColorStart,
    required int medalColorEnd,
    required int medalColorBorder,
    required String medalName,
    required int level,
    required int targetId,
    required int isLight,
  }) = _LiveRankMedalInfo;

  factory LiveRankMedalInfo.fromJson(Map<String, dynamic> json) =>
      _$LiveRankMedalInfoFromJson(json);
}

