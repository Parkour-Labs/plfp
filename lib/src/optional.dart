/// The optional value.
abstract class Optional<T> {
  /// Whether this is a [_Some] value.
  bool get isSome;

  /// Whether this is a [_None] value.
  bool get isNone;

  /// Creates an [Optional].
  const Optional._();

  /// Creates a [_Some] value.
  factory Optional.some(T value) => _Some(value);

  /// Creates a [_Some] value if [value] is not `null`, otherwise returns a
  /// [_None] value.
  factory Optional.of(T? value) => value == null ? _None() : _Some(value);

  /// Creates a [_Some] value if the evaluation is not failure, otherwise
  /// returns a [_None] value.
  factory Optional.from(T Function() action) {
    try {
      return Optional.some(action());
    } catch (_) {
      return Optional.none();
    }
  }

  /// Creates a [_None] value.
  factory Optional.none() => _None();

  /// Gets the value if it is present, otherwise returns [orElse].
  T getOrElse(T orElse);

  /// Gets the value if it is present, otherwise throws an [UnsupportedError].
  T getOrThrow({Exception? exception});

  /// Maps the value if it is present, otherwise returns a [_None] value.
  Optional<R> map<R>(R Function(T) mapper);

  /// Flat maps the value if it is present, otherwise returns a [_None] value.
  Optional<R> flatMap<R>(Optional<R> Function(T) mapper);

  /// Folds the value if it is present, otherwise returns [orElse].
  R fold<R>(R Function(T) mapper, R orElse);
}

/// A value that is present.
class _Some<T> extends Optional<T> {
  /// The value that is present.
  final T value;

  @override
  bool get isNone => false;

  @override
  bool get isSome => true;

  /// Creates a [_Some] value.
  const _Some(this.value) : super._();

  @override
  T getOrElse(T orElse) {
    return value;
  }

  @override
  T getOrThrow({Exception? exception}) {
    return value;
  }

  @override
  Optional<R> map<R>(R Function(T p1) mapper) {
    return Optional.some(mapper(value));
  }

  @override
  Optional<R> flatMap<R>(Optional<R> Function(T p1) mapper) {
    return mapper(value);
  }

  @override
  String toString() {
    return 'Some($value)';
  }

  @override
  R fold<R>(R Function(T p1) mapper, R orElse) {
    return mapper(value);
  }
}

/// A value that is absent.
class _None<T> extends Optional<T> {
  /// Creates a [_None] value.
  const _None() : super._();

  @override
  bool get isNone => true;

  @override
  bool get isSome => false;

  @override
  T getOrElse(T orElse) {
    return orElse;
  }

  @override
  T getOrThrow({Exception? exception}) {
    if (exception != null) {
      throw exception;
    } else {
      throw UnsupportedError('Cannot get value of a None');
    }
  }

  @override
  Optional<R> map<R>(R Function(T p1) mapper) {
    return Optional.none();
  }

  @override
  Optional<R> flatMap<R>(Optional<R> Function(T p1) mapper) {
    return Optional.none();
  }

  @override
  String toString() {
    return 'None';
  }

  @override
  R fold<R>(R Function(T p1) mapper, R orElse) {
    return orElse;
  }
}
