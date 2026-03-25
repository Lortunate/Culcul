import 'package:culcul/core/result.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

/// Utility functions for handling Result types consistently across the app
class ResultUtils {
  /// Converts a Result to a nullable value, returning the success value or null
  static S? getSuccessValue<S, E extends Exception>(Result<S, E> result) {
    return switch (result) {
      Success(value: final value) => value,
      Failure() => null,
    };
  }

  /// Checks if a Result contains a success value
  static bool isSuccess<S, E extends Exception>(Result<S, E> result) {
    return switch (result) {
      Success() => true,
      Failure() => false,
    };
  }

  /// Checks if a Result contains a failure
  static bool isFailure<S, E extends Exception>(Result<S, E> result) {
    return switch (result) {
      Success() => false,
      Failure() => true,
    };
  }

  /// Gets the exception from a failure, or null if it's a success
  static E? getException<S, E extends Exception>(Result<S, E> result) {
    return switch (result) {
      Success() => null,
      Failure(exception: final exception) => exception,
    };
  }

  /// Maps a Result to another type, applying transformation to success values
  static Result<R, E> map<S, R, E extends Exception>(
    Result<S, E> result,
    R Function(S value) transform,
  ) {
    return switch (result) {
      Success(value: final value) => Success(transform(value)),
      Failure(exception: final exception) => Failure(exception),
    };
  }

  /// Maps a Result's error to another type, applying transformation to failure values
  static Result<S, R> mapError<S, E extends Exception, R extends Exception>(
    Result<S, E> result,
    R Function(E error) transform,
  ) {
    return switch (result) {
      Success(value: final value) => Success(value),
      Failure(exception: final exception) => Failure(transform(exception)),
    };
  }

  /// Chains operations, applying a function to the success value and returning its result
  static Future<Result<R, E>> flatMap<S, R, E extends Exception>(
    Result<S, E> result,
    Future<Result<R, E>> Function(S value) transform,
  ) async {
    return switch (result) {
      Success(value: final value) => await transform(value),
      Failure(exception: final exception) => Failure(exception),
    };
  }

  /// Provides a fallback value if the result is a failure
  static S getOrElse<S, E extends Exception>(
    Result<S, E> result,
    S Function(E error) fallback,
  ) {
    return switch (result) {
      Success(value: final value) => value,
      Failure(exception: final exception) => fallback(exception),
    };
  }

  /// Executes a side effect if the result is a success
  static void onSuccess<S, E extends Exception>(
    Result<S, E> result,
    void Function(S value) effect,
  ) {
    if (result case Success(value: final value)) {
      effect(value);
    }
  }

  /// Executes a side effect if the result is a failure
  static void onFailure<S, E extends Exception>(
    Result<S, E> result,
    void Function(E error) effect,
  ) {
    if (result case Failure(exception: final error)) {
      effect(error);
    }
  }

  /// Combines two results, returning both success values or the first failure
  static Result<(S1, S2), E> combine2<S1, S2, E extends Exception>(
    Result<S1, E> result1,
    Result<S2, E> result2,
  ) {
    if (result1 case Failure(exception: final e1)) {
      return Failure(e1);
    }
    if (result2 case Failure(exception: final e2)) {
      return Failure(e2);
    }

    // Handle the success case without compound pattern matching
    if (result1 is Success<S1, E> && result2 is Success<S2, E>) {
      return Success((result1.value, result2.value));
    }

    // This shouldn't happen due to the pattern matching above, but added for completeness
    throw StateError('Unexpected state in combine2');
  }
}

/// Extensions to bridge Result and Riverpod's AsyncValue
extension ResultAsyncValueExtensions<T, E extends Exception> on Result<T, E> {
  /// Converts a Result into an AsyncValue
  AsyncValue<T> toAsyncValue() {
    return switch (this) {
      Success(value: final value) => AsyncValue.data(value),
      Failure(exception: final exception) => AsyncValue.error(
        exception,
        StackTrace.current,
      ),
    };
  }
}

/// Extensions to bridge `Future<Result>` and Riverpod's `AsyncValue`
extension FutureResultAsyncValueExtensions<T, E extends Exception>
    on Future<Result<T, E>> {
  /// Awaits the result and converts it into an AsyncValue
  Future<AsyncValue<T>> toAsyncValue() async {
    final result = await this;
    return result.toAsyncValue();
  }
}

