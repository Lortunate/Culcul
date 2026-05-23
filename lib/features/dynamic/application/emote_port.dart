import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/dynamic/application/models/emote_catalog.dart';

/// Dynamic emote application boundary.
abstract interface class EmotePort {
  Future<Result<List<EmoteCatalogPackage>, AppError>> getUserEmotePackages();
}
