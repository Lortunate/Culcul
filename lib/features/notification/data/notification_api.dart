import 'package:culcul/core/data/network/models/api_response.dart';
import 'package:culcul/features/notification/data/dtos/private_message_model.dart';
import 'package:culcul/features/notification/data/dtos/reply_model.dart';
import 'package:culcul/features/notification/data/notification_paging_constants.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'notification_api.g.dart';

@RestApi()
abstract class NotificationApi {
  factory NotificationApi(Dio dio) = _NotificationApi;

  @GET('https://api.bilibili.com/x/msgfeed/unread')
  Future<ApiResponse<dynamic>> getUnreadCount();

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
  Future<ApiResponse<Object>> getLikeList({
    @Query('id') int? id,
    @Query('like_time') int? likeTime,
  });

  @GET('https://api.vc.bilibili.com/session_svr/v1/session_svr/get_sessions')
  Future<ApiResponse<PrivateMessageSessionResponse>> getPrivateSessions({
    @Query('session_type') int sessionType = 1,
    @Query('size') int size = notificationPrivateMessagePageSize,
    @Query('end_ts') int? endTs,
  });

  @GET('https://api.vc.bilibili.com/svr_sync/v1/svr_sync/fetch_session_msgs')
  Future<ApiResponse<PrivateMessageListResponse>> getPrivateMessages({
    @Query('talker_id') required int talkerId,
    @Query('session_type') int sessionType = 1,
    @Query('size') int size = notificationPrivateMessagePageSize,
    @Query('begin_seqno') int? beginSeqno,
    @Query('end_seqno') int? endSeqno,
    @Query('sender_device_id') int senderDeviceId = 1,
    @Query('build') int build = 0,
    @Query('mobi_app') String mobiApp = 'web',
  });

  @POST('https://api.vc.bilibili.com/web_im/v1/web_im/send_msg')
  @FormUrlEncoded()
  @Headers({'x-bili-wbi': 'true', 'x-bili-csrf': 'true'})
  Future<ApiResponse<dynamic>> sendPrivateMessage({
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
