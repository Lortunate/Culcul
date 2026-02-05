import 'package:culcul/data/models/notification/unread_count_model.dart';
import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/repositories/notification_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'unread_count_provider.g.dart';

@riverpod
Future<UnreadCountModel> unreadCount(Ref ref) {
  return ref.watch(notificationRepositoryProvider).getUnreadCount();
}
