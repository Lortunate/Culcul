import 'package:culcul/features/dynamic/application/article_detail_port.dart';
import 'package:culcul/features/dynamic/data/dynamic_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'article_detail_application_providers.g.dart';

@riverpod
ArticleDetailPort articleDetailPort(Ref ref) {
  return ref.watch(dynamicRepositoryProvider);
}
