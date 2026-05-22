import 'package:freezed_annotation/freezed_annotation.dart';

part 'live_guard_list_dto.freezed.dart';
part 'live_guard_list_dto.g.dart';

@freezed
sealed class LiveGuardListDto with _$LiveGuardListDto {
  const factory LiveGuardListDto({
    required LiveGuardInfoDto info,
    @Default([]) List<LiveGuardItemDto> top3,
    @Default([]) List<LiveGuardItemDto> list,
  }) = _LiveGuardListDto;

  factory LiveGuardListDto.fromJson(Map<String, dynamic> json) =>
      _$LiveGuardListDtoFromJson(json);
}

@freezed
sealed class LiveGuardInfoDto with _$LiveGuardInfoDto {
  const factory LiveGuardInfoDto({
    required int num,
    required int page,
    required int now,
  }) = _LiveGuardInfoDto;

  factory LiveGuardInfoDto.fromJson(Map<String, dynamic> json) =>
      _$LiveGuardInfoDtoFromJson(json);
}

@freezed
sealed class LiveGuardItemDto with _$LiveGuardItemDto {
  const factory LiveGuardItemDto({
    required int ruid,
    required int rank,
    @JsonKey(name: 'uinfo') required LiveGuardUserInfoDto userInfo,
    @JsonKey(name: 'guard_level') required int guardLevel,
  }) = _LiveGuardItemDto;

  factory LiveGuardItemDto.fromJson(Map<String, dynamic> json) =>
      _$LiveGuardItemDtoFromJson(json);
}

@freezed
sealed class LiveGuardUserInfoDto with _$LiveGuardUserInfoDto {
  const factory LiveGuardUserInfoDto({
    required int uid,
    required LiveGuardUserBaseDto base,
  }) = _LiveGuardUserInfoDto;

  factory LiveGuardUserInfoDto.fromJson(Map<String, dynamic> json) =>
      _$LiveGuardUserInfoDtoFromJson(json);
}

@freezed
sealed class LiveGuardUserBaseDto with _$LiveGuardUserBaseDto {
  const factory LiveGuardUserBaseDto({required String name, required String face}) =
      _LiveGuardUserBaseDto;

  factory LiveGuardUserBaseDto.fromJson(Map<String, dynamic> json) =>
      _$LiveGuardUserBaseDtoFromJson(json);
}
