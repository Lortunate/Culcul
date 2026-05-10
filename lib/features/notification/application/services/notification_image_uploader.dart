import 'dart:typed_data';

import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/notification/domain/entities/image_upload_result.dart';

abstract class NotificationImageUploader {
  Future<Result<ImageUploadResult, AppError>> uploadImage(
    Uint8List bytes,
    String filename,
  );
}
