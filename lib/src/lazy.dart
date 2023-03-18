import '../plfp.dart';

/// A function that returns a value.
typedef Supplier<T> = T Function();

/// Lazy optional.
typedef LazyOptional<T> = Lazy<Optional<T>>;

/// Lazy result.
typedef LazyResult<T, E> = Lazy<Result<T, E>>;

/// Represents a value that is computed lazily.
class Lazy<T> {
  /// The value is either a [Supplier] or the actual value.
  Either<Supplier<T>, T> _supplierOrValue;

  /// Creates a [Lazy] value.
  Lazy._(this._supplierOrValue);

  /// Creates a [Lazy] value.
  factory Lazy(Supplier<T> supplier) {
    return Lazy._(Either.left(supplier));
  }

  /// Creates a [Lazy] value.
  factory Lazy.of(T value) {
    return Lazy._(Either.right(value));
  }

  /// Gets the value.
  T get() {
    return _supplierOrValue.fold(
      (supplier) {
        final value = supplier();
        _supplierOrValue = Either.right(value);
        return value;
      },
      (value) => value,
    );
  }

  /// Maps the value.
  Lazy<R> map<R>(R Function(T) mapper) {
    return Lazy(() => mapper(get()));
  }

  /// Flat maps the value.
  Lazy<R> flatMap<R>(Lazy<R> Function(T) mapper) {
    return Lazy(() => mapper(get()).get());
  }
}
