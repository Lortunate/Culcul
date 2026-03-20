sealed class Result<S, E extends Exception> {
  const Result();

  bool get isSuccess => this is Success<S, E>;
  bool get isFailure => this is Failure<S, E>;

  W when<W>({
    required W Function(S data) success,
    required W Function(E error) failure,
  }) {
    return switch (this) {
      Success(value: final v) => success(v),
      Failure(exception: final e) => failure(e),
    };
  }
}

final class Success<S, E extends Exception> extends Result<S, E> {
  final S value;
  const Success(this.value);
}

final class Failure<S, E extends Exception> extends Result<S, E> {
  final E exception;
  const Failure(this.exception);
}

/// Extension to make working with Results easier
extension ResultExtensions<T, E extends Exception> on Result<T, E> {
  /// Casts a Result to its failure type for easier access
  Result<S, F> cast<S, F extends Exception>() {
    return switch (this) {
      Success(value: final value) => Success(value as S),
      Failure(exception: final exception) => Failure(exception as F),
    };
  }

  /// Gets the failure value, or null if it's a success
  dynamic get asFailure {
    if (this is Failure) {
      return (this as Failure).exception;
    }
    return null;
  }

  /// Gets the success value, or null if it's a failure
  T? get asSuccess {
    return switch (this) {
      Success(value: final value) => value,
      Failure() => null,
    };
  }

  /// Maps the success value to a new type
  Result<R, E> map<R>(R Function(T value) transform) {
    return switch (this) {
      Success(value: final value) => Success(transform(value)),
      Failure(exception: final exception) => Failure(exception),
    };
  }

  /// Maps the error to a new type
  Result<T, R> mapError<R extends Exception>(R Function(E error) transform) {
    return switch (this) {
      Success(value: final value) => Success(value),
      Failure(exception: final exception) => Failure(transform(exception)),
    };
  }
}
