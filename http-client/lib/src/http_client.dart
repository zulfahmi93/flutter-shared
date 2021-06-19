import 'package:dio/dio.dart';

import 'constants.dart';

class UkuyaHttpClient {
  // ---------------------------- CONSTRUCTORS ----------------------------
  /// Create new [UkuyaHttpClient].
  UkuyaHttpClient._();

  /// Get the singleton instance of [UkuyaHttpClient].
  factory UkuyaHttpClient() {
    _instances[''] ??= UkuyaHttpClient._();
    // This should be always not null as initialisation is already done before.
    return _instances['']!;
  }

  /// Get the named singleton instance of [UkuyaHttpClient].
  factory UkuyaHttpClient.named(String name) {
    assert(name.isNotEmpty);
    _instances[name] ??= UkuyaHttpClient._();
    // This should be always not null as initialisation is already done before.
    return _instances[name]!;
  }

  // ------------------------------- FIELDS -------------------------------
  /// HTTP client.
  final Dio _client = Dio(
    BaseOptions(
      connectTimeout: C.httpClientConnectTimeout,
      receiveTimeout: C.httpClientReceiveTimeout,
      sendTimeout: C.httpClientSendTimeout,
      responseType: C.httpClientResponseType,
    ),
  );

  // ---------------------------- STATIC FIELDS ---------------------------
  /// Singleton instances of [UkuyaHttpClient].
  static final Map<String, UkuyaHttpClient> _instances = {};

  // ----------------------------- PROPERTIES -----------------------------
  /// Gets the configure HTTP client instance.
  Dio get client => _client;

  // ------------------------------- METHODS ------------------------------
  /// Add interceptor to the internal HTTP client instance.
  void addInterceptor(Interceptor interceptor) {
    _client.interceptors.add(interceptor);
  }

  /// Reset this HTTP client to its initial state.
  void reset() {
    _client.interceptors.clear();
  }
}
