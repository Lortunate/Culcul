import 'package:culcul/features/dynamic/domain/entities/dynamic_entities.dart';

abstract class EmoteRepository {
  Future<EmoteResponse> getUserEmotes();
}
