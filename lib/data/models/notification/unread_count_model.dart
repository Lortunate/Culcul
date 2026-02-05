import 'package:freezed_annotation/freezed_annotation.dart';

part 'unread_count_model.freezed.dart';
part 'unread_count_model.g.dart';

@freezed
abstract class UnreadCountModel with _$UnreadCountModel {
  const factory UnreadCountModel({
    @Default(0) int at,
    @Default(0) int chat,
    @Default(0) int coin,
    @Default(0) int danmu,
    @Default(0) int favorite,
    @Default(0) int like,
    @JsonKey(name: 'recv_like') @Default(0) int recvLike,
    @JsonKey(name: 'recv_reply') @Default(0) int recvReply,
    @Default(0) int reply,
    @JsonKey(name: 'sys_msg') @Default(0) int sysMsg,
    @Default(0) int up,
  }) = _UnreadCountModel;

  factory UnreadCountModel.fromJson(Map<String, dynamic> json) =>
      _$UnreadCountModelFromJson(json);
}
