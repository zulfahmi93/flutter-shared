import 'dart:math';

import 'package:simple_di/simple_di.dart';
import 'package:test/test.dart';

// ------------------------------ VARIABLES -----------------------------

// ------------------------------ FUNCTIONS -----------------------------
void main() {
  testDependencyError();
  testTransient();
  testSingleton();
}

void testDependencyError() {
  test(
    'Test resolving non-existing service and should throw error.',
    () {
      final di = ServiceProvider();
      expect(
        () => di.getService<int>(),
        throwsA(TypeMatcher<DependencyNotFoundError>()),
      );
    },
  );
}

void testTransient() {
  test(
    'Test resolving a transient service.',
    () {
      final di = ServiceProvider();
      di.addTransient(resolver: (_) => _Test());
      final i1 = di.getService<_Test>();
      final i2 = di.getService<_Test>();
      expect(false, i1.test == i2.test);
    },
  );
}

void testSingleton() {
  test(
    'Test resolving a singleton service.',
    () {
      final di = ServiceProvider();
      di.addSingleton(resolver: (_) => _Test());
      final i1 = di.getService<_Test>();
      final i2 = di.getService<_Test>();
      expect(true, i1.test == i2.test);
    },
  );
}

void testInstanceSingleton() {
  test(
    'Test resolving a singleton service.',
    () {
      final di = ServiceProvider();
      di.addInstanceSingleton(service: _Test());
      final i1 = di.getService<_Test>();
      final i2 = di.getService<_Test>();
      expect(true, i1.test == i2.test);
    },
  );
}

class _Test {
  // ---------------------------- CONSTRUCTORS ----------------------------
  _Test() {
    test = Random.secure().nextInt(1000);
  }

  // ------------------------------- FIELDS -------------------------------
  late int test;
}
