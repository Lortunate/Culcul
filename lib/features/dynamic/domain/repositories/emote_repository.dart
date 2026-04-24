import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/dynamic/domain/entities/dynamic_entities.dart';

abstract class EmoteRepository {
  Future<Result<EmoteResponse, AppError>> getUserEmotes();
}
