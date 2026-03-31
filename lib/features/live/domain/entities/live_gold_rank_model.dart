import 'package:freezed_annotation/freezed_annotation.dart';

part 'live_gold_rank_model.freezed.dart';

@freezed
sealed class LiveGoldRankModel with _$LiveGoldRankModel {
  const factory LiveGoldRankModel({
    required int onlineNum,
    required List<LiveRankItem> list,
  }) = _LiveGoldRankModel;
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
    required int guardLevel,
    required int wealthLevel,
  }) = _LiveRankItem;
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
}
