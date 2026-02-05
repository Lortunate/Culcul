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
