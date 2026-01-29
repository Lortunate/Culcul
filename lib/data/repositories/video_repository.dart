import 'package:cilixili/data/sources/api/api_provider.dart';
import 'package:cilixili/data/sources/api/video_api.dart';
import 'package:cilixili/data/sources/api/helpers/wbi_helper.dart';
import 'package:cilixili/data/sources/api/helpers/wbi_provider.dart';
import 'package:cilixili/data/models/video/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'video_repository.g.dart';

@riverpod
VideoRepository videoRepository(Ref ref) {
  return VideoRepository(
    api: ref.watch(videoApiProvider),
    wbiHelper: ref.watch(wbiHelperProvider),
  );
}

class VideoRepository {
  final VideoApi api;
  final WbiHelper wbiHelper;

  VideoRepository({required this.api, required this.wbiHelper});

  /// Fetch video details including title, description, owner, etc.
  Future<VideoDetail> fetchVideoView(String bvid) async {
    try {
      final response = await api.fetchVideoView(bvid);
      if (response.isSuccess && response.data != null) {
        return response.data!;
      } else {
        print(
          'VideoRepository fetchVideoView error: ${response.message}, code: ${response.code}',
        );
        throw Exception(response.message);
      }
    } catch (e, s) {
      print('VideoRepository fetchVideoView exception: $e');
      print(s);
      rethrow;
    }
  }

  /// Fetch video play URL (streaming address) with WBI signing.
  Future<PlayUrl> fetchVideoPlayUrl({
    required int aid,
    required int cid,
    int qn = 80, // High Definition (1080P)
    int fnval = 1, // MP4 format
    int fnver = 0,
    int fourk = 0,
  }) async {
    try {
      final params = {
        'avid': aid,
        'cid': cid,
        'qn': qn,
        'fnval': fnval,
        'fnver': fnver,
        'fourk': fourk,
      };

      final signedParams = wbiHelper.sign(params);
      final response = await api.fetchVideoPlayUrl(signedParams);

      if (response.isSuccess && response.data != null) {
        return response.data!;
      } else {
        print(
          'VideoRepository fetchVideoPlayUrl error: ${response.message}, code: ${response.code}',
        );
        throw Exception(response.message);
      }
    } catch (e, s) {
      print('VideoRepository fetchVideoPlayUrl exception: $e');
      print(s);
      rethrow;
    }
  }

  /// Fetch related videos
  Future<List<RelatedVideo>> fetchRelatedVideos(String bvid) async {
    try {
      final response = await api.fetchRelatedVideos(bvid);
      if (response.isSuccess && response.data != null) {
        return response.data!;
      } else {
        print(
          'VideoRepository fetchRelatedVideos error: ${response.message}, code: ${response.code}',
        );
        throw Exception(response.message);
      }
    } catch (e, s) {
      print('VideoRepository fetchRelatedVideos exception: $e');
      print(s);
      rethrow;
    }
  }

  /// Fetch video comments
  Future<CommentResponse> fetchComments({
    required int oid,
    int type = 1, // 1 for video
    int sort = 1, // 0: time, 1: like, 2: reply
    int ps = 20,
    int pn = 1,
  }) async {
    try {
      final params = {
        'oid': oid,
        'type': type,
        'sort': sort,
        'ps': ps,
        'pn': pn,
      };
      final response = await api.fetchComments(params);
      if (response.isSuccess && response.data != null) {
        return response.data!;
      } else {
        print(
          'VideoRepository fetchComments error: ${response.message}, code: ${response.code}',
        );
        throw Exception(response.message);
      }
    } catch (e, s) {
      print('VideoRepository fetchComments exception: $e');
      print(s);
      rethrow;
    }
  }

  /// Fetch comment replies
  Future<CommentResponse> fetchReply({
    required int oid,
    required int root,
    int type = 1,
    int ps = 20,
    int pn = 1,
  }) async {
    try {
      final params = {
        'oid': oid,
        'root': root,
        'type': type,
        'ps': ps,
        'pn': pn,
      };
      final response = await api.fetchReply(params);
      if (response.isSuccess && response.data != null) {
        return response.data!;
      } else {
        print(
          'VideoRepository fetchReply error: ${response.message}, code: ${response.code}',
        );
        throw Exception(response.message);
      }
    } catch (e, s) {
      print('VideoRepository fetchReply exception: $e');
      print(s);
      rethrow;
    }
  }
}
