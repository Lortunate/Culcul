import 'package:culcul/core/contracts/bilibili_link_contract.dart';
import 'package:culcul/features/notification/domain/entities/notification_entry.dart';
import 'package:culcul/features/notification/domain/entities/system_notice.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

part 'notification_navigation.parser.dart';

enum NotificationNavigationKind { video, dynamicDetail, external, none }

class NotificationNavigationTarget {
  const NotificationNavigationTarget._({
    required this.kind,
    this.videoId,
    this.dynamicId,
    this.externalUri,
  });

  const NotificationNavigationTarget.video(String videoId)
    : this._(kind: NotificationNavigationKind.video, videoId: videoId);

  const NotificationNavigationTarget.dynamic(String dynamicId)
    : this._(kind: NotificationNavigationKind.dynamicDetail, dynamicId: dynamicId);

  const NotificationNavigationTarget.external(Uri uri)
    : this._(kind: NotificationNavigationKind.external, externalUri: uri);

  const NotificationNavigationTarget.none()
    : this._(kind: NotificationNavigationKind.none);

  final NotificationNavigationKind kind;
  final String? videoId;
  final String? dynamicId;
  final Uri? externalUri;
}

typedef NotificationTargetOpener =
    Future<bool> Function(NotificationNavigationTarget target);

Future<bool> openNotificationNavigationTarget(
  NotificationNavigationTarget target, {
  required ValueChanged<String> onOpenVideo,
  required ValueChanged<String> onOpenDynamic,
  Future<bool> Function(Uri uri)? launchExternal,
}) async {
  switch (target.kind) {
    case NotificationNavigationKind.video:
      onOpenVideo(target.videoId!);
      return true;
    case NotificationNavigationKind.dynamicDetail:
      onOpenDynamic(target.dynamicId!);
      return true;
    case NotificationNavigationKind.external:
      final launcher = launchExternal ?? launchUrl;
      try {
        return await launcher(target.externalUri!);
      } catch (_) {
        return false;
      }
    case NotificationNavigationKind.none:
      return false;
  }
}
