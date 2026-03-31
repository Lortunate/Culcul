import 'package:freezed_annotation/freezed_annotation.dart';

part 'emote_response.freezed.dart';

@freezed
sealed class EmoteResponse with _$EmoteResponse {
  const factory EmoteResponse({required List<EmotePackage> packages}) = _EmoteResponse;
}

@freezed
sealed class EmotePackage with _$EmotePackage {
  const factory EmotePackage({
    required int id,
    required String text,
    required String url,
    required List<Emote> emote,
  }) = _EmotePackage;
}

@freezed
sealed class Emote with _$Emote {
  const factory Emote({required int id, required String text, required String url}) =
      _Emote;
}
