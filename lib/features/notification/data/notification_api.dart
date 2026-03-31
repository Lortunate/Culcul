import 'dart:io';

import 'package:culcul/core/network/models/api_response.dart';
import 'package:culcul/features/notification/data/dtos/notification_models.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'notification_api.g.dart';

@RestApi()
abstract class NotificationApi {
  factory NotificationApi(Dio dio) = _NotificationApi;

  @POST('https://api.vc.bilibili.com/api/v1/drawImage/upload')
  @MultiPart()
  Future<ApiResponse<ImageUploadResponse>> uploadImage({
    @Part(name: 'file_up') required File file,
    @Part(name: 'biz') String biz = 'draw',
    @Part(name: 'category') String category = 'daily',
    @Part(name: 'build') int build = 0,
    @Part(name: 'mobi_app') String mobiApp = 'web',
  });

  @GET('https://api.bilibili.com/x/msgfeed/unread')
  Future<ApiResponse<UnreadCountModel>> getUnreadCount();

  @GET('https://api.bilibili.com/x/msgfeed/reply')
  Future<ApiResponse<ReplyResponse>> getReplyList({
    @Query('id') int? id,
    @Query('reply_time') int? replyTime,
  });

  @GET('https://api.bilibili.com/x/msgfeed/at')
  Future<ApiResponse<ReplyResponse>> getAtList({
    @Query('id') int? id,
    @Query('at_time') int? atTime,
  });

  @GET('https://api.bilibili.com/x/msgfeed/like')
  Future<ApiResponse<LikeResponse>> getLikeList({
    @Query('id') int? id,
    @Query('like_time') int? likeTime,
  });

  @GET('https://api.vc.bilibili.com/session_svr/v1/session_svr/get_sessions')
  Future<ApiResponse<PrivateMessageSessionResponse>> getPrivateSessions({
    @Query('session_type') int sessionType = 1,
    @Query('size') int size = 20,
    @Query('end_ts') int? endTs,
  });

  @GET('https://api.vc.bilibili.com/svr_sync/v1/svr_sync/fetch_session_msgs')
  Future<ApiResponse<PrivateMessageListResponse>> getPrivateMessages({
    @Query('talker_id') required int talkerId,
    @Query('session_type') int sessionType = 1,
    @Query('size') int size = 20,
    @Query('begin_seqno') int? beginSeqno,
    @Query('end_seqno') int? endSeqno,
    @Query('sender_device_id') int senderDeviceId = 1,
    @Query('build') int build = 0,
    @Query('mobi_app') String mobiApp = 'web',
  });

  @POST('https://api.vc.bilibili.com/web_im/v1/web_im/send_msg')
  @FormUrlEncoded()
  @Headers({'x-bili-wbi': 'true', 'x-bili-csrf': 'true'})
  Future<ApiResponse<SendMessageResponse>> sendPrivateMessage({
    @Query('w_sender_uid') required int wSenderUid,
    @Query('w_receiver_id') required int wReceiverId,
    @Query('w_dev_id') required String wDevId,
    @Field('msg[sender_uid]') required int senderUid,
    @Field('msg[receiver_id]') required int receiverId,
    @Field('msg[receiver_type]') required int receiverType,
    @Field('msg[msg_type]') required int msgType,
    @Field('msg[dev_id]') required String devId,
    @Field('msg[timestamp]') required int timestamp,
    @Field('msg[content]') required String content,
  });
}
