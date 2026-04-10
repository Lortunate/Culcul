sealed class Result<T, E> {
  const Result();

  bool get isSuccess => this is Success<T, E>;
  bool get isFailure => this is Failure<T, E>;

  T? get dataOrNull {
    final self = this;
    return switch (self) {
      Success<T, E>(:final value) => value,
      Failure<T, E>() => null,
    };
  }

  E? get errorOrNull {
    final self = this;
    return switch (self) {
      Success<T, E>() => null,
      Failure<T, E>(:final error) => error,
    };
  }

  R when<R>({
    required R Function(T value) success,
    required R Function(E error) failure,
  }) {
    final self = this;
    return switch (self) {
      Success<T, E>(:final value) => success(value),
      Failure<T, E>(:final error) => failure(error),
    };
  }

  Result<U, E> map<U>(U Function(T value) mapper) {
    final self = this;
    return switch (self) {
      Success<T, E>(:final value) => Success<U, E>(mapper(value)),
      Failure<T, E>(:final error) => Failure<U, E>(error),
    };
  }
}

final class Success<T, E> extends Result<T, E> {
  final T value;

  const Success(this.value);
}

final class Failure<T, E> extends Result<T, E> {
  final E error;

  const Failure(this.error);
}
