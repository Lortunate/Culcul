import 'package:culcul/core/constants/api_constants.dart';
import 'package:culcul/core/errors/exceptions.dart';
import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/core/types/result.dart';
import 'package:culcul/data/api/video_api.dart';
import 'package:culcul/data/models/index.dart';
import 'package:culcul/data/models/subtitle.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'video_repository.g.dart';

@riverpod
VideoRepository videoRepository(Ref ref) {
  return VideoRepository(
    api: ref.watch(videoApiProvider),
  );
}

class VideoRepository {
  final VideoApi api;

  VideoRepository({
    required this.api,
  });

  Future<Result<void, AppException>> actionComment({
    required int oid,
    required int rpid,
    required int action, // 1: like, 0: cancel
    int type = 1,
  }) async {
    try {
      final response = await api.actionComment(
        oid,
        rpid,
        action,
        type,
      );
      if (response.code == 0) {
        return const Success(null);
      } else {
        return Failure(ServerException(response.message, code: response.code));
      }
    } on DioException catch (e) {
      return Failure(dioExceptionToAppException(e));
    } catch (e) {
      if (e is AppException) return Failure(e);
      return Failure(UnknownException(e.toString(), cause: e));
    }
  }

  Future<Result<void, AppException>> hateComment({
    required int oid,
    required int rpid,
    required int action, // 1: dislike, 0: cancel
    int type = 1,
  }) async {
    try {
      final response = await api.hateComment(
        oid,
        rpid,
        action,
        type,
      );
      if (response.code == 0) {
        return const Success(null);
      } else {
        return Failure(ServerException(response.message, code: response.code));
      }
    } on DioException catch (e) {
      return Failure(dioExceptionToAppException(e));
    } catch (e) {
      if (e is AppException) return Failure(e);
      return Failure(UnknownException(e.toString(), cause: e));
    }
  }

  Future<Result<CommentItem, AppException>> addReply({
    required int oid,
    required int root,
    required int parent,
    required String message,
    int type = 1,
  }) async {
    try {
      final response = await api.addReply(
        oid,
        root,
        parent,
        message,
        type,
      );
      if (response.code == 0 && response.data != null) {
        return Success(response.data!);
      } else {
        return Failure(ServerException(response.message, code: response.code));
      }
    } on DioException catch (e) {
      return Failure(dioExceptionToAppException(e));
    } catch (e) {
      if (e is AppException) return Failure(e);
      return Failure(UnknownException(e.toString(), cause: e));
    }
  }

  Future<Result<VideoDetail, AppException>> fetchVideoView(String bvid) async {
    try {
      final response = await api.fetchVideoView(bvid);
      if (response.isSuccess && response.data != null) {
        return Success(response.data!);
      } else {
        return Failure(ServerException(response.message, code: response.code));
      }
    } on DioException catch (e) {
      return Failure(dioExceptionToAppException(e));
    } catch (e) {
      return Failure(UnknownException(e.toString(), cause: e));
    }
  }

  Future<Result<List<VideoTag>, AppException>> fetchVideoTags(
    String bvid,
  ) async {
    try {
      final response = await api.fetchVideoTags(bvid);
      if (response.isSuccess && response.data != null) {
        return Success(response.data!);
      } else {
        return Failure(ServerException(response.message, code: response.code));
      }
    } on DioException catch (e) {
      return Failure(dioExceptionToAppException(e));
    } catch (e) {
      return Failure(UnknownException(e.toString(), cause: e));
    }
  }

  Future<Result<PlayUrl, AppException>> fetchVideoPlayUrl({
    required int aid,
    required int cid,
    int qn = 80,
    int fnval = 1,
    int fnver = 0,
    int fourk = 1,
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

      final response = await api.fetchVideoPlayUrl(params);

      if (response.isSuccess && response.data != null) {
        return Success(response.data!);
      } else {
        return Failure(ServerException(response.message, code: response.code));
      }
    } on DioException catch (e) {
      return Failure(dioExceptionToAppException(e));
    } catch (e) {
      return Failure(UnknownException(e.toString(), cause: e));
    }
  }

  Future<Result<List<RelatedVideo>, AppException>> fetchRelatedVideos(
    String bvid,
  ) async {
    try {
      final response = await api.fetchRelatedVideos(bvid);
      if (response.isSuccess && response.data != null) {
        return Success(response.data!);
      } else {
        return Failure(ServerException(response.message, code: response.code));
      }
    } on DioException catch (e) {
      return Failure(dioExceptionToAppException(e));
    } catch (e) {
      return Failure(UnknownException(e.toString(), cause: e));
    }
  }

  Future<Result<CommentResponse, AppException>> fetchComments({
    required int oid,
    int type = 1,
    int sort = 1,
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
        return Success(response.data!);
      } else {
        return Failure(ServerException(response.message, code: response.code));
      }
    } on DioException catch (e) {
      return Failure(dioExceptionToAppException(e));
    } catch (e) {
      return Failure(UnknownException(e.toString(), cause: e));
    }
  }

  Future<Result<CommentResponse, AppException>> fetchReply({
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
        return Success(response.data!);
      } else {
        return Failure(ServerException(response.message, code: response.code));
      }
    } on DioException catch (e) {
      return Failure(dioExceptionToAppException(e));
    } catch (e) {
      return Failure(UnknownException(e.toString(), cause: e));
    }
  }

  Future<Result<SubtitleContent, AppException>> fetchSubtitleContent(String url) async {
    try {
      // Create a Dio instance for downloading JSON directly
      final dio = Dio();
      // Ensure the URL starts with https:
      final fullUrl = url.startsWith('http') ? url : 'https:$url';
      
      final response = await dio.get(fullUrl);
      
      if (response.statusCode == 200) {
        return Success(SubtitleContent.fromJson(response.data));
      } else {
        return Failure(ServerException('Failed to load subtitle', code: response.statusCode ?? -1));
      }
    } on DioException catch (e) {
      return Failure(dioExceptionToAppException(e));
    } catch (e) {
      return Failure(UnknownException(e.toString(), cause: e));
    }
  }

  Future<Result<void, AppException>> reportVideoProgress({
    required int aid,
    required int cid,
    required int progress,
    String platform = 'android',
    int type = 3,
  }) async {
    try {
      final response = await api.reportVideoProgress(
        aid,
        cid,
        progress,
        platform,
        type,
      );
      if (response.code == 0) {
        return const Success(null);
      } else {
        return Failure(ServerException(response.message, code: response.code));
      }
    } on DioException catch (e) {
      return Failure(dioExceptionToAppException(e));
    } catch (e) {
      if (e is AppException) return Failure(e);
      return Failure(UnknownException(e.toString(), cause: e));
    }
  }
}
