import 'package:culcul/features/notification/data/dtos/system_notice.dart' as dto;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'system_notice_contracts.freezed.dart';

@freezed
sealed class SystemNotice with _$SystemNotice {
  const factory SystemNotice({
    required int id,
    String? title,
    String? text,
    required int time,
    String? uri,
    String? jumpText,
  }) = _SystemNotice;
}

extension SystemNoticeDtoMapper on dto.SystemNotice {
  SystemNotice toSystemNotice() {
    return SystemNotice(
      id: id,
      title: title,
      text: text,
      time: time,
      uri: uri,
      jumpText: jumpText,
    );
  }
}

extension SystemNoticeDtoListMapper on Iterable<dto.SystemNotice> {
  List<SystemNotice> toSystemNotices() {
    return map((item) => item.toSystemNotice()).toList();
  }
}
