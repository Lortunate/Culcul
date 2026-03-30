class PageQuery {
  final int page;
  final int size;

  const PageQuery({this.page = 1, this.size = 20});

  PageQuery next() => PageQuery(page: page + 1, size: size);
  PageQuery reset() => PageQuery(page: 1, size: size);
}
