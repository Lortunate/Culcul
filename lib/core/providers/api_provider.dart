import 'package:culcul/core/providers/storage_provider.dart';
import 'package:culcul/core/providers/cookie_jar_provider.dart';
import 'package:culcul/data/api/auth_api.dart';
import 'package:culcul/data/api/weekly_api.dart';
import 'package:culcul/repositories/weekly_repository.dart';

import 'package:culcul/data/api/relation_api.dart';
import 'package:culcul/repositories/relation_repository.dart';
import 'package:culcul/data/api/fav_api.dart';
import 'package:culcul/data/api/history_api.dart';
import 'package:culcul/repositories/history_repository.dart';
import 'package:culcul/repositories/fav_repository.dart';
import 'package:culcul/data/api/toview_api.dart';
import 'package:culcul/repositories/toview_repository.dart';

import 'package:culcul/data/api/dynamic_api.dart';
import 'package:culcul/data/api/notification_api.dart';
import 'package:culcul/data/api/profile_api.dart';
import 'package:culcul/data/api/ranking_api.dart';
import 'package:culcul/data/api/search_api.dart';
import 'package:culcul/data/api/video_api.dart';
import 'package:culcul/data/api/danmaku_api.dart';
import 'package:culcul/repositories/danmaku_repository.dart';
import 'package:culcul/data/api/live_api.dart';
import 'package:culcul/data/network/dio_client.dart';
import 'package:culcul/repositories/auth_repository.dart';
import 'package:culcul/repositories/dynamic_repository.dart';
import 'package:culcul/repositories/notification_repository.dart';
import 'package:culcul/repositories/profile_repository.dart';
import 'package:culcul/repositories/ranking_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:culcul/data/api/emote_api.dart';

part 'api_provider.g.dart';

@riverpod
EmoteApi emoteApi(Ref ref) {
  return EmoteApi(ref.watch(dioClientProvider));
}

@riverpod
AuthApi authApi(Ref ref) {
  return AuthApi(ref.watch(dioClientProvider));
}

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepository(
    ref.watch(authApiProvider),
    ref.watch(storageBoxProvider),
  );
}

@riverpod
WeeklyApi weeklyApi(Ref ref) {
  return WeeklyApi(ref.watch(dioClientProvider));
}

@riverpod
WeeklyRepository weeklyRepository(Ref ref) {
  return WeeklyRepository(ref.watch(weeklyApiProvider));
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
RankingRepository rankingRepository(Ref ref) {
  return RankingRepository(ref.watch(rankingApiProvider));
}

@riverpod
ProfileApi profileApi(Ref ref) {
  return ProfileApi(ref.watch(dioClientProvider));
}

@riverpod
ProfileRepository profileRepository(Ref ref) {
  return ProfileRepository(api: ref.watch(profileApiProvider));
}

@riverpod
DynamicApi dynamicApi(Ref ref) {
  return DynamicApi(ref.watch(dioClientProvider));
}

@riverpod
DynamicRepository dynamicRepository(Ref ref) {
  return DynamicRepository(
    ref.watch(dynamicApiProvider),
    ref.watch(cookieJarProvider),
  );
}

@riverpod
NotificationApi notificationApi(Ref ref) {
  return NotificationApi(ref.watch(dioClientProvider));
}

@riverpod
NotificationRepository notificationRepository(Ref ref) {
  return NotificationRepository(ref.watch(notificationApiProvider));
}

@riverpod
FavApi favApi(Ref ref) {
  return FavApi(ref.watch(dioClientProvider));
}

@riverpod
FavRepository favRepository(Ref ref) {
  return FavRepository(ref.watch(favApiProvider));
}

@riverpod
ToViewApi toViewApi(Ref ref) {
  return ToViewApi(ref.watch(dioClientProvider));
}

@riverpod
ToViewRepository toViewRepository(Ref ref) {
  return ToViewRepository(ref.watch(toViewApiProvider));
}

@riverpod
HistoryApi historyApi(Ref ref) {
  return HistoryApi(ref.watch(dioClientProvider));
}

@riverpod
HistoryRepository historyRepository(Ref ref) {
  return HistoryRepository(ref.watch(historyApiProvider));
}

@riverpod
RelationApi relationApi(Ref ref) {
  return RelationApi(ref.watch(dioClientProvider));
}

@riverpod
RelationRepository relationRepository(Ref ref) {
  return RelationRepository(ref.watch(relationApiProvider));
}

@riverpod
DanmakuApi danmakuApi(Ref ref) {
  return DanmakuApi(ref.watch(dioClientProvider));
}

@riverpod
DanmakuRepository danmakuRepository(Ref ref) {
  return DanmakuRepository(
    ref.watch(danmakuApiProvider),
    ref.watch(dioClientProvider),
  );
}

@riverpod
LiveApi liveApi(Ref ref) {
  return LiveApi(ref.watch(dioClientProvider));
}
