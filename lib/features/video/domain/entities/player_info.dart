import 'package:freezed_annotation/freezed_annotation.dart';

part 'player_info.freezed.dart';

@freezed
sealed class PlayerInfo with _$PlayerInfo {
  const factory PlayerInfo({DmMask? dmMask}) = _PlayerInfo;
}

@freezed
sealed class DmMask with _$DmMask {
  const factory DmMask({required String maskUrl, required int fps}) = _DmMask;
}
