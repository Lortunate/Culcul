part of 'profile_repository_impl.dart';

mixin _ProfileRepositoryImplFlowsMixin on RequestExecutorBinding {
  ProfileApi get api;
  Future<Result<ProfileUser, AppError>> getProfileModel(int userId);

  Future<Result<List<UserSpaceVideoModel>, AppError>> getSpaceVideosModel({
    required int mid,
    int page = 1,
    String order = 'pubdate',
    bool forceRefresh = false,
    CancelToken? cancelToken,
  }) async {
    final result = await requestApiResult(
      () => api.getSpaceVideos(
        mid: mid,
        page: page,
        pageSize: ProfileRepositoryImpl._defaultSpaceVideoPageSize,
        order: order,
        forceRefresh: forceRefresh ? true : null,
        cancelToken: cancelToken,
      ),
    );
    return result.map((data) => data.list.vlist);
  }

  Future<Result<UserSpaceVideoModel?, AppError>> getStickyVideoModel(int vmid) async {
    final result = await requestApiResult(() => api.getStickyVideo(vmid));
    return result.when(
      success: (data) => Success(data),
      failure: (error) {
        if (error is ServerAppError && error.code == 53016) {
          return const Success(null);
        }
        return Failure(error);
      },
    );
  }

  Future<Result<List<UserSpaceVideoModel>, AppError>> getMasterpieceModels(
    int vmid,
  ) async {
    final result = await requestApiResult(() => api.getMasterpiece(vmid));
    return result.when(
      success: (data) => Success(data),
      failure: (_) => const Success(<UserSpaceVideoModel>[]),
    );
  }

  Future<Result<void, AppError>> modifyRelation({
    required int mid,
    required bool isFollow,
  }) {
    return requestVoidResult(() => api.modifyRelation(mid, isFollow ? 1 : 2, 11));
  }

  Future<Result<ProfileUser, AppError>> getProfile(int userId) async {
    return getProfileModel(userId);
  }

  Future<Result<List<ProfileVideo>, AppError>> getSpaceVideos({
    required int mid,
    int page = 1,
    String order = 'pubdate',
    bool forceRefresh = false,
    CancelToken? cancelToken,
  }) async {
    final result = await getSpaceVideosModel(
      mid: mid,
      page: page,
      order: order,
      forceRefresh: forceRefresh,
      cancelToken: cancelToken,
    );
    return result.map((data) => data.map((item) => item.toDomain()).toList());
  }

  Future<Result<ProfileVideo?, AppError>> getStickyVideo(int vmid) async {
    final result = await getStickyVideoModel(vmid);
    return result.map((data) => data?.toDomain());
  }

  Future<Result<List<ProfileVideo>, AppError>> getMasterpiece(int vmid) async {
    final result = await getMasterpieceModels(vmid);
    return result.map((data) => data.map((item) => item.toDomain()).toList());
  }
}
