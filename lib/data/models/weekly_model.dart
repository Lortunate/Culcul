import 'package:culcul/data/models/video_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'weekly_model.g.dart';

@JsonSerializable()
class WeeklyModel {
  final List<VideoModel> list;

  WeeklyModel({required this.list});

  factory WeeklyModel.fromJson(Map<String, dynamic> json) =>
      _$WeeklyModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeeklyModelToJson(this);
}
