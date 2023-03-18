import 'dart:collection';

import 'package:plfp/src/lazy.dart';
import 'package:plfp/src/optional.dart';
import 'package:plfp/src/result.dart';

class ServiceStore {
  /// The singleton instance.
  static ServiceStore? _instance;

  /// The singleton instance.
  static ServiceStore get instance {
    return _instance ??= ServiceStore();
  }

  final Map<Type, Lazy> _store;

  final Map<Type, Map<Object, Lazy>> _storeWithKey;

  /// Creates a [ServiceStore].
  ServiceStore({
    Map<Type, Lazy>? store,
    Map<Type, Map<Object, Lazy>>? storeWithKey,
  })  : _store = store ?? HashMap(),
        _storeWithKey = storeWithKey ?? HashMap();

  /// Gets the value.
  T get<T>({Object? key}) {
    try {
      if (key == null) {
        return _store[T]!.get();
      } else {
        return _storeWithKey[T]![key]!.get();
      }
    } on StateError catch (e) {
      throw ServiceStoreException(e.message);
    }
  }

  Result<T, ServiceStoreException> getResult<T>({String? key}) {
    return Result.from(() => get<T>(key: key));
  }

  Optional<T> getOptional<T>({String? key}) {
    return Optional.from(() => get<T>(key: key));
  }

  Lazy<T> getLazy<T>({String? key}) {
    return Lazy(() => get<T>(key: key));
  }

  LazyOptional<T> getLazyOptional<T>({String? key}) {
    return Lazy(() => getOptional<T>(key: key));
  }

  LazyResult<T, ServiceStoreException> getLazyResult<T>({String? key}) {
    return Lazy(() => getResult<T>(key: key));
  }

  /// Sets the value.
  void set<T>(T value, {Object? key}) {
    // if already set, throw an exception
    if (key == null) {
      if (_store.containsKey(T)) {
        throw ServiceStoreException('Service $value already set');
      }
      _store[T] = Lazy.of(value);
    } else {
      _storeWithKey[T] ??= {};
      if (_storeWithKey[T]!.containsKey(key)) {
        throw ServiceStoreException('Service $value already set for key $key');
      }
      _storeWithKey[T]![key] = Lazy.of(value);
    }
  }

  /// Sets the value lazily.
  void setLazy<T>(Supplier<T> supplier, {Object? key}) {
    if (key == null) {
      if (_store.containsKey(T)) {
        throw ServiceStoreException('Service $supplier already set');
      }
      _store[T] = Lazy(supplier);
    } else {
      _storeWithKey[T] ??= {};
      if (_storeWithKey[T]!.containsKey(key)) {
        throw ServiceStoreException(
            'Service $supplier already set for key $key');
      }
      _storeWithKey[T]![key] = Lazy(supplier);
    }
  }
}

class ServiceStoreException implements Exception {
  /// The message.
  final String message;

  /// Creates a [ServiceStoreException].
  const ServiceStoreException(this.message);

  @override
  String toString() => 'SingletonStoreException: $message';
}
