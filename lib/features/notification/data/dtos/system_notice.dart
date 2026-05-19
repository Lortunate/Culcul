import 'package:freezed_annotation/freezed_annotation.dart';

part 'system_notice.freezed.dart';
part 'system_notice.g.dart';

@freezed
sealed class SystemNotice with _$SystemNotice {
  const SystemNotice._();

  const factory SystemNotice({
    required int id,
    String? title,
    String? text,
    required int time,
    String? uri,
    @JsonKey(name: 'jump_text') String? jumpText,
  }) = _SystemNotice;

  factory SystemNotice.fromJson(Map<String, dynamic> json) =>
      _$SystemNoticeFromJson(json);
}
