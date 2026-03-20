import 'package:freezed_annotation/freezed_annotation.dart';

part 'player_info.freezed.dart';
part 'player_info.g.dart';

@freezed
sealed class PlayerInfo with _$PlayerInfo {
  const factory PlayerInfo({@JsonKey(name: 'dm_mask') DmMask? dmMask}) =
      _PlayerInfo;

  factory PlayerInfo.fromJson(Map<String, dynamic> json) =>
      _$PlayerInfoFromJson(json);
}

@freezed
sealed class DmMask with _$DmMask {
  const factory DmMask({
    @JsonKey(name: 'mask_url') required String maskUrl,
    required int fps,
  }) = _DmMask;

  factory DmMask.fromJson(Map<String, dynamic> json) => _$DmMaskFromJson(json);
}
