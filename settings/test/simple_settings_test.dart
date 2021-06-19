import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_settings/simple_settings.dart';
import 'package:test/test.dart';

void main() {
  testHive();
  testSharedPreferences();
}

void testHive() {
  testHiveDefaultValues();
  testHiveGetBool();
  testHiveGetDouble();
  testHiveGetInt();
  testHiveGetString();
}

void testHiveDefaultValues() {
  test(
    'Test get default value using Hive provider.',
    () {
      final mockBoolBox = MockBox<bool>();
      final mockDoubleBox = MockBox<double>();
      final mockIntBox = MockBox<int>();
      final mockStringBox = MockBox<String>();

      final ISettings si = HiveSettings(
        mockBoolBox,
        mockDoubleBox,
        mockIntBox,
        mockStringBox,
      );

      final defaultBool = true;
      final defaultDouble = 1.0;
      final defaultInt = 2;
      final defaultString = 'empty';

      when(mockBoolBox.get(any)).thenReturn(defaultBool);
      when(mockDoubleBox.get(any)).thenReturn(defaultDouble);
      when(mockIntBox.get(any)).thenReturn(defaultInt);
      when(mockStringBox.get(any)).thenReturn(defaultString);

      expect(defaultBool, si.getBool('ANY', defaultBool));
      expect(defaultDouble, si.getDouble('ANY', defaultDouble));
      expect(defaultInt, si.getInt('ANY', defaultInt));
      expect(defaultString, si.getString('ANY', defaultString));
    },
  );
}

void testHiveGetBool() {
  test(
    'Test get boolean value using Hive provider.',
    () {
      final mockBoolBox = MockBox<bool>();
      final mockDoubleBox = MockBox<double>();
      final mockIntBox = MockBox<int>();
      final mockStringBox = MockBox<String>();

      final ISettings si = HiveSettings(
        mockBoolBox,
        mockDoubleBox,
        mockIntBox,
        mockStringBox,
      );

      final defaultBool = true;
      when(mockBoolBox.get('KEY')).thenReturn(defaultBool);
      expect(defaultBool, si.getBool('KEY', defaultBool));
      when(mockBoolBox.get('KEY')).thenReturn(false);
      expect(false, si.getBool('KEY', defaultBool));
    },
  );
}

void testHiveGetDouble() {
  test(
    'Test get double value using Hive provider.',
    () {
      final mockBoolBox = MockBox<bool>();
      final mockDoubleBox = MockBox<double>();
      final mockIntBox = MockBox<int>();
      final mockStringBox = MockBox<String>();

      final ISettings si = HiveSettings(
        mockBoolBox,
        mockDoubleBox,
        mockIntBox,
        mockStringBox,
      );

      final defaultDouble = 1.0;
      when(mockDoubleBox.get('KEY')).thenReturn(defaultDouble);
      expect(defaultDouble, si.getDouble('KEY', defaultDouble));
      when(mockDoubleBox.get('KEY')).thenReturn(2.0);
      expect(2.0, si.getDouble('KEY', defaultDouble));
    },
  );
}

void testHiveGetInt() {
  test(
    'Test get integer value using Hive provider.',
    () {
      final mockBoolBox = MockBox<bool>();
      final mockDoubleBox = MockBox<double>();
      final mockIntBox = MockBox<int>();
      final mockStringBox = MockBox<String>();

      final ISettings si = HiveSettings(
        mockBoolBox,
        mockDoubleBox,
        mockIntBox,
        mockStringBox,
      );

      final defaultInt = 1;
      when(mockIntBox.get('KEY')).thenReturn(defaultInt);
      expect(defaultInt, si.getInt('KEY', defaultInt));
      when(mockIntBox.get('KEY')).thenReturn(2);
      expect(2, si.getInt('KEY', defaultInt));
    },
  );
}

void testHiveGetString() {
  test(
    'Test get string value using Hive provider.',
    () {
      final mockBoolBox = MockBox<bool>();
      final mockDoubleBox = MockBox<double>();
      final mockIntBox = MockBox<int>();
      final mockStringBox = MockBox<String>();

      final ISettings si = HiveSettings(
        mockBoolBox,
        mockDoubleBox,
        mockIntBox,
        mockStringBox,
      );

      final defaultString = 'empty';
      when(mockStringBox.get('KEY')).thenReturn(defaultString);
      expect(defaultString, si.getString('KEY', defaultString));
      when(mockStringBox.get('KEY')).thenReturn('not-empty');
      expect('not-empty', si.getString('KEY', defaultString));
    },
  );
}

void testSharedPreferences() {
  testSharedPreferencesDefaultValues();
  testSharedPreferencesGetBool();
  testSharedPreferencesGetDouble();
  testSharedPreferencesGetInt();
  testSharedPreferencesGetString();
}

void testSharedPreferencesDefaultValues() {
  test(
    'Test get default value using SharedPreferences provider.',
    () async {
      SharedPreferences.setMockInitialValues({});
      final ISettings si = SharedPreferencesSettings(
        await SharedPreferences.getInstance(),
      );

      final defaultValue = 'default';
      expect(defaultValue, si.getString('ANY', defaultValue));
    },
  );
}

void testSharedPreferencesGetBool() {
  test(
    'Test get boolean value using SharedPreferences provider.',
    () async {
      SharedPreferences.setMockInitialValues({});
      final ISettings si = SharedPreferencesSettings(
        await SharedPreferences.getInstance(),
      );

      expect(false, si.getBool('ANY', false));
      si.setBool('ANY', true);
      expect(true, si.getBool('ANY', false));
    },
  );
}

void testSharedPreferencesGetDouble() {
  test(
    'Test get double value using SharedPreferences provider.',
    () async {
      SharedPreferences.setMockInitialValues({});
      final ISettings si = SharedPreferencesSettings(
        await SharedPreferences.getInstance(),
      );

      expect(0.0, si.getDouble('ANY', 0.0));
      si.setDouble('ANY', 1.0);
      expect(1.0, si.getDouble('ANY', 0.0));
    },
  );
}

void testSharedPreferencesGetInt() {
  test(
    'Test get integer value using SharedPreferences provider.',
    () async {
      SharedPreferences.setMockInitialValues({});
      final ISettings si = SharedPreferencesSettings(
        await SharedPreferences.getInstance(),
      );

      expect(0, si.getInt('ANY', 0));
      si.setInt('ANY', 1);
      expect(1, si.getInt('ANY', 0));
    },
  );
}

void testSharedPreferencesGetString() {
  test(
    'Test get string value using SharedPreferences provider.',
    () async {
      SharedPreferences.setMockInitialValues({});
      final ISettings si = SharedPreferencesSettings(
        await SharedPreferences.getInstance(),
      );

      expect('empty', si.getString('ANY', 'empty'));
      si.setString('ANY', 'not empty');
      expect('not empty', si.getString('ANY', 'empty'));
    },
  );
}

class MockBox<T> extends Mock implements Box<T> {}
