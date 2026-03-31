import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';

Future<Result<T, AppError>> runResult<T>(Future<T> Function() action) async {
  try {
    return Success(await action());
  } catch (error) {
    return Failure(AppError.fromObject(error));
  }
}

Future<Result<void, AppError>> runVoidResult(Future<void> Function() action) async {
  try {
    await action();
    return const Success(null);
  } catch (error) {
    return Failure(AppError.fromObject(error));
  }
}
