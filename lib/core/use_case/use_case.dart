import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';

abstract interface class UseCase<Output, Input> {
  Future<Result<Output, AppError>> call(Input input);
}

class NoInput {
  const NoInput();
}
