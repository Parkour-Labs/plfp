import 'optional.dart';

/// A result type that can be either a success or a failure.
abstract class Result<S, F> {
  /// Whether this is a [Success] value.
  bool get isSuccess;

  /// Whether this is a [Failure] value.
  bool get isFailure;

  /// The success value if it is present, otherwise a [_None] value.
  Optional<S> get successOrNone;

  /// The failure value if it is present, otherwise a [_None] value.
  Optional<F> get failureOrNone;

  /// The success value if it is present, otherwise a [None] value.
  /// Alias to [successOrNone].
  Optional<S> get optional => successOrNone;

  const Result._();

  /// Creates a [Success] value.
  factory Result.ok(S value) => _Success(value);

  /// Creates a [Failure] value.
  factory Result.err(F value) => _Failure(value);

  /// Creates a [Result] value by executing the provided action.
  factory Result.from(S Function() action) {
    try {
      return Result.ok(action());
    } catch (e) {
      return Result.err(e as F);
    }
  }

  /// Unwraps the value if it is a [Success] value, otherwise throws a
  /// [ResultException] containing the failure value.
  S unwrap();

  /// Unwraps the value if it is a [Success] value, otherwise returns the
  /// provided value.
  S unwrapOrElse(S orElse);

  /// Maps the success value if it is present, otherwise returns a [Failure]
  /// value.
  Result<S2, F> mapSuccess<S2>(S2 Function(S) mapper);

  /// Maps the failure value if it is present, otherwise returns a [Success]
  /// value.
  Result<S, F2> mapFailure<F2>(F2 Function(F) mapper);

  /// Fold the values.
  R fold<R>(R Function(S) successMapper, R Function(F) failureMapper);
}

class _Success<S, F> extends Result<S, F> {
  final S _value;

  @override
  bool get isFailure => false;

  @override
  bool get isSuccess => true;

  @override
  Optional<S> get successOrNone => Optional.some(_value);

  @override
  Optional<F> get failureOrNone => Optional.none();

  const _Success(this._value) : super._();

  @override
  S unwrap() {
    return _value;
  }

  @override
  S unwrapOrElse(S orElse) {
    return _value;
  }

  @override
  R fold<R>(R Function(S p1) successMapper, R Function(F p1) failureMapper) {
    return successMapper(_value);
  }

  @override
  Result<S, F2> mapFailure<F2>(F2 Function(F p1) mapper) {
    return _Success(_value);
  }

  @override
  Result<S2, F> mapSuccess<S2>(S2 Function(S p1) mapper) {
    return _Success(mapper(_value));
  }
}

class _Failure<S, F> extends Result<S, F> {
  final F _value;

  @override
  bool get isFailure => true;

  @override
  bool get isSuccess => false;

  @override
  Optional<S> get successOrNone => Optional.none();

  @override
  Optional<F> get failureOrNone => Optional.some(_value);

  const _Failure(this._value) : super._();

  @override
  S unwrap() {
    throw ResultException(_value);
  }

  @override
  S unwrapOrElse(S orElse) {
    return orElse;
  }

  @override
  R fold<R>(R Function(S p1) successMapper, R Function(F p1) failureMapper) {
    return failureMapper(_value);
  }

  @override
  Result<S, F2> mapFailure<F2>(F2 Function(F p1) mapper) {
    return _Failure(mapper(_value));
  }

  @override
  Result<S2, F> mapSuccess<S2>(S2 Function(S p1) mapper) {
    return _Failure(_value);
  }
}

class ResultException<F> implements Exception {
  final Optional<String> _message;

  final F failure;

  ResultException(this.failure, {String? message})
      : _message = Optional.of(message);

  @override
  String toString() {
    final msg = _message.fold((p0) => "\n\tMessage: $p0", "");
    return "ResultException:\n\tFailure: $failure$msg";
  }
}
