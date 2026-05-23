import 'package:culcul/features/home/application/home_port.dart';
import 'package:culcul/features/home/data/home_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_application_providers.g.dart';

@riverpod
HomePort homePort(Ref ref) {
  return ref.watch(homeRepositoryImplProvider);
}
