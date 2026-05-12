import 'package:dio/dio.dart';

class DynamicFeedQuery {
  final String? type;
  final String? offset;

  const DynamicFeedQuery({this.type, this.offset});
}

class SpaceDynamicFeedQuery {
  final int hostMid;
  final String? offset;
  final bool forceRefresh;
  final CancelToken? cancelToken;

  const SpaceDynamicFeedQuery({
    required this.hostMid,
    this.offset,
    this.forceRefresh = false,
    this.cancelToken,
  });
}

class TopicDynamicFeedQuery {
  final int topicId;
  final String? offset;

  const TopicDynamicFeedQuery({required this.topicId, this.offset});
}
