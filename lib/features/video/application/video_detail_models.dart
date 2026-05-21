import 'package:culcul/core/contracts/video_model_contract.dart';
import 'package:culcul/features/video/data/dtos/related_video_dto.dart' as related_dto;
import 'package:culcul/features/video/data/dtos/subtitle_dto.dart';
import 'package:culcul/features/video/data/dtos/video_detail_dto.dart' as detail_dto;

class VideoDetailViewData {
  final String bvid;
  final int aid;
  final String title;
  final String pic;
  final int pubDate;
  final String desc;
  final VideoOwner owner;
  final VideoStat stat;
  final VideoDimensionViewData dimension;
  final VideoSubtitleDto? subtitle;
  final List<VideoPartViewData> pages;
  final List<VideoTagViewData> tags;
  final VideoRequestUserState reqUser;

  const VideoDetailViewData({
    required this.bvid,
    required this.aid,
    required this.title,
    required this.pic,
    required this.pubDate,
    required this.desc,
    required this.owner,
    required this.stat,
    this.dimension = const VideoDimensionViewData(),
    this.subtitle,
    this.pages = const [],
    this.tags = const [],
    this.reqUser = const VideoRequestUserState(),
  });

  VideoDetailViewData copyWith({
    String? bvid,
    int? aid,
    String? title,
    String? pic,
    int? pubDate,
    String? desc,
    VideoOwner? owner,
    VideoStat? stat,
    VideoDimensionViewData? dimension,
    VideoSubtitleDto? subtitle,
    List<VideoPartViewData>? pages,
    List<VideoTagViewData>? tags,
    VideoRequestUserState? reqUser,
  }) {
    return VideoDetailViewData(
      bvid: bvid ?? this.bvid,
      aid: aid ?? this.aid,
      title: title ?? this.title,
      pic: pic ?? this.pic,
      pubDate: pubDate ?? this.pubDate,
      desc: desc ?? this.desc,
      owner: owner ?? this.owner,
      stat: stat ?? this.stat,
      dimension: dimension ?? this.dimension,
      subtitle: subtitle ?? this.subtitle,
      pages: pages ?? this.pages,
      tags: tags ?? this.tags,
      reqUser: reqUser ?? this.reqUser,
    );
  }
}

class VideoRequestUserState {
  final int attention;
  final int guestAttention;
  final int like;
  final int coin;
  final int favorite;

  const VideoRequestUserState({
    this.attention = 0,
    this.guestAttention = 0,
    this.like = 0,
    this.coin = 0,
    this.favorite = 0,
  });

  VideoRequestUserState copyWith({
    int? attention,
    int? guestAttention,
    int? like,
    int? coin,
    int? favorite,
  }) {
    return VideoRequestUserState(
      attention: attention ?? this.attention,
      guestAttention: guestAttention ?? this.guestAttention,
      like: like ?? this.like,
      coin: coin ?? this.coin,
      favorite: favorite ?? this.favorite,
    );
  }
}

class VideoPartViewData {
  final int cid;
  final int page;
  final String part;
  final int duration;
  final VideoDimensionViewData dimension;

  const VideoPartViewData({
    required this.cid,
    this.page = 0,
    this.part = '',
    this.duration = 0,
    this.dimension = const VideoDimensionViewData(),
  });
}

class VideoDimensionViewData {
  final int width;
  final int height;
  final int rotate;

  const VideoDimensionViewData({this.width = 0, this.height = 0, this.rotate = 0});
}

class VideoTagViewData {
  final String tagName;

  const VideoTagViewData({this.tagName = ''});
}

extension VideoDetailViewDataMapper on detail_dto.VideoDetail {
  VideoDetailViewData toVideoDetailViewData({List<detail_dto.VideoTag>? tags}) {
    return VideoDetailViewData(
      bvid: bvid,
      aid: aid,
      title: title,
      pic: pic,
      pubDate: pubDate,
      desc: desc,
      owner: owner,
      stat: stat,
      dimension: dimension.toVideoDimensionViewData(),
      subtitle: subtitle,
      pages: pages.map((page) => page.toVideoPartViewData()).toList(growable: false),
      tags: (tags ?? tag).map((tag) => tag.toVideoTagViewData()).toList(growable: false),
      reqUser: reqUser.toVideoRequestUserState(),
    );
  }
}

extension RelatedVideoViewDataMapper on related_dto.RelatedVideo {
  VideoModel toVideoModel() {
    return VideoModel(
      bvid: bvid,
      title: title,
      pic: pic,
      owner: owner,
      stat: stat,
      duration: duration,
      pubDate: pubDate,
      desc: desc,
      rcmdReason: rcmdReason,
    );
  }
}

extension VideoPartViewDataMapper on detail_dto.VideoPage {
  VideoPartViewData toVideoPartViewData() {
    return VideoPartViewData(
      cid: cid,
      page: page,
      part: part,
      duration: duration,
      dimension: dimension.toVideoDimensionViewData(),
    );
  }
}

extension VideoDimensionViewDataMapper on detail_dto.VideoDimension {
  VideoDimensionViewData toVideoDimensionViewData() {
    return VideoDimensionViewData(width: width, height: height, rotate: rotate);
  }
}

extension VideoTagViewDataMapper on detail_dto.VideoTag {
  VideoTagViewData toVideoTagViewData() {
    return VideoTagViewData(tagName: tagName);
  }
}

extension VideoRequestUserStateMapper on detail_dto.ReqUser? {
  VideoRequestUserState toVideoRequestUserState() {
    final user = this;
    if (user == null) {
      return const VideoRequestUserState();
    }
    return VideoRequestUserState(
      attention: user.attention,
      guestAttention: user.guestAttention,
      like: user.like,
      coin: user.coin,
      favorite: user.favorite,
    );
  }
}
