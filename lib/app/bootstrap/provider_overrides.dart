import 'package:culcul/app/runtime/app_runtime.dart';
import 'package:culcul/app/runtime/root_overrides.dart';
import 'package:riverpod/misc.dart' show Override;

@Deprecated('Use createRootOverrides from app/runtime/root_overrides.dart instead.')
List<Override> createProviderOverrides(AppRuntime runtime) {
  return createRootOverrides(runtime);
}
