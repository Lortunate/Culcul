import 'package:culcul/data/models/video/video_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'weekly_model.freezed.dart';
part 'weekly_model.g.dart';

@freezed
sealed class WeeklyModel with _$WeeklyModel {
  const factory WeeklyModel({
    required List<VideoModel> list,
  }) = _WeeklyModel;

  factory WeeklyModel.fromJson(Map<String, dynamic> json) =>
      _$WeeklyModelFromJson(json);
}
