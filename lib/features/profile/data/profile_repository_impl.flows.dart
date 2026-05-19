part of 'profile_repository_impl.dart';

mixin _ProfileRepositoryImplFlowsMixin {
  ProfileApi get api;
  RequestExecutor get _requestExecutor;
  Future<Result<ProfileUser, AppError>> getProfileModel(int userId);

  Future<Result<List<UserSpaceVideoModel>, AppError>> getSpaceVideosModel({
    required int mid,
    int page = 1,
    String order = 'pubdate',
    bool forceRefresh = false,
    CancelToken? cancelToken,
  }) async {
    final result = await _requestExecutor.runApiDirect(
      () => api.getSpaceVideos(
        mid: mid,
        page: page,
        order: order,
        forceRefresh: forceRefresh ? true : null,
        cancelToken: cancelToken,
      ),
    );
    return result.map((data) => data.list.vlist);
  }

  Future<Result<UserSpaceVideoModel?, AppError>> getStickyVideoModel(int vmid) async {
    final result = await _requestExecutor.runApiDirect(() => api.getStickyVideo(vmid));
    return result.when(
      success: Success.new,
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
    final result = await _requestExecutor.runApiDirect(() => api.getMasterpiece(vmid));
    return result.when(
      success: Success.new,
      failure: (_) => const Success(<UserSpaceVideoModel>[]),
    );
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
