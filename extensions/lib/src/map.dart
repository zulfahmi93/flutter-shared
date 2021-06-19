extension MapExtensions<K, V> on Map<K, V>? {
  bool get isNullOrEmpty {
    return this == null || this!.isEmpty;
  }
}
