import 'package:culcul/core/contracts/video_model_contract.dart';
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
    @JsonKey(name: 'owner') VideoOwner? owner,
    @JsonKey(name: 'stat') VideoStat? stat,
    @JsonKey(name: 'dynamic') String? dynamicText,
    @JsonKey(name: 'cid') @Default(0) int? cid,
    @JsonKey(name: 'progress') @Default(0) int? progress,
    @JsonKey(name: 'add_at') @Default(0) int? addAt,
    @JsonKey(name: 'bvid') @Default('') String? bvid,
  }) = _ToViewModelDto;

  factory ToViewModelDto.fromJson(Map<String, dynamic> json) =>
      _$ToViewModelDtoFromJson(json);
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
