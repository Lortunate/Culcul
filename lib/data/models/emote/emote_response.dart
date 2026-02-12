import 'package:json_annotation/json_annotation.dart';

part 'emote_response.g.dart';

@JsonSerializable()
class EmoteResponse {
  final List<EmotePackage> packages;

  EmoteResponse({required this.packages});

  factory EmoteResponse.fromJson(Map<String, dynamic> json) =>
      _$EmoteResponseFromJson(json);
  Map<String, dynamic> toJson() => _$EmoteResponseToJson(this);
}

@JsonSerializable()
class EmotePackage {
  final int id;
  final String text;
  final String url;
  final List<Emote> emote;

  EmotePackage({
    required this.id,
    required this.text,
    required this.url,
    required this.emote,
  });

  factory EmotePackage.fromJson(Map<String, dynamic> json) =>
      _$EmotePackageFromJson(json);
  Map<String, dynamic> toJson() => _$EmotePackageToJson(this);
}

@JsonSerializable()
class Emote {
  final int id;
  final String text;
  final String url;

  Emote({required this.id, required this.text, required this.url});

  factory Emote.fromJson(Map<String, dynamic> json) => _$EmoteFromJson(json);
  Map<String, dynamic> toJson() => _$EmoteToJson(this);
}
