// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fav_folder_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavFolderModel _$FavFolderModelFromJson(Map<String, dynamic> json) =>
    FavFolderModel(
      id: (json['id'] as num).toInt(),
      fid: (json['fid'] as num).toInt(),
      mid: (json['mid'] as num).toInt(),
      attr: (json['attr'] as num).toInt(),
      title: json['title'] as String,
      favState: (json['fav_state'] as num).toInt(),
      mediaCount: (json['media_count'] as num).toInt(),
      cover: json['cover'] as String?,
      upper: json['upper'] == null
          ? null
          : FavUpperModel.fromJson(json['upper'] as Map<String, dynamic>),
      intro: json['intro'] as String?,
      ctime: (json['ctime'] as num?)?.toInt(),
      mtime: (json['mtime'] as num?)?.toInt(),
      state: (json['state'] as num?)?.toInt(),
    );

Map<String, dynamic> _$FavFolderModelToJson(FavFolderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fid': instance.fid,
      'mid': instance.mid,
      'attr': instance.attr,
      'title': instance.title,
      'fav_state': instance.favState,
      'media_count': instance.mediaCount,
      'cover': instance.cover,
      'upper': instance.upper,
      'intro': instance.intro,
      'ctime': instance.ctime,
      'mtime': instance.mtime,
      'state': instance.state,
    };

FavFolderListResponse _$FavFolderListResponseFromJson(
  Map<String, dynamic> json,
) => FavFolderListResponse(
  count: (json['count'] as num).toInt(),
  list: (json['list'] as List<dynamic>?)
      ?.map((e) => FavFolderModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$FavFolderListResponseToJson(
  FavFolderListResponse instance,
) => <String, dynamic>{'count': instance.count, 'list': instance.list};
