import 'package:freezed_annotation/freezed_annotation.dart';

part 'system_notice.freezed.dart';

@freezed
sealed class SystemNotice with _$SystemNotice {
  const SystemNotice._();

  const factory SystemNotice({
    required int id,
    String? title,
    String? text,
    required int time,
    String? uri,
    String? jumpText,
  }) = _SystemNotice;
}
