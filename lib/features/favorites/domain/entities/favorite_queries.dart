class FavoriteFolderListQuery {
  final int upMid;
  final int page;

  const FavoriteFolderListQuery({required this.upMid, required this.page});
}

class FavoriteFolderResourcesQuery {
  final int mediaId;
  final int page;
  final String? keyword;
  final String? order;
  final int? type;
  final int? tid;

  const FavoriteFolderResourcesQuery({
    required this.mediaId,
    required this.page,
    this.keyword,
    this.order,
    this.type,
    this.tid,
  });
}
