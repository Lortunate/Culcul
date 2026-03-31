import 'package:freezed_annotation/freezed_annotation.dart';

part 'to_view_model_dto.freezed.dart';
part 'to_view_model_dto.g.dart';

@freezed
sealed class ToViewModelDto with _$ToViewModelDto {
  const ToViewModelDto._();

  const factory ToViewModelDto({
    @JsonKey(name: 'aid') int? aid,
    @JsonKey(name: 'videos') @Default(0) int? videos,
    @JsonKey(name: 'tid') @Default(0) int? tid,
    @JsonKey(name: 'tname') @Default('') String? tname,
    @JsonKey(name: 'copyright') @Default(1) int? copyright,
    @JsonKey(name: 'pic') @Default('') String? pic,
    @JsonKey(name: 'title') @Default('') String? title,
    @JsonKey(name: 'pubdate') @Default(0) int? pubdate,
    @JsonKey(name: 'ctime') @Default(0) int? ctime,
    @JsonKey(name: 'desc') @Default('') String? desc,
    @JsonKey(name: 'state') @Default(0) int? state,
    @JsonKey(name: 'duration') @Default(0) int? duration,
    @JsonKey(name: 'rights') Map<String, dynamic>? rights,
    @JsonKey(name: 'owner') ToViewOwnerModelDto? owner,
    @JsonKey(name: 'stat') ToViewStatModelDto? stat,
    @JsonKey(name: 'dynamic') String? dynamicText,
    @JsonKey(name: 'cid') @Default(0) int? cid,
    @JsonKey(name: 'progress') @Default(0) int? progress,
    @JsonKey(name: 'add_at') @Default(0) int? addAt,
    @JsonKey(name: 'bvid') @Default('') String? bvid,
  }) = _ToViewModelDto;

  bool get hasProgress => (progress ?? 0) > 0;

  double get progressRatio {
    final d = (duration ?? 0) == 0 ? 1 : (duration ?? 1);
    return (progress ?? 0) / d;
  }

  factory ToViewModelDto.fromJson(Map<String, dynamic> json) =>
      _$ToViewModelDtoFromJson(json);
}

@freezed
sealed class ToViewOwnerModelDto with _$ToViewOwnerModelDto {
  const factory ToViewOwnerModelDto({
    @Default(0) int mid,
    @Default('') String name,
    @Default('') String face,
  }) = _ToViewOwnerModelDto;

  factory ToViewOwnerModelDto.fromJson(Map<String, dynamic> json) =>
      _$ToViewOwnerModelDtoFromJson(json);
}

@freezed
sealed class ToViewStatModelDto with _$ToViewStatModelDto {
  const factory ToViewStatModelDto({
    @JsonKey(name: 'aid') int? aid,
    @JsonKey(name: 'view') @Default(0) int? view,
    @JsonKey(name: 'danmaku') @Default(0) int? danmaku,
    @JsonKey(name: 'reply') @Default(0) int? reply,
    @JsonKey(name: 'favorite') @Default(0) int? favorite,
    @JsonKey(name: 'coin') @Default(0) int? coin,
    @JsonKey(name: 'share') @Default(0) int? share,
    @JsonKey(name: 'like') @Default(0) int? like,
    @JsonKey(name: 'dislike') @Default(0) int? dislike,
  }) = _ToViewStatModelDto;

  factory ToViewStatModelDto.fromJson(Map<String, dynamic> json) =>
      _$ToViewStatModelDtoFromJson(json);
}

@freezed
sealed class ToViewListResponseDto with _$ToViewListResponseDto {
  const factory ToViewListResponseDto({
    @JsonKey(name: 'count') @Default(0) int count,
    @JsonKey(name: 'list') @Default([]) List<ToViewModelDto> list,
  }) = _ToViewListResponseDto;

  factory ToViewListResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ToViewListResponseDtoFromJson(json);
}
