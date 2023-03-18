class Store<K> {
  final Map<K, dynamic> _store = {};

  void set(K key, dynamic value) {
    _store[key] = value;
  }

  dynamic get(K key) {
    return _store[key];
  }
}
