import 'package:culcul/features/notification/domain/entities/system_notice.dart';

SystemNotice systemNoticeFromJson(Map<String, dynamic> json) {
  return SystemNotice(
    id: json['id'] as int? ?? 0,
    title: json['title'] as String?,
    text: json['text'] as String?,
    time: json['time'] as int? ?? 0,
    uri: json['uri'] as String?,
    jumpText: json['jump_text'] as String? ?? json['jumpText'] as String?,
  );
}

Map<String, dynamic> systemNoticeToJson(SystemNotice notice) {
  return {
    'id': notice.id,
    'title': notice.title,
    'text': notice.text,
    'time': notice.time,
    'uri': notice.uri,
    'jump_text': notice.jumpText,
  };
}
