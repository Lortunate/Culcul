import 'package:culcul/features/dynamic/models/dynamic_models.dart';

abstract class EmoteRepository {
  Future<EmoteResponse> getUserEmotes({String business = 'dynamic'});
}
