part of 'dynamic_response.dart';

@freezed
sealed class ModuleAdditional with _$ModuleAdditional {
  const factory ModuleAdditional({
    @JsonKey(fromJson: JsonUtils.parseStringWithDefault) required String type,
    AdditionalCommon? common,
    AdditionalReserve? reserve,
    AdditionalGoods? goods,
    AdditionalVote? vote,
    AdditionalUgc? ugc,
  }) = _ModuleAdditional;

  factory ModuleAdditional.fromJson(Map<String, dynamic> json) =>
      _$ModuleAdditionalFromJson(json);
}

@freezed
sealed class AdditionalCommon with _$AdditionalCommon {
  const factory AdditionalCommon({
    @JsonKey(fromJson: JsonUtils.parseStringWithDefault) required String title,
    String? desc1,
    String? desc2,
    @JsonKey(fromJson: JsonUtils.parseStringWithDefault) required String cover,
    @JsonKey(name: 'jump_url', fromJson: JsonUtils.parseStringWithDefault)
    required String jumpUrl,
    @JsonKey(name: 'sub_type', fromJson: JsonUtils.parseStringWithDefault)
    required String subType,
    @JsonKey(name: 'head_text') String? headText,
  }) = _AdditionalCommon;

  factory AdditionalCommon.fromJson(Map<String, dynamic> json) =>
      _$AdditionalCommonFromJson(json);
}

@freezed
sealed class AdditionalReserve with _$AdditionalReserve {
  const factory AdditionalReserve({
    @JsonKey(fromJson: JsonUtils.parseStringWithDefault) required String title,
    @JsonKey(name: 'jump_url', fromJson: JsonUtils.parseStringWithDefault)
    required String jumpUrl,
    @JsonKey(name: 'reserve_total') required int reserveTotal,
    required int state,
    ReserveDesc? desc1,
    ReserveDesc? desc2,
  }) = _AdditionalReserve;

  factory AdditionalReserve.fromJson(Map<String, dynamic> json) =>
      _$AdditionalReserveFromJson(json);
}

@freezed
sealed class ReserveDesc with _$ReserveDesc {
  const factory ReserveDesc({
    @JsonKey(fromJson: JsonUtils.parseStringWithDefault) required String text,
    required int style,
  }) = _ReserveDesc;

  factory ReserveDesc.fromJson(Map<String, dynamic> json) => _$ReserveDescFromJson(json);
}

@freezed
sealed class AdditionalGoods with _$AdditionalGoods {
  const factory AdditionalGoods({
    @JsonKey(name: 'head_text', fromJson: JsonUtils.parseStringWithDefault)
    required String headText,
    required List<GoodsItem> items,
    @JsonKey(name: 'jump_url', fromJson: JsonUtils.parseStringWithDefault)
    required String jumpUrl,
  }) = _AdditionalGoods;

  factory AdditionalGoods.fromJson(Map<String, dynamic> json) =>
      _$AdditionalGoodsFromJson(json);
}

@freezed
sealed class GoodsItem with _$GoodsItem {
  const factory GoodsItem({
    @JsonKey(fromJson: JsonUtils.parseStringWithDefault) required String name,
    @JsonKey(fromJson: JsonUtils.parseStringWithDefault) required String price,
    @JsonKey(fromJson: JsonUtils.parseStringWithDefault) required String cover,
    @JsonKey(name: 'jump_url', fromJson: JsonUtils.parseStringWithDefault)
    required String jumpUrl,
  }) = _GoodsItem;

  factory GoodsItem.fromJson(Map<String, dynamic> json) => _$GoodsItemFromJson(json);
}

@freezed
sealed class AdditionalVote with _$AdditionalVote {
  const factory AdditionalVote({
    @JsonKey(fromJson: JsonUtils.parseStringWithDefault) required String desc,
    @JsonKey(name: 'end_time') required int endTime,
    @JsonKey(name: 'join_num') required int joinNum,
    @JsonKey(name: 'vote_id') required int voteId,
    @JsonKey(name: 'choice_cnt') required int choiceCnt,
    required int status,
  }) = _AdditionalVote;

  factory AdditionalVote.fromJson(Map<String, dynamic> json) =>
      _$AdditionalVoteFromJson(json);
}

@freezed
sealed class AdditionalUgc with _$AdditionalUgc {
  const factory AdditionalUgc({
    @JsonKey(fromJson: JsonUtils.parseStringWithDefault) required String title,
    @JsonKey(fromJson: JsonUtils.parseStringWithDefault) required String cover,
    @JsonKey(name: 'desc_second', fromJson: JsonUtils.parseStringWithDefault)
    required String descSecond,
    @JsonKey(fromJson: JsonUtils.parseStringWithDefault) required String duration,
    @JsonKey(name: 'jump_url', fromJson: JsonUtils.parseStringWithDefault)
    required String jumpUrl,
  }) = _AdditionalUgc;

  factory AdditionalUgc.fromJson(Map<String, dynamic> json) =>
      _$AdditionalUgcFromJson(json);
}
