import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/video/application/models/subtitle.dart';

/// Video subtitle application boundary.
abstract interface class SubtitlePort {
  Future<Result<SubtitleContent, AppError>> fetchSubtitleContent(String url);
}
