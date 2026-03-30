import 'dart:io';

import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/dynamic/data/dynamic_repository.dart';
import 'package:culcul/features/dynamic/data/emote_repository.dart';
import 'package:culcul/features/dynamic/domain/entities/article_detail_data.dart';
import 'package:culcul/features/dynamic/domain/entities/dynamic_models.dart';
import 'package:culcul/features/profile/data/relation_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dynamic_use_cases.g.dart';

class DynamicFeedQuery {
  final String? type;
  final String? offset;
  final int? hostMid;
  final int? topicId;

  const DynamicFeedQuery({this.type, this.offset, this.hostMid, this.topicId});
}

class DynamicCommentsQuery {
  final DynamicItem post;
  final int sort;
  final int page;

  const DynamicCommentsQuery({
    required this.post,
    required this.sort,
    required this.page,
  });
}

class DynamicCommentLikeCommand {
  final DynamicItem post;
  final int rpid;
  final bool isLiked;

  const DynamicCommentLikeCommand({
    required this.post,
    required this.rpid,
    required this.isLiked,
  });
}

class DynamicReplyCommand {
  final DynamicItem post;
  final int root;
  final int parent;
  final String message;

  const DynamicReplyCommand({
    required this.post,
    required this.root,
    required this.parent,
    required this.message,
  });
}

class PublishDynamicCommand {
  final String content;
  final List<File> images;

  const PublishDynamicCommand({required this.content, required this.images});
}

@riverpod
EmotePackagesUseCase emotePackagesUseCase(Ref ref) {
  return EmotePackagesUseCase(ref.read(emoteRepositoryProvider));
}

class EmotePackagesUseCase {
  final EmoteRepository _repository;

  const EmotePackagesUseCase(this._repository);

  Future<Result<List<EmotePackage>, AppError>> call() async {
    try {
      final data = await _repository.getUserEmotes();
      return Success(data.packages);
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }
}

@riverpod
RecentlyFollowedUseCase recentlyFollowedUseCase(Ref ref) {
  return RecentlyFollowedUseCase(ref.read(relationRepositoryProvider));
}

class RecentlyFollowedUseCase {
  final RelationRepository _repository;

  const RecentlyFollowedUseCase(this._repository);

  Future<Result<List<RelationUser>, AppError>> call(int mid) async {
    try {
      final data = await _repository.getFollowings(mid, ps: 20);
      return Success(data.list);
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }
}

class ArticleCommentsQuery {
  final String oid;
  final String referer;
  final int? next;

  const ArticleCommentsQuery({required this.oid, required this.referer, this.next});
}

class AddArticleCommentCommand {
  final String oid;
  final int type;
  final int root;
  final int parent;
  final String message;
  final String referer;

  const AddArticleCommentCommand({
    required this.oid,
    required this.type,
    required this.root,
    required this.parent,
    required this.message,
    required this.referer,
  });
}

class ToggleArticleCommentLikeCommand {
  final String oid;
  final int type;
  final int rpid;
  final bool isLiked;
  final String referer;

  const ToggleArticleCommentLikeCommand({
    required this.oid,
    required this.type,
    required this.rpid,
    required this.isLiked,
    required this.referer,
  });
}

@riverpod
DynamicFeedUseCase dynamicFeedUseCase(Ref ref) {
  return DynamicFeedUseCase(ref.read(dynamicRepositoryProvider));
}

class DynamicFeedUseCase {
  final DynamicRepository _repository;

  const DynamicFeedUseCase(this._repository);

  Future<Result<DynamicData, AppError>> call(DynamicFeedQuery query) async {
    try {
      if (query.topicId != null) {
        return Success(
          await _repository.getTopicFeed(topicId: query.topicId!, offset: query.offset),
        );
      }
      if (query.hostMid != null) {
        return Success(
          await _repository.getSpaceDynamicFeed(
            hostMid: query.hostMid!,
            offset: query.offset,
          ),
        );
      }
      return Success(await _repository.getFeed(type: query.type, offset: query.offset));
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }
}

@riverpod
DynamicDetailUseCase dynamicDetailUseCase(Ref ref) {
  return DynamicDetailUseCase(ref.read(dynamicRepositoryProvider));
}

class DynamicDetailUseCase {
  final DynamicRepository _repository;

  const DynamicDetailUseCase(this._repository);

  Future<Result<DynamicItem, AppError>> call(String dynamicId) async {
    try {
      return Success(await _repository.getDetail(dynamicId));
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }
}

@riverpod
ArticleDetailUseCase articleDetailUseCase(Ref ref) {
  return ArticleDetailUseCase(ref.read(dynamicRepositoryProvider));
}

class ArticleDetailUseCase {
  final DynamicRepository _repository;

  const ArticleDetailUseCase(this._repository);

  Future<Result<ArticleDetailData, AppError>> call(String url) async {
    try {
      return Success(await _repository.getArticleDetail(url));
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }
}

@riverpod
ToggleDynamicLikeUseCase toggleDynamicLikeUseCase(Ref ref) {
  return ToggleDynamicLikeUseCase(ref.read(dynamicRepositoryProvider));
}

class ToggleDynamicLikeUseCase {
  final DynamicRepository _repository;

  const ToggleDynamicLikeUseCase(this._repository);

  Future<Result<void, AppError>> call({
    required String id,
    required bool newStatus,
  }) async {
    try {
      await _repository.likeDynamic(id, newStatus);
      return const Success(null);
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }
}

@riverpod
DynamicCommentsUseCase dynamicCommentsUseCase(Ref ref) {
  return DynamicCommentsUseCase(ref.read(dynamicRepositoryProvider));
}

class DynamicCommentsUseCase {
  final DynamicRepository _repository;

  const DynamicCommentsUseCase(this._repository);

  Future<Result<CommentResponse, AppError>> call(DynamicCommentsQuery query) async {
    try {
      return Success(
        await _repository.getComments(query.post, sort: query.sort, page: query.page),
      );
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }
}

@riverpod
DynamicCommentLikeUseCase dynamicCommentLikeUseCase(Ref ref) {
  return DynamicCommentLikeUseCase(ref.read(dynamicRepositoryProvider));
}

class DynamicCommentLikeUseCase {
  final DynamicRepository _repository;

  const DynamicCommentLikeUseCase(this._repository);

  Future<Result<void, AppError>> call(DynamicCommentLikeCommand command) async {
    try {
      await _repository.likeComment(
        post: command.post,
        rpid: command.rpid,
        isLiked: command.isLiked,
      );
      return const Success(null);
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }
}

@riverpod
DynamicReplyUseCase dynamicReplyUseCase(Ref ref) {
  return DynamicReplyUseCase(ref.read(dynamicRepositoryProvider));
}

class DynamicReplyUseCase {
  final DynamicRepository _repository;

  const DynamicReplyUseCase(this._repository);

  Future<Result<void, AppError>> call(DynamicReplyCommand command) async {
    try {
      await _repository.addReply(
        post: command.post,
        root: command.root,
        parent: command.parent,
        message: command.message,
      );
      return const Success(null);
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }
}

@riverpod
ArticleCommentsUseCase articleCommentsUseCase(Ref ref) {
  return ArticleCommentsUseCase(ref.read(dynamicRepositoryProvider));
}

class ArticleCommentsUseCase {
  final DynamicRepository _repository;

  const ArticleCommentsUseCase(this._repository);

  Future<Result<CommentResponse, AppError>> call(ArticleCommentsQuery query) async {
    try {
      return Success(
        await _repository.getArticleCommentList(
          oid: query.oid,
          next: query.next,
          referer: query.referer,
        ),
      );
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }
}

@riverpod
AddArticleCommentUseCase addArticleCommentUseCase(Ref ref) {
  return AddArticleCommentUseCase(ref.read(dynamicRepositoryProvider));
}

class AddArticleCommentUseCase {
  final DynamicRepository _repository;

  const AddArticleCommentUseCase(this._repository);

  Future<Result<void, AppError>> call(AddArticleCommentCommand command) async {
    try {
      await _repository.addCommentReply(
        oid: command.oid,
        type: command.type,
        root: command.root,
        parent: command.parent,
        message: command.message,
        referer: command.referer,
      );
      return const Success(null);
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }
}

@riverpod
ToggleArticleCommentLikeUseCase toggleArticleCommentLikeUseCase(Ref ref) {
  return ToggleArticleCommentLikeUseCase(ref.read(dynamicRepositoryProvider));
}

class ToggleArticleCommentLikeUseCase {
  final DynamicRepository _repository;

  const ToggleArticleCommentLikeUseCase(this._repository);

  Future<Result<void, AppError>> call(ToggleArticleCommentLikeCommand command) async {
    try {
      await _repository.likeCommentByTarget(
        oid: command.oid,
        type: command.type,
        rpid: command.rpid,
        isLiked: command.isLiked,
        referer: command.referer,
      );
      return const Success(null);
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }
}

@riverpod
PublishDynamicUseCase publishDynamicUseCase(Ref ref) {
  return PublishDynamicUseCase(ref.read(dynamicRepositoryProvider));
}

class PublishDynamicUseCase {
  final DynamicRepository _repository;

  const PublishDynamicUseCase(this._repository);

  Future<Result<void, AppError>> call(PublishDynamicCommand command) async {
    try {
      final uploadedImages = <DynamicUploadImageData>[];
      for (final image in command.images) {
        uploadedImages.add(await _repository.uploadImage(image));
      }
      await _repository.publishDynamic(content: command.content, images: uploadedImages);
      return const Success(null);
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }
}
