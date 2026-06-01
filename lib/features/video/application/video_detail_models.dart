import 'package:culcul/core/contracts/video_model_contract.dart';
import 'package:culcul/features/video/application/models/subtitle.dart';
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
  final detail_dto.VideoDimension dimension;
  final VideoSubtitles? subtitle;
  final List<VideoPartViewData> pages;
  final List<String> tags;
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
    this.dimension = const detail_dto.VideoDimension(),
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
    detail_dto.VideoDimension? dimension,
    VideoSubtitles? subtitle,
    List<VideoPartViewData>? pages,
    List<String>? tags,
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
  final detail_dto.VideoDimension dimension;

  const VideoPartViewData({
    required this.cid,
    this.page = 0,
    this.part = '',
    this.duration = 0,
    this.dimension = const detail_dto.VideoDimension(),
  });
}
