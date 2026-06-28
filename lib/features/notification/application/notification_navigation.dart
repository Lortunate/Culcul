import 'package:culcul/core/models/bilibili_link_contract.dart';
import 'package:culcul/features/notification/models/notification_entry.dart';
import 'package:culcul/features/notification/models/system_notice.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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

class NotificationNavigationParser {
  const NotificationNavigationParser();

  static const _linkParser = BilibiliLinkParser();

  NotificationNavigationTarget fromNotificationDetail(NotificationEntryDetail detail) {
    return parse(
      uri: detail.uri,
      nativeUri: detail.nativeUri,
      type: detail.type,
      business: detail.business,
      subjectId: detail.subjectId,
    );
  }

  NotificationNavigationTarget fromSystemNotice(SystemNotice notice) {
    return parse(uri: notice.uri);
  }

  NotificationNavigationTarget parse({
    String? uri,
    String? nativeUri,
    String? type,
    String? business,
    int? subjectId,
  }) {
    final normalizedType = (type ?? '').toLowerCase();
    final normalizedBusiness = (business ?? '').toLowerCase();
    final candidates = <String>[
      if (_hasText(nativeUri)) nativeUri!.trim(),
      if (_hasText(uri)) uri!.trim(),
    ];

    for (final candidate in candidates) {
      final target = _linkParser.parse(candidate);
      switch (target.kind) {
        case BilibiliLinkKind.video:
          return NotificationNavigationTarget.video(target.videoId!);
        case BilibiliLinkKind.dynamicDetail:
          return NotificationNavigationTarget.dynamic(target.dynamicId!);
        case BilibiliLinkKind.article:
          final segments = target.uri!.pathSegments;
          if (segments.length >= 2 && segments.first.toLowerCase() == 'opus') {
            return NotificationNavigationTarget.dynamic(segments[1]);
          }
          continue;
        case BilibiliLinkKind.liveRoom:
        case BilibiliLinkKind.external:
        case BilibiliLinkKind.none:
          continue;
      }
    }

    if ((normalizedBusiness == 'archive' || normalizedType == 'video') &&
        subjectId != null &&
        subjectId > 0) {
      return NotificationNavigationTarget.video('av$subjectId');
    }

    if ((normalizedBusiness == 'dynamic' ||
            normalizedType == 'dynamic' ||
            normalizedType == 'opus') &&
        subjectId != null &&
        subjectId > 0) {
      return NotificationNavigationTarget.dynamic(subjectId.toString());
    }

    for (final candidate in candidates) {
      final externalUri = Uri.tryParse(candidate);
      if (externalUri != null && externalUri.scheme.isNotEmpty) {
        final scheme = externalUri.scheme.toLowerCase();
        if (scheme == 'http' || scheme == 'https' || scheme == 'bilibili') {
          return NotificationNavigationTarget.external(externalUri);
        }
      }
    }

    return const NotificationNavigationTarget.none();
  }

  static bool _hasText(String? value) => value != null && value.trim().isNotEmpty;
}
