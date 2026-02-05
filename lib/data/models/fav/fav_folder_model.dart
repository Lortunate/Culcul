import 'package:culcul/data/models/fav/fav_resource_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fav_folder_model.g.dart';

@JsonSerializable()
class FavFolderModel {
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
  @JsonKey(name: 'fav_state')
  final int favState;
  @JsonKey(name: 'media_count')
  final int mediaCount;
  @JsonKey(name: 'cover')
  final String? cover;
  @JsonKey(name: 'upper')
  final FavUpperModel? upper;
  @JsonKey(name: 'intro')
  final String? intro;
  @JsonKey(name: 'ctime')
  final int? ctime;
  @JsonKey(name: 'mtime')
  final int? mtime;
  @JsonKey(name: 'state')
  final int? state;

  FavFolderModel({
    required this.id,
    required this.fid,
    required this.mid,
    required this.attr,
    required this.title,
    required this.favState,
    required this.mediaCount,
    this.cover,
    this.upper,
    this.intro,
    this.ctime,
    this.mtime,
    this.state,
  });

  FavFolderModel copyWith({
    int? id,
    int? fid,
    int? mid,
    int? attr,
    String? title,
    int? favState,
    int? mediaCount,
    String? cover,
    FavUpperModel? upper,
    String? intro,
    int? ctime,
    int? mtime,
    int? state,
  }) {
    return FavFolderModel(
      id: id ?? this.id,
      fid: fid ?? this.fid,
      mid: mid ?? this.mid,
      attr: attr ?? this.attr,
      title: title ?? this.title,
      favState: favState ?? this.favState,
      mediaCount: mediaCount ?? this.mediaCount,
      cover: cover ?? this.cover,
      upper: upper ?? this.upper,
      intro: intro ?? this.intro,
      ctime: ctime ?? this.ctime,
      mtime: mtime ?? this.mtime,
      state: state ?? this.state,
    );
  }

  factory FavFolderModel.fromJson(Map<String, dynamic> json) =>
      _$FavFolderModelFromJson(json);

  Map<String, dynamic> toJson() => _$FavFolderModelToJson(this);
}

@JsonSerializable()
class FavFolderListResponse {
  @JsonKey(name: 'count')
  final int count;
  @JsonKey(name: 'list')
  final List<FavFolderModel>? list;

  FavFolderListResponse({required this.count, this.list});

  factory FavFolderListResponse.fromJson(Map<String, dynamic> json) =>
      _$FavFolderListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FavFolderListResponseToJson(this);
}
