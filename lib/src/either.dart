import 'package:plfp/src/optional.dart';

/// A union type that represents either a [Left] or a [Right].
abstract class Either<L, R> {
  /// Whether this is a [Left] value.
  bool get isLeft;

  /// Whether this is a [Right] value.
  bool get isRight;

  /// The left value if it is present, otherwise a [_None] value.
  Optional<L> get leftOrNone;

  /// The right value if it is present, otherwise a [_None] value.
  Optional<R> get rightOrNone;

  const Either._();

  /// Creates a [Left] value.
  factory Either.left(L value) => _Left(value);

  /// Creates a [Right] value.
  factory Either.right(R value) => _Right(value);

  /// Returns the value if this is a [Left] value, otherwise throws an
  /// [UnsupportedError].
  L leftOrThrow({Exception? exception});

  /// Returns the value if this is a [Right] value, otherwise throws an
  /// [UnsupportedError].
  R rightOrThrow({Exception? exception});

  /// Maps the left value if it is present, otherwise returns a [Right] value.
  Either<L1, R> mapLeft<L1>(L1 Function(L) mapper);

  /// Maps the right value if it is present, otherwise returns a [Left] value.
  Either<L, R1> mapRight<R1>(R1 Function(R) mapper);

  /// Flat maps the left value if it is present, otherwise returns a [Right]
  /// value.
  Either<L1, R> flatMapLeft<L1>(Either<L1, R> Function(L) mapper);

  /// Flat maps the right value if it is present, otherwise returns a [Left]
  /// value.
  Either<L, R1> flatMapRight<R1>(Either<L, R1> Function(R) mapper);

  /// Maps the value.
  Either<L1, R1> map<L1, R1>(
    L1 Function(L) leftMapper,
    R1 Function(R) rightMapper,
  );

  /// Flat maps the value.
  Either<L1, R1> flatMap<L1, R1>(
    Either<L1, R1> Function(L) leftMapper,
    Either<L1, R1> Function(R) rightMapper,
  );

  /// Folds the value.
  F fold<F>(F Function(L) leftMapper, F Function(R) rightMapper);
}

/// The left part of an [Either].
class _Left<L, R> extends Either<L, R> {
  /// The value on the left.
  final L value;

  @override
  bool get isLeft => true;

  @override
  bool get isRight => false;

  @override
  Optional<L> get leftOrNone => Optional.some(value);

  @override
  Optional<R> get rightOrNone => Optional.none();

  /// Creates the left part of an [Either].
  const _Left(this.value) : super._();

  @override
  L leftOrThrow({Exception? exception}) {
    return value;
  }

  @override
  R rightOrThrow({Exception? exception}) {
    if (exception != null) {
      throw exception;
    } else {
      throw UnsupportedError('Cannot get right value of a Left');
    }
  }

  @override
  Either<L1, R> mapLeft<L1>(L1 Function(L p1) mapper) {
    return Either.left(mapper(value));
  }

  @override
  Either<L, R1> mapRight<R1>(R1 Function(R p1) mapper) {
    return Either.left(value);
  }

  @override
  Either<L1, R> flatMapLeft<L1>(Either<L1, R> Function(L p1) mapper) {
    return mapper(value);
  }

  @override
  Either<L, R1> flatMapRight<R1>(Either<L, R1> Function(R p1) mapper) {
    return Either.left(value);
  }

  @override
  Either<L1, R1> map<L1, R1>(
    L1 Function(L p1) leftMapper,
    R1 Function(R p1) rightMapper,
  ) {
    return Either.left(leftMapper(value));
  }

  @override
  Either<L1, R1> flatMap<L1, R1>(
    Either<L1, R1> Function(L p1) leftMapper,
    Either<L1, R1> Function(R p1) rightMapper,
  ) {
    return leftMapper(value);
  }

  @override
  F fold<F>(F Function(L p1) leftMapper, F Function(R p1) rightMapper) {
    return leftMapper(value);
  }
}

/// The right part of an [Either].
class _Right<L, R> extends Either<L, R> {
  /// The value on the right.
  final R value;

  @override
  bool get isLeft => false;

  @override
  bool get isRight => true;

  @override
  Optional<L> get leftOrNone => Optional.none();

  @override
  Optional<R> get rightOrNone => Optional.some(value);

  /// Creates the right part of an [Either].
  const _Right(this.value) : super._();

  @override
  L leftOrThrow({Exception? exception}) {
    if (exception != null) {
      throw exception;
    } else {
      throw UnsupportedError('Cannot get left value of a Right');
    }
  }

  @override
  R rightOrThrow({Exception? exception}) {
    return value;
  }

  @override
  Either<L1, R> mapLeft<L1>(L1 Function(L p1) mapper) {
    return Either.right(value);
  }

  @override
  Either<L, R1> mapRight<R1>(R1 Function(R p1) mapper) {
    return Either.right(mapper(value));
  }

  @override
  Either<L1, R> flatMapLeft<L1>(Either<L1, R> Function(L p1) mapper) {
    return Either.right(value);
  }

  @override
  Either<L, R1> flatMapRight<R1>(Either<L, R1> Function(R p1) mapper) {
    return mapper(value);
  }

  @override
  Either<L1, R1> flatMap<L1, R1>(
    Either<L1, R1> Function(L p1) leftMapper,
    Either<L1, R1> Function(R p1) rightMapper,
  ) {
    return rightMapper(value);
  }

  @override
  Either<L1, R1> map<L1, R1>(
    L1 Function(L p1) leftMapper,
    R1 Function(R p1) rightMapper,
  ) {
    return Either.right(rightMapper(value));
  }

  @override
  F fold<F>(F Function(L p1) leftMapper, F Function(R p1) rightMapper) {
    return rightMapper(value);
  }
}
