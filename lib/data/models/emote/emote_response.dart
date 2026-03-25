import 'package:freezed_annotation/freezed_annotation.dart';

part 'emote_response.freezed.dart';
part 'emote_response.g.dart';

@freezed
sealed class EmoteResponse with _$EmoteResponse {
  const factory EmoteResponse({required List<EmotePackage> packages}) = _EmoteResponse;

  factory EmoteResponse.fromJson(Map<String, dynamic> json) =>
      _$EmoteResponseFromJson(json);
}

@freezed
sealed class EmotePackage with _$EmotePackage {
  const factory EmotePackage({
    required int id,
    required String text,
    required String url,
    required List<Emote> emote,
  }) = _EmotePackage;

  factory EmotePackage.fromJson(Map<String, dynamic> json) =>
      _$EmotePackageFromJson(json);
}

@freezed
sealed class Emote with _$Emote {
  const factory Emote({required int id, required String text, required String url}) =
      _Emote;

  factory Emote.fromJson(Map<String, dynamic> json) => _$EmoteFromJson(json);
}

