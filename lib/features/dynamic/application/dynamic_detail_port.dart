import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/dynamic/application/dynamic_feed_port.dart';
import 'package:culcul/features/dynamic/application/models/dynamic_response.dart';

abstract interface class DynamicDetailPort implements DynamicFeedPort {
  Future<Result<DynamicItem, AppError>> getDetail(String id);
}
