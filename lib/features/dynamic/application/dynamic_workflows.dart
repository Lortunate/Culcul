import 'dart:io';

import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/core/result/run_result.dart';
import 'package:culcul/features/dynamic/dynamic_providers.dart';
import 'package:culcul/features/dynamic/domain/entities/article_detail_data.dart';
import 'package:culcul/features/dynamic/domain/repositories/dynamic_repository.dart';
import 'package:culcul/features/dynamic/domain/repositories/emote_repository.dart';
import 'package:culcul/features/dynamic/domain/entities/dynamic_entities.dart';
import 'package:culcul/features/profile/profile_providers.dart';
import 'package:culcul/features/profile/domain/entities/relation_user.dart';
import 'package:culcul/features/profile/domain/repositories/relation_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dynamic_workflows.g.dart';

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
EmotePackagesWorkflow emotePackagesWorkflow(Ref ref) {
  return EmotePackagesWorkflow(ref.read(emoteRepositoryProvider));
}

class EmotePackagesWorkflow {
  final EmoteRepository _repository;

  const EmotePackagesWorkflow(this._repository);

  Future<Result<List<EmotePackage>, AppError>> call() async {
    return runResult(() async => (await _repository.getUserEmotes()).packages);
  }
}

@riverpod
RecentlyFollowedWorkflow recentlyFollowedWorkflow(Ref ref) {
  return RecentlyFollowedWorkflow(ref.read(relationRepositoryProvider));
}

class RecentlyFollowedWorkflow {
  final RelationRepository _repository;

  const RecentlyFollowedWorkflow(this._repository);

  Future<Result<List<ProfileRelationUser>, AppError>> call(int mid) async {
    return runResult(() => _repository.getFollowings(mid, page: 1, pageSize: 20));
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
DynamicFeedWorkflow dynamicFeedWorkflow(Ref ref) {
  return DynamicFeedWorkflow(ref.read(dynamicRepositoryProvider));
}

class DynamicFeedWorkflow {
  final DynamicRepository _repository;

  const DynamicFeedWorkflow(this._repository);

  Future<Result<DynamicData, AppError>> call(DynamicFeedQuery query) async {
    return runResult(() async {
      if (query.topicId != null) {
        return _repository.getTopicFeed(topicId: query.topicId!, offset: query.offset);
      }
      if (query.hostMid != null) {
        return _repository.getSpaceDynamicFeed(
          hostMid: query.hostMid!,
          offset: query.offset,
        );
      }
      return _repository.getFeed(type: query.type, offset: query.offset);
    });
  }
}

@riverpod
DynamicDetailWorkflow dynamicDetailWorkflow(Ref ref) {
  return DynamicDetailWorkflow(ref.read(dynamicRepositoryProvider));
}

class DynamicDetailWorkflow {
  final DynamicRepository _repository;

  const DynamicDetailWorkflow(this._repository);

  Future<Result<DynamicItem, AppError>> call(String dynamicId) async {
    return runResult(() => _repository.getDetail(dynamicId));
  }
}

@riverpod
ArticleDetailWorkflow articleDetailWorkflow(Ref ref) {
  return ArticleDetailWorkflow(ref.read(dynamicRepositoryProvider));
}

class ArticleDetailWorkflow {
  final DynamicRepository _repository;

  const ArticleDetailWorkflow(this._repository);

  Future<Result<ArticleDetailData, AppError>> call(String url) async {
    return runResult(() => _repository.getArticleDetail(url));
  }
}

@riverpod
ToggleDynamicLikeWorkflow toggleDynamicLikeWorkflow(Ref ref) {
  return ToggleDynamicLikeWorkflow(ref.read(dynamicRepositoryProvider));
}

class ToggleDynamicLikeWorkflow {
  final DynamicRepository _repository;

  const ToggleDynamicLikeWorkflow(this._repository);

  Future<Result<void, AppError>> call({
    required String id,
    required bool newStatus,
  }) async {
    return runVoidResult(() => _repository.likeDynamic(id, newStatus));
  }
}

@riverpod
DynamicCommentsWorkflow dynamicCommentsWorkflow(Ref ref) {
  return DynamicCommentsWorkflow(ref.read(dynamicRepositoryProvider));
}

class DynamicCommentsWorkflow {
  final DynamicRepository _repository;

  const DynamicCommentsWorkflow(this._repository);

  Future<Result<CommentResponse, AppError>> call(DynamicCommentsQuery query) async {
    return runResult(
      () => _repository.getComments(query.post, sort: query.sort, page: query.page),
    );
  }
}

@riverpod
DynamicCommentLikeWorkflow dynamicCommentLikeWorkflow(Ref ref) {
  return DynamicCommentLikeWorkflow(ref.read(dynamicRepositoryProvider));
}

class DynamicCommentLikeWorkflow {
  final DynamicRepository _repository;

  const DynamicCommentLikeWorkflow(this._repository);

  Future<Result<void, AppError>> call(DynamicCommentLikeCommand command) async {
    return runVoidResult(
      () => _repository.likeComment(
        post: command.post,
        rpid: command.rpid,
        isLiked: command.isLiked,
      ),
    );
  }
}

@riverpod
DynamicReplyWorkflow dynamicReplyWorkflow(Ref ref) {
  return DynamicReplyWorkflow(ref.read(dynamicRepositoryProvider));
}

class DynamicReplyWorkflow {
  final DynamicRepository _repository;

  const DynamicReplyWorkflow(this._repository);

  Future<Result<void, AppError>> call(DynamicReplyCommand command) async {
    return runVoidResult(
      () => _repository.addReply(
        post: command.post,
        root: command.root,
        parent: command.parent,
        message: command.message,
      ),
    );
  }
}

@riverpod
ArticleCommentsWorkflow articleCommentsWorkflow(Ref ref) {
  return ArticleCommentsWorkflow(ref.read(dynamicRepositoryProvider));
}

class ArticleCommentsWorkflow {
  final DynamicRepository _repository;

  const ArticleCommentsWorkflow(this._repository);

  Future<Result<CommentResponse, AppError>> call(ArticleCommentsQuery query) async {
    return runResult(
      () => _repository.getArticleCommentList(
        oid: query.oid,
        next: query.next,
        referer: query.referer,
      ),
    );
  }
}

@riverpod
AddArticleCommentWorkflow addArticleCommentWorkflow(Ref ref) {
  return AddArticleCommentWorkflow(ref.read(dynamicRepositoryProvider));
}

class AddArticleCommentWorkflow {
  final DynamicRepository _repository;

  const AddArticleCommentWorkflow(this._repository);

  Future<Result<void, AppError>> call(AddArticleCommentCommand command) async {
    return runVoidResult(
      () => _repository.addCommentReply(
        oid: command.oid,
        type: command.type,
        root: command.root,
        parent: command.parent,
        message: command.message,
        referer: command.referer,
      ),
    );
  }
}

@riverpod
ToggleArticleCommentLikeWorkflow toggleArticleCommentLikeWorkflow(Ref ref) {
  return ToggleArticleCommentLikeWorkflow(ref.read(dynamicRepositoryProvider));
}

class ToggleArticleCommentLikeWorkflow {
  final DynamicRepository _repository;

  const ToggleArticleCommentLikeWorkflow(this._repository);

  Future<Result<void, AppError>> call(ToggleArticleCommentLikeCommand command) async {
    return runVoidResult(
      () => _repository.likeCommentByTarget(
        oid: command.oid,
        type: command.type,
        rpid: command.rpid,
        isLiked: command.isLiked,
        referer: command.referer,
      ),
    );
  }
}

@riverpod
PublishDynamicWorkflow publishDynamicWorkflow(Ref ref) {
  return PublishDynamicWorkflow(ref.read(dynamicRepositoryProvider));
}

class PublishDynamicWorkflow {
  final DynamicRepository _repository;

  const PublishDynamicWorkflow(this._repository);

  Future<Result<void, AppError>> call(PublishDynamicCommand command) async {
    return runVoidResult(() async {
      final uploadedImages = <DynamicUploadImageData>[];
      for (final image in command.images) {
        uploadedImages.add(await _repository.uploadImage(image));
      }
      await _repository.publishDynamic(content: command.content, images: uploadedImages);
    });
  }
}
