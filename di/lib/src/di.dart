import 'package:meta/meta.dart';

/// Simple utility which helps to manage application services and retrieve
/// the requested service when required.
class ServiceProvider {
  // ---------------------------- CONSTRUCTORS ----------------------------
  /// Create new [ServiceProvider].
  ServiceProvider._();

  /// Get the singleton instance of [ServiceProvider].
  factory ServiceProvider() {
    if (_instance == null) {
      _instance = ServiceProvider._();
    }

    return _instance;
  }

  // ---------------------------- STATIC FIELDS ---------------------------
  static ServiceProvider _instance;

  // ------------------------------- FIELDS -------------------------------
  /// List of resolvable singleton services.
  final _services = <Type, _Resolver<dynamic>>{};

  /// Register a service which will always be resolved to a very same instance
  /// each time the service is requested.
  void registerInstance<T>({@required T service}) {
    _services[T] = _Resolver<T>(resolvedService: service);
  }

  /// Register a service which will be resolved using the given resolver
  /// function each time the service is requested.
  void registerResolver<T>({@required ResolverFunction<T> resolver}) {
    _services[T] = _Resolver<T>(resolver: resolver);
  }

  /// Reset this service provider.
  void reset() {
    _services.clear();
  }

  // ------------------------------- METHODS ------------------------------
  /// Get requested service of given type.
  ///
  /// By default, this method will throw [_DependencyNotFoundError] if the
  /// requested service is not registered. Set the [throwIfNotFound] parameter
  /// to `false` to change this behaviour.
  T getService<T>({dynamic args, bool throwIfNotFound = true}) {
    if (!_services.containsKey(T)) {
      print('Failed to resolve dependency! Type: $T');
      if (throwIfNotFound) {
        throw _DependencyNotFoundError(T);
      } else {
        return null;
      }
    }

    final _Resolver<T> details = _services[T];

    // Auto resolve.
    if (details.resolvedService == null) {
      if (details.resolver != null) {
        details.resolvedService = details.resolver(args);
      }
    }

    return details.resolvedService;
  }
}

/// Error which is thrown when dependency resolver failed to resolve required
/// dependency asked.
class _DependencyNotFoundError extends Error {
  // ---------------------------- CONSTRUCTORS ----------------------------
  /// Create new [_DependencyNotFoundError].
  _DependencyNotFoundError(this.dependencyType);

  // ------------------------------- FIELDS -------------------------------
  /// Type of required dependency which is failed to be resolved.
  final Type dependencyType;
}

/// Contains the information to help the service resolver to resolve the
/// requested service.
class _Resolver<T> {
  // ---------------------------- CONSTRUCTORS ----------------------------
  /// Create new [_Resolver].
  _Resolver({
    this.resolvedService,
    this.resolver,
  });

  // ------------------------------- FIELDS -------------------------------
  /// Resolver method. Should be automatically invoked when requested service
  /// is not present but this method is present.
  final ResolverFunction<T> resolver;

  /// The requested service.
  T resolvedService;
}

/// Type alias for function which asynchronously resolve the required
/// dependency.
typedef ResolverFunction<T> = T Function(dynamic args);
