import 'package:json_annotation/json_annotation.dart';

part 'fav_resource_model.g.dart';

@JsonSerializable()
class FavResourceModel {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'type')
  final int type;
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'cover')
  final String cover;
  @JsonKey(name: 'intro')
  final String intro;
  @JsonKey(name: 'page')
  final int page;
  @JsonKey(name: 'duration')
  final int duration;
  @JsonKey(name: 'upper')
  final FavUpperModel upper;
  @JsonKey(name: 'attr')
  final int attr;
  @JsonKey(name: 'cnt_info')
  final FavCntInfoModel cntInfo;
  @JsonKey(name: 'link')
  final String link;
  @JsonKey(name: 'ctime')
  final int ctime;
  @JsonKey(name: 'pubtime')
  final int pubtime;
  @JsonKey(name: 'fav_time')
  final int favTime;
  @JsonKey(name: 'bv_id')
  final String? bvId;
  @JsonKey(name: 'bvid')
  final String? bvid;

  FavResourceModel({
    required this.id,
    required this.type,
    required this.title,
    required this.cover,
    required this.intro,
    required this.page,
    required this.duration,
    required this.upper,
    required this.attr,
    required this.cntInfo,
    required this.link,
    required this.ctime,
    required this.pubtime,
    required this.favTime,
    this.bvId,
    this.bvid,
  });

  factory FavResourceModel.fromJson(Map<String, dynamic> json) =>
      _$FavResourceModelFromJson(json);

  Map<String, dynamic> toJson() => _$FavResourceModelToJson(this);
}

@JsonSerializable()
class FavUpperModel {
  @JsonKey(name: 'mid')
  final int mid;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'face')
  final String face;

  FavUpperModel({required this.mid, required this.name, required this.face});

  factory FavUpperModel.fromJson(Map<String, dynamic> json) =>
      _$FavUpperModelFromJson(json);

  Map<String, dynamic> toJson() => _$FavUpperModelToJson(this);
}

@JsonSerializable()
class FavCntInfoModel {
  @JsonKey(name: 'collect')
  final int collect;
  @JsonKey(name: 'play')
  final int play;
  @JsonKey(name: 'danmaku')
  final int danmaku;

  FavCntInfoModel({
    required this.collect,
    required this.play,
    required this.danmaku,
  });

  factory FavCntInfoModel.fromJson(Map<String, dynamic> json) =>
      _$FavCntInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$FavCntInfoModelToJson(this);
}

@JsonSerializable()
class FavResourceListResponse {
  @JsonKey(name: 'info')
  final FavFolderInfoModel info;
  @JsonKey(name: 'medias')
  final List<FavResourceModel>? medias;
  @JsonKey(name: 'has_more')
  final bool hasMore;

  FavResourceListResponse({
    required this.info,
    this.medias,
    required this.hasMore,
  });

  factory FavResourceListResponse.fromJson(Map<String, dynamic> json) =>
      _$FavResourceListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FavResourceListResponseToJson(this);
}

@JsonSerializable()
class FavFolderInfoModel {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'fid')
  final int fid;
  @JsonKey(name: 'mid')
  final int mid;
  @JsonKey(name: 'attr')
  final int attr;
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'cover')
  final String cover;
  @JsonKey(name: 'upper')
  final FavUpperModel upper;
  @JsonKey(name: 'media_count')
  final int mediaCount;

  FavFolderInfoModel({
    required this.id,
    required this.fid,
    required this.mid,
    required this.attr,
    required this.title,
    required this.cover,
    required this.upper,
    required this.mediaCount,
  });

  factory FavFolderInfoModel.fromJson(Map<String, dynamic> json) =>
      _$FavFolderInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$FavFolderInfoModelToJson(this);
}
