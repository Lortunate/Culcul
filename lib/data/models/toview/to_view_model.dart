import 'package:culcul/data/models/fav/fav_resource_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'to_view_model.g.dart';

@JsonSerializable()
class ToViewModel {
  @JsonKey(name: 'aid')
  final int? aid;
  @JsonKey(name: 'videos', defaultValue: 0)
  final int? videos;
  @JsonKey(name: 'tid', defaultValue: 0)
  final int? tid;
  @JsonKey(name: 'tname', defaultValue: '')
  final String? tname;
  @JsonKey(name: 'copyright', defaultValue: 1)
  final int? copyright;
  @JsonKey(name: 'pic', defaultValue: '')
  final String? pic;
  @JsonKey(name: 'title', defaultValue: '')
  final String? title;
  @JsonKey(name: 'pubdate', defaultValue: 0)
  final int? pubdate;
  @JsonKey(name: 'ctime', defaultValue: 0)
  final int? ctime;
  @JsonKey(name: 'desc', defaultValue: '')
  final String? desc;
  @JsonKey(name: 'state', defaultValue: 0)
  final int? state;
  @JsonKey(name: 'duration', defaultValue: 0)
  final int? duration;
  @JsonKey(name: 'rights')
  final Map<String, dynamic>? rights;
  @JsonKey(name: 'owner')
  final FavUpperModel? owner;
  @JsonKey(name: 'stat')
  final ToViewStatModel? stat;
  @JsonKey(name: 'dynamic')
  final String? dynamicText;
  @JsonKey(name: 'cid', defaultValue: 0)
  final int? cid;
  @JsonKey(name: 'progress', defaultValue: 0)
  final int? progress;
  @JsonKey(name: 'add_at', defaultValue: 0)
  final int? addAt;
  @JsonKey(name: 'bvid', defaultValue: '')
  final String? bvid;

  ToViewModel({
    this.aid,
    this.videos = 0,
    this.tid = 0,
    this.tname = '',
    this.copyright = 1,
    this.pic = '',
    this.title = '',
    this.pubdate = 0,
    this.ctime = 0,
    this.desc = '',
    this.state = 0,
    this.duration = 0,
    this.rights,
    this.owner,
    this.stat,
    this.dynamicText,
    this.cid = 0,
    this.progress = 0,
    this.addAt = 0,
    this.bvid = '',
  });

  factory ToViewModel.fromJson(Map<String, dynamic> json) =>
      _$ToViewModelFromJson(json);

  Map<String, dynamic> toJson() => _$ToViewModelToJson(this);
}

@JsonSerializable()
class ToViewStatModel {
  @JsonKey(name: 'aid')
  final int? aid;
  @JsonKey(name: 'view', defaultValue: 0)
  final int? view;
  @JsonKey(name: 'danmaku', defaultValue: 0)
  final int? danmaku;
  @JsonKey(name: 'reply', defaultValue: 0)
  final int? reply;
  @JsonKey(name: 'favorite', defaultValue: 0)
  final int? favorite;
  @JsonKey(name: 'coin', defaultValue: 0)
  final int? coin;
  @JsonKey(name: 'share', defaultValue: 0)
  final int? share;
  @JsonKey(name: 'like', defaultValue: 0)
  final int? like;
  @JsonKey(name: 'dislike', defaultValue: 0)
  final int? dislike;

  ToViewStatModel({
    this.aid,
    this.view = 0,
    this.danmaku = 0,
    this.reply = 0,
    this.favorite = 0,
    this.coin = 0,
    this.share = 0,
    this.like = 0,
    this.dislike = 0,
  });

  factory ToViewStatModel.fromJson(Map<String, dynamic> json) =>
      _$ToViewStatModelFromJson(json);

  Map<String, dynamic> toJson() => _$ToViewStatModelToJson(this);
}

@JsonSerializable()
class ToViewListResponse {
  @JsonKey(name: 'count', defaultValue: 0)
  final int count;
  @JsonKey(name: 'list', defaultValue: [])
  final List<ToViewModel> list;

  ToViewListResponse({this.count = 0, this.list = const []});

  factory ToViewListResponse.fromJson(Map<String, dynamic> json) =>
      _$ToViewListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ToViewListResponseToJson(this);
}
