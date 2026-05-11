import 'package:culcul/core/contracts/video_model_contract.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_space_video_model.freezed.dart';
part 'user_space_video_model.g.dart';

@freezed
sealed class UserSpaceVideoModel with _$UserSpaceVideoModel {
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
    required VideoOwner owner,
    required VideoStat stat,
    @Default('') String reason,
    @JsonKey(name: 'inter_video') @Default(false) bool interVideo,
  }) = _UserSpaceVideoModel;

  factory UserSpaceVideoModel.fromJson(Map<String, dynamic> json) =>
      _$UserSpaceVideoModelFromJson(_normalizeUserSpaceVideoJson(json));
}

@freezed
sealed class UserSpaceVideoListResponse with _$UserSpaceVideoListResponse {
  const factory UserSpaceVideoListResponse({
    required UserSpaceVideoList list,
    required UserSpacePage page,
  }) = _UserSpaceVideoListResponse;

  factory UserSpaceVideoListResponse.fromJson(Map<String, dynamic> json) =>
      _$UserSpaceVideoListResponseFromJson(json);
}

@freezed
sealed class UserSpaceVideoList with _$UserSpaceVideoList {
  const factory UserSpaceVideoList({@Default([]) List<UserSpaceVideoModel> vlist}) =
      _UserSpaceVideoList;

  factory UserSpaceVideoList.fromJson(Map<String, dynamic> json) =>
      _$UserSpaceVideoListFromJson(json);
}

@freezed
sealed class UserSpacePage with _$UserSpacePage {
  const factory UserSpacePage({
    @Default(1) int pn,
    @Default(30) int ps,
    @Default(0) int count,
  }) = _UserSpacePage;

  factory UserSpacePage.fromJson(Map<String, dynamic> json) =>
      _$UserSpacePageFromJson(json);
}

Map<String, dynamic> _normalizeUserSpaceVideoJson(Map<String, dynamic> json) {
  if (json['owner'] != null || !json.containsKey('author')) {
    return json;
  }

  final adjusted = Map<String, dynamic>.from(json);

  adjusted['owner'] = {'mid': json['mid'] ?? 0, 'name': json['author'], 'face': ''};

  adjusted['stat'] = {
    'view': json['play'] ?? 0,
    'danmaku': json['video_review'] ?? 0,
    'reply': json['comment'] ?? 0,
    'like': 0,
    'coin': 0,
    'favorite': 0,
    'share': 0,
  };

  if (json['length'] is String) {
    final parts = (json['length'] as String).split(':');
    var seconds = 0;
    if (parts.length == 2) {
      seconds = (int.tryParse(parts[0]) ?? 0) * 60 + (int.tryParse(parts[1]) ?? 0);
    } else if (parts.length == 3) {
      seconds =
          (int.tryParse(parts[0]) ?? 0) * 3600 +
          (int.tryParse(parts[1]) ?? 0) * 60 +
          (int.tryParse(parts[2]) ?? 0);
    }
    adjusted['duration'] = seconds;
  }

  if (json.containsKey('created')) {
    adjusted['pubdate'] = json['created'];
    adjusted['ctime'] = json['created'];
  }

  if (json.containsKey('description')) {
    adjusted['desc'] = json['description'];
  }

  if (json.containsKey('typeid')) {
    adjusted['tid'] = json['typeid'];
  }

  adjusted.putIfAbsent('tname', () => '');

  return adjusted;
}
