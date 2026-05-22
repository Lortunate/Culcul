import 'package:freezed_annotation/freezed_annotation.dart';

part 'live_gold_rank_dto.freezed.dart';
part 'live_gold_rank_dto.g.dart';

@freezed
sealed class LiveGoldRankDto with _$LiveGoldRankDto {
  const factory LiveGoldRankDto({
    @JsonKey(name: 'onlineNum') required int onlineNum,
    @JsonKey(name: 'OnlineRankItem') required List<LiveRankItemDto> list,
  }) = _LiveGoldRankDto;

  factory LiveGoldRankDto.fromJson(Map<String, dynamic> json) =>
      _$LiveGoldRankDtoFromJson(json);
}

@freezed
sealed class LiveRankItemDto with _$LiveRankItemDto {
  const factory LiveRankItemDto({
    required int userRank,
    required int uid,
    required String name,
    required String face,
    required int score,
    required LiveRankMedalInfoDto medalInfo,
    @JsonKey(name: 'guard_level') required int guardLevel,
    @JsonKey(name: 'wealth_level') required int wealthLevel,
  }) = _LiveRankItemDto;

  factory LiveRankItemDto.fromJson(Map<String, dynamic> json) =>
      _$LiveRankItemDtoFromJson(json);
}

@freezed
sealed class LiveRankMedalInfoDto with _$LiveRankMedalInfoDto {
  const factory LiveRankMedalInfoDto({
    required int guardLevel,
    required int medalColorStart,
    required int medalColorEnd,
    required int medalColorBorder,
    required String medalName,
    required int level,
    required int targetId,
    required int isLight,
  }) = _LiveRankMedalInfoDto;

  factory LiveRankMedalInfoDto.fromJson(Map<String, dynamic> json) =>
      _$LiveRankMedalInfoDtoFromJson(json);
}
