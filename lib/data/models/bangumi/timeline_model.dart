import 'package:freezed_annotation/freezed_annotation.dart';

part 'timeline_model.freezed.dart';
part 'timeline_model.g.dart';

@freezed
abstract class TimelineResponse with _$TimelineResponse {
  const factory TimelineResponse({
    required String date,
    @JsonKey(name: 'date_ts') required int dateTs,
    @JsonKey(name: 'day_of_week') required int dayOfWeek,
    @JsonKey(name: 'is_today') required int isToday,
    required List<TimelineEpisode> episodes,
  }) = _TimelineResponse;

  factory TimelineResponse.fromJson(Map<String, dynamic> json) =>
      _$TimelineResponseFromJson(json);
}

@freezed
abstract class TimelineEpisode with _$TimelineEpisode {
  const factory TimelineEpisode({
    required String cover,
    @JsonKey(name: 'episode_id') required int episodeId,
    @JsonKey(name: 'pub_index') required String pubIndex,
    @JsonKey(name: 'pub_time') required String pubTime,
    @JsonKey(name: 'pub_ts') required int pubTs,
    required int published,
    @JsonKey(name: 'season_id') required int seasonId,
    @JsonKey(name: 'square_cover') required String squareCover,
    required String title,
    @Default(0) int delay,
    @JsonKey(name: 'delay_reason') String? delayReason,
  }) = _TimelineEpisode;

  factory TimelineEpisode.fromJson(Map<String, dynamic> json) =>
      _$TimelineEpisodeFromJson(json);
}
