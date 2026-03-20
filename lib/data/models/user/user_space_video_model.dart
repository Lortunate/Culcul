import 'package:culcul/data/models/video/video_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_space_video_model.freezed.dart';
part 'user_space_video_model.g.dart';

@freezed
abstract class UserSpaceVideoModel with _$UserSpaceVideoModel {
  const factory UserSpaceVideoModel({
    required int aid,
    required String bvid,
    required String title,
    required String pic,
    required String tname,
    required int duration,
    @JsonKey(name: 'pubdate') required int pubDate,
    required int ctime,
    @Default('') String desc,
    @Default(0) int state,
    @Default(0) int attribute,
    required int tid,
    required Owner owner,
    required Stat stat,
    @Default('') String reason,
    @JsonKey(name: 'inter_video') @Default(false) bool interVideo,
  }) = _UserSpaceVideoModel;

  factory UserSpaceVideoModel.fromJson(Map<String, dynamic> json) {
    // Adapter for flattened JSON from x/space/wbi/arc/search
    if (json['owner'] == null && json.containsKey('author')) {
      final adjusted = Map<String, dynamic>.from(json);

      // Adapt Owner
      adjusted['owner'] = {
        'mid': json['mid'] ?? 0,
        'name': json['author'],
        'face': '',
      };

      // Adapt Stat
      adjusted['stat'] = {
        'view': json['play'] ?? 0,
        'danmaku': json['video_review'] ?? 0,
        'reply': json['comment'] ?? 0,
        'like': 0,
        'coin': 0,
        'favorite': 0,
        'share': 0,
      };

      // Adapt Duration (MM:SS string to int seconds)
      if (json['length'] is String) {
        final parts = (json['length'] as String).split(':');
        int seconds = 0;
        if (parts.length == 2) {
          seconds =
              (int.tryParse(parts[0]) ?? 0) * 60 +
              (int.tryParse(parts[1]) ?? 0);
        } else if (parts.length == 3) {
          seconds =
              (int.tryParse(parts[0]) ?? 0) * 3600 +
              (int.tryParse(parts[1]) ?? 0) * 60 +
              (int.tryParse(parts[2]) ?? 0);
        }
        adjusted['duration'] = seconds;
      }

      // Adapt Dates
      if (json.containsKey('created')) {
        adjusted['pubdate'] = json['created'];
        adjusted['ctime'] = json['created'];
      }

      // Adapt Description
      if (json.containsKey('description')) {
        adjusted['desc'] = json['description'];
      }

      // Adapt Type ID
      if (json.containsKey('typeid')) {
        adjusted['tid'] = json['typeid'];
      }

      // Defaults for missing required fields
      adjusted.putIfAbsent('tname', () => '');

      return _$UserSpaceVideoModelFromJson(adjusted);
    }

    return _$UserSpaceVideoModelFromJson(json);
  }
}

@freezed
abstract class UserSpaceVideoListResponse with _$UserSpaceVideoListResponse {
  const factory UserSpaceVideoListResponse({
    required UserSpaceVideoList list,
    required UserSpacePage page,
  }) = _UserSpaceVideoListResponse;

  factory UserSpaceVideoListResponse.fromJson(Map<String, dynamic> json) =>
      _$UserSpaceVideoListResponseFromJson(json);
}

@freezed
abstract class UserSpaceVideoList with _$UserSpaceVideoList {
  const factory UserSpaceVideoList({
    @Default([]) List<UserSpaceVideoModel> vlist,
  }) = _UserSpaceVideoList;

  factory UserSpaceVideoList.fromJson(Map<String, dynamic> json) =>
      _$UserSpaceVideoListFromJson(json);
}

@freezed
abstract class UserSpacePage with _$UserSpacePage {
  const factory UserSpacePage({
    @Default(1) int pn,
    @Default(30) int ps,
    @Default(0) int count,
  }) = _UserSpacePage;

  factory UserSpacePage.fromJson(Map<String, dynamic> json) =>
      _$UserSpacePageFromJson(json);
}
