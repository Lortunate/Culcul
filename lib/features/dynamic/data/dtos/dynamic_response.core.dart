part of 'dynamic_response.dart';

@freezed
sealed class DynamicDetailData with _$DynamicDetailData {
  const factory DynamicDetailData({required DynamicItem item}) = _DynamicDetailData;

  factory DynamicDetailData.fromJson(Map<String, dynamic> json) =>
      _$DynamicDetailDataFromJson(json);
}

@freezed
sealed class DynamicData with _$DynamicData {
  const factory DynamicData({
    @JsonKey(name: 'has_more') required bool hasMore,
    required List<DynamicItem> items,
    @JsonKey(fromJson: JsonUtils.parseStringWithDefault) required String offset,
    @JsonKey(name: 'update_baseline', fromJson: JsonUtils.parseStringWithDefault)
    required String updateBaseline,
    @JsonKey(name: 'update_num', fromJson: JsonUtils.parseIntWithDefault)
    required int updateNum,
  }) = _DynamicData;

  factory DynamicData.fromJson(Map<String, dynamic> json) => _$DynamicDataFromJson(json);
}

@freezed
sealed class DynamicItem with _$DynamicItem {
  const factory DynamicItem({
    @JsonKey(name: 'id_str', fromJson: JsonUtils.parseStringWithDefault)
    required String idStr,
    @JsonKey(fromJson: JsonUtils.parseStringWithDefault) required String type,
    required bool visible,
    required DynamicModules modules,
    DynamicItem? orig,
    DynamicBasic? basic,
  }) = _DynamicItem;

  factory DynamicItem.fromJson(Map<String, dynamic> json) => _$DynamicItemFromJson(json);
}

@freezed
sealed class DynamicBasic with _$DynamicBasic {
  const factory DynamicBasic({
    @JsonKey(name: 'comment_id_str', fromJson: JsonUtils.parseStringWithDefault)
    required String commentIdStr,
    @JsonKey(name: 'comment_type') required int commentType,
    @JsonKey(name: 'rid_str', fromJson: JsonUtils.parseStringWithDefault)
    required String ridStr,
  }) = _DynamicBasic;

  factory DynamicBasic.fromJson(Map<String, dynamic> json) =>
      _$DynamicBasicFromJson(json);
}

@freezed
sealed class DynamicModules with _$DynamicModules {
  const factory DynamicModules({
    @JsonKey(name: 'module_author') required ModuleAuthor moduleAuthor,
    @JsonKey(name: 'module_dynamic') required ModuleDynamic moduleDynamic,
    @JsonKey(name: 'module_stat') ModuleStat? moduleStat,
  }) = _DynamicModules;

  factory DynamicModules.fromJson(Map<String, dynamic> json) =>
      _$DynamicModulesFromJson(json);
}

@freezed
sealed class ModuleAuthor with _$ModuleAuthor {
  const factory ModuleAuthor({
    required int mid,
    @JsonKey(fromJson: JsonUtils.parseStringWithDefault) required String name,
    @JsonKey(name: 'face', fromJson: JsonUtils.parseStringWithDefault)
    required String avatar,
    @JsonKey(name: 'pub_time', fromJson: JsonUtils.parseStringWithDefault)
    required String pubTime,
    @JsonKey(name: 'pub_action', fromJson: JsonUtils.parseStringWithDefault)
    required String pubAction,
  }) = _ModuleAuthor;

  factory ModuleAuthor.fromJson(Map<String, dynamic> json) =>
      _$ModuleAuthorFromJson(json);
}

@freezed
sealed class ModuleDynamic with _$ModuleDynamic {
  const factory ModuleDynamic({
    ModuleDesc? desc,
    ModuleMajor? major,
    ModuleTopic? topic,
    ModuleAdditional? additional,
  }) = _ModuleDynamic;

  factory ModuleDynamic.fromJson(Map<String, dynamic> json) =>
      _$ModuleDynamicFromJson(json);
}
