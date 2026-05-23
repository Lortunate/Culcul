import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/dynamic/application/models/dynamic_response.dart';
import 'package:culcul/features/dynamic/domain/entities/dynamic_queries.dart';

/// Dynamic feed application boundary.
abstract interface class DynamicFeedPort {
  Future<Result<DynamicData, AppError>> getFeed(DynamicFeedQuery query);

  Future<Result<DynamicData, AppError>> getTopicFeed(TopicDynamicFeedQuery query);

  Future<Result<void, AppError>> likeDynamic(String id, bool like);
}
