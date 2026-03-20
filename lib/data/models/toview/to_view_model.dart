import 'package:culcul/data/models/fav/fav_resource_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'to_view_model.freezed.dart';
part 'to_view_model.g.dart';

@freezed
sealed class ToViewModel with _$ToViewModel {
  const ToViewModel._();

  const factory ToViewModel({
    @JsonKey(name: 'aid') int? aid,
    @JsonKey(name: 'videos') @Default(0) int? videos,
    @JsonKey(name: 'tid') @Default(0) int? tid,
    @JsonKey(name: 'tname') @Default('') String? tname,
    @JsonKey(name: 'copyright') @Default(1) int? copyright,
    @JsonKey(name: 'pic') @Default('') String? pic,
    @JsonKey(name: 'title') @Default('') String? title,
    @JsonKey(name: 'pubdate') @Default(0) int? pubdate,
    @JsonKey(name: 'ctime') @Default(0) int? ctime,
    @JsonKey(name: 'desc') @Default('') String? desc,
    @JsonKey(name: 'state') @Default(0) int? state,
    @JsonKey(name: 'duration') @Default(0) int? duration,
    @JsonKey(name: 'rights') Map<String, dynamic>? rights,
    @JsonKey(name: 'owner') FavUpperModel? owner,
    @JsonKey(name: 'stat') ToViewStatModel? stat,
    @JsonKey(name: 'dynamic') String? dynamicText,
    @JsonKey(name: 'cid') @Default(0) int? cid,
    @JsonKey(name: 'progress') @Default(0) int? progress,
    @JsonKey(name: 'add_at') @Default(0) int? addAt,
    @JsonKey(name: 'bvid') @Default('') String? bvid,
  }) = _ToViewModel;

  bool get hasProgress => (progress ?? 0) > 0;
  
  double get progressRatio {
    final d = (duration ?? 0) == 0 ? 1 : (duration ?? 1);
    return (progress ?? 0) / d;
  }

  factory ToViewModel.fromJson(Map<String, dynamic> json) =>
      _$ToViewModelFromJson(json);
}

@freezed
sealed class ToViewStatModel with _$ToViewStatModel {
  const factory ToViewStatModel({
    @JsonKey(name: 'aid') int? aid,
    @JsonKey(name: 'view') @Default(0) int? view,
    @JsonKey(name: 'danmaku') @Default(0) int? danmaku,
    @JsonKey(name: 'reply') @Default(0) int? reply,
    @JsonKey(name: 'favorite') @Default(0) int? favorite,
    @JsonKey(name: 'coin') @Default(0) int? coin,
    @JsonKey(name: 'share') @Default(0) int? share,
    @JsonKey(name: 'like') @Default(0) int? like,
    @JsonKey(name: 'dislike') @Default(0) int? dislike,
  }) = _ToViewStatModel;

  factory ToViewStatModel.fromJson(Map<String, dynamic> json) =>
      _$ToViewStatModelFromJson(json);
}

@freezed
sealed class ToViewListResponse with _$ToViewListResponse {
  const factory ToViewListResponse({
    @JsonKey(name: 'count') @Default(0) int count,
    @JsonKey(name: 'list')
    @Default([])
    List<ToViewModel> list,
  }) = _ToViewListResponse;

  factory ToViewListResponse.fromJson(Map<String, dynamic> json) =>
      _$ToViewListResponseFromJson(json);
}
