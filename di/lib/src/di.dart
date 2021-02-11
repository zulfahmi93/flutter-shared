import 'package:logging/logging.dart';

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

    // Since null checking has been done above, it is logical to put
    // null ignore here as the [instance] will be always not null.
    return _instance!;
  }

  // ---------------------------- STATIC FIELDS ---------------------------
  static ServiceProvider? _instance;

  // ------------------------------- FIELDS -------------------------------
  /// List of resolvable singleton services.
  final _services = <Type, _Resolver<dynamic, dynamic>>{};

  /// Register a service which will always be resolved to a very same instance
  /// each time the service is requested.
  void addInstanceSingleton<T>({required T service}) {
    Logger.root.finest('Adding singleton instance of type $T.');
    _services[T] = _SingletonInstanceResolver<T>(
      resolvedInstance: service,
    );
  }

  /// Register a service which will always be resolved to a very same instance
  /// each time the service is requested.
  void addSingleton<T>({required ResolverFunction<Null, T> resolver}) {
    addSingletonWithArgs(resolver: resolver);
  }

  /// Register a service which will always be resolved to a very same instance
  /// each time the service is requested.
  void addSingletonWithArgs<S, T>({required ResolverFunction<S, T> resolver}) {
    Logger.root.finest('Adding singleton resolver of type $T.');
    _services[T] = _SingletonResolver<S, T>(resolver: resolver);
  }

  /// Register a service which will always be resolved to a very same instance
  /// each time the service is requested.
  void addTransient<T>({required ResolverFunction<Null, T> resolver}) {
    addTransientWithArgs(resolver: resolver);
  }

  /// Register a service which will always be resolved to a very same instance
  /// each time the service is requested.
  void addTransientWithArgs<S, T>({required ResolverFunction<S, T> resolver}) {
    Logger.root.finest('Adding transient resolver of type $T.');
    _services[T] = _TransientResolver<S, T>(resolver: resolver);
  }

  /// Reset this service provider.
  void reset() {
    _services.clear();
  }

  // ------------------------------- METHODS ------------------------------
  /// Get requested service of given type.
  ///
  /// This method will throw [DependencyNotFoundError] if the requested service
  /// is not registered.
  T getService<T>() => getServiceWithArgs<Null, T>();

  /// Get requested service of given type.
  ///
  /// This method will throw [DependencyNotFoundError] if the requested service
  /// is not registered.
  T getServiceWithArgs<S, T>({S? args}) {
    if (!_services.containsKey(T)) {
      Logger.root.severe('Failed to resolve dependency! Type: $T');
      throw DependencyNotFoundError(T);
    }

    final resolver = _services[T];

    if (resolver is _SingletonInstanceResolver<T>) {
      return resolver.resolvedInstance;
    }

    if (resolver is _TransientResolver<S, T>) {
      return resolver.resolve(args);
    }

    if (resolver is _SingletonResolver<S, T>) {
      final resolved = resolver.resolve(args);
      _services.remove(T);
      _services[T] = _SingletonInstanceResolver<T>(
        resolvedInstance: resolved,
      );
      return resolved;
    }

    throw DependencyNotFoundError(T);
  }
}

/// Error which is thrown when dependency resolver failed to resolve required
/// dependency asked.
class DependencyNotFoundError extends Error {
  // ---------------------------- CONSTRUCTORS ----------------------------
  /// Create new [DependencyNotFoundError].
  DependencyNotFoundError(this.dependencyType);

  // ------------------------------- FIELDS -------------------------------
  /// Type of required dependency which is failed to be resolved.
  final Type dependencyType;
}

/// Contains the information to help the service resolver to resolve the
/// requested service. This is an abstract class.
// ignore: one_member_abstracts
abstract class _Resolver<S, T> {
  // ------------------------------- FIELDS -------------------------------
  /// Resolver method. Should be automatically invoked when requested service
  /// is not present but this method is present.
  T resolve(S? args);
}

/// Implements the [_Resolver] class by using transient service lifetime.
class _TransientResolver<S, T> extends _Resolver<S, T> {
  // ---------------------------- CONSTRUCTORS ----------------------------
  /// Create new [_TransientResolver].
  _TransientResolver({
    required this.resolver,
  });

  // ------------------------------- FIELDS -------------------------------
  /// Resolver method. Should be automatically invoked when requested service
  /// is not present but this method is present.
  final ResolverFunction<S?, T> resolver;

  // ------------------------------- METHODS ------------------------------
  @override
  T resolve(S? args) => resolver(args);
}

/// Implements the [_Resolver] class by using singleton service lifetime.
class _SingletonResolver<S, T> extends _Resolver<S, T> {
  // ---------------------------- CONSTRUCTORS ----------------------------
  /// Create new [_SingletonResolver].
  _SingletonResolver({
    required this.resolver,
  });

  // ------------------------------- FIELDS -------------------------------
  /// Resolver method. Should be automatically invoked when requested service
  /// is not present but this method is present.
  final ResolverFunction<S?, T> resolver;

  // ------------------------------- METHODS ------------------------------
  @override
  T resolve(S? args) => resolver(args);
}

/// Implements the [_Resolver] class by using singleton service lifetime.
class _SingletonInstanceResolver<T> extends _Resolver<Null, T> {
  // ---------------------------- CONSTRUCTORS ----------------------------
  /// Create new [_SingletonInstanceResolver].
  _SingletonInstanceResolver({
    required this.resolvedInstance,
  });

  // ------------------------------- FIELDS -------------------------------
  /// The requested service.
  final T resolvedInstance;

  // ------------------------------- METHODS ------------------------------
  @override
  T resolve(_) => resolvedInstance;
}

/// Type alias for function which asynchronously resolve the required
/// dependency.
typedef ResolverFunction<S, T> = T Function(S? args);
