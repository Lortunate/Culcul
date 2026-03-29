import 'package:culcul/data/api/auth_api.dart';
import 'package:culcul/data/api/weekly_api.dart';

import 'package:culcul/data/api/relation_api.dart';
import 'package:culcul/data/api/fav_api.dart';
import 'package:culcul/data/api/history_api.dart';
import 'package:culcul/data/api/toview_api.dart';

import 'package:culcul/data/api/dynamic_api.dart';
import 'package:culcul/data/api/notification_api.dart';
import 'package:culcul/data/api/profile_api.dart';
import 'package:culcul/data/api/ranking_api.dart';
import 'package:culcul/data/api/resource_api.dart';
import 'package:culcul/data/api/search_api.dart';
import 'package:culcul/data/api/video_api.dart';
import 'package:culcul/data/api/danmaku_api.dart';
import 'package:culcul/data/api/live_api.dart';
import 'package:culcul/data/network/dio_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:culcul/data/api/emote_api.dart';

part 'api_provider.g.dart';

@riverpod
ResourceApi basicResourceApi(Ref ref) {
  return ResourceApi(ref.watch(basicDioProvider));
}

@riverpod
ResourceApi resourceApi(Ref ref) {
  return ResourceApi(ref.watch(dioClientProvider));
}

@riverpod
EmoteApi emoteApi(Ref ref) {
  return EmoteApi(ref.watch(dioClientProvider));
}

@riverpod
AuthApi authApi(Ref ref) {
  return AuthApi(ref.watch(dioClientProvider));
}

@riverpod
WeeklyApi weeklyApi(Ref ref) {
  return WeeklyApi(ref.watch(dioClientProvider));
}

@riverpod
VideoApi videoApi(Ref ref) {
  return VideoApi(ref.watch(dioClientProvider));
}

@riverpod
SearchApi searchApi(Ref ref) {
  return SearchApi(ref.watch(dioClientProvider));
}

@riverpod
RankingApi rankingApi(Ref ref) {
  return RankingApi(ref.watch(dioClientProvider));
}

@riverpod
ProfileApi profileApi(Ref ref) {
  return ProfileApi(ref.watch(dioClientProvider));
}

@riverpod
DynamicApi dynamicApi(Ref ref) {
  return DynamicApi(ref.watch(dioClientProvider));
}

@riverpod
NotificationApi notificationApi(Ref ref) {
  return NotificationApi(ref.watch(dioClientProvider));
}

@riverpod
FavApi favApi(Ref ref) {
  return FavApi(ref.watch(dioClientProvider));
}

@riverpod
ToViewApi toViewApi(Ref ref) {
  return ToViewApi(ref.watch(dioClientProvider));
}

@riverpod
HistoryApi historyApi(Ref ref) {
  return HistoryApi(ref.watch(dioClientProvider));
}

@riverpod
RelationApi relationApi(Ref ref) {
  return RelationApi(ref.watch(dioClientProvider));
}

@riverpod
DanmakuApi danmakuApi(Ref ref) {
  return DanmakuApi(ref.watch(dioClientProvider));
}

@riverpod
LiveApi liveApi(Ref ref) {
  return LiveApi(ref.watch(dioClientProvider));
}
