import 'package:test/test.dart';
import 'package:simple_validators/simple_validators.dart';

void main() {
  group('Validators', () {
    _testIsAlphanumeric();
    _testIsEMail();
    _testIsCreditCard();
    _testIsJSON();
    _testIsLength();
    _testIsByteLength();
    _testIsIP();
    _testIsURL();
    _testIsISBN();
    _testIsPostalCode();
  });
}

void _testIsAlphanumeric() {
  test('isAlphanumeric', () {
    _check(
      validator: (str) => str.isAlphanumeric,
      valid: ['abc1', '0A1BC', 'Fo0bAr'],
      invalid: ['abc!', 'AB C', ''],
    );
  });
}

void _testIsEMail() {
  test('isEMail', () {
    _check(
      validator: (str) => str.isEMail,
      valid: [
        'foo@bar.com',
        'x@x.x',
        'foo@bar.com.au',
        'foo+bar@bar.com',
        'hans.m端ller@test.com',
        'hans@m端ller.com',
        'test|123@m端ller.com',
        'test+ext@gmail.com',
        'some.name.midd.leNa.me.+extension@GoogleMail.com',
      ],
      invalid: [
        'invalidemail@',
        'invalid.com',
        '@invalid.com',
        'foo@bar.com.',
        'foo@bar.co.uk.',
      ],
    );
  });
}

void _testIsCreditCard() {
  test('isCreditCard', () {
    _check(
      validator: (str) => str.isCreditCard,
      valid: [
        '375556917985515',
        '36050234196908',
        '4716461583322103',
        '4716-2210-5188-5662',
        '4929 7226 5379 7141',
        '5398228707871527',
      ],
      invalid: [
        '5398228707871528',
        '',
        'Lol0',
      ],
    );
  });
}

void _testIsJSON() {
  test('isJSON', () {
    _check(
      validator: (str) => str.isJSON,
      valid: [
        '{"key": "v"}',
        '{"1": [1, 2, 3]}',
        '[1, 2, 3]',
      ],
      invalid: [
        'foo',
        '{ key: "value" }',
        '{ \'key\': \'value\' }',
      ],
    );
  });
}

void _testIsLength() {
  test('isLength', () {
    _check(
      validator: (str) => str.isLength(min: 2),
      valid: ['ab', 'de', 'abcd', '干𩸽'],
      invalid: ['', 'a', '𠀋'],
    );
    _check(
      validator: (str) => str.isLength(min: 2, max: 3),
      valid: ['abc', 'de', '干𩸽'],
      invalid: ['', '𠀋', '千竈通り'],
    );
  });
}

void _testIsByteLength() {
  test('isByteLength', () {
    _check(
      validator: (str) => str.isByteLength(min: 2),
      valid: ['abc', 'de'],
      invalid: ['', ' '],
    );
    _check(
      validator: (str) => str.isByteLength(min: 2, max: 3),
      valid: ['abc', 'de', '干𩸽'],
      invalid: ['', 'abcdef'],
    );
  });
}

void _testIsIP() {
  test('isIP', () {
    _check(
      validator: (str) => str.isIP(),
      valid: [
        '127.0.0.1',
        '0.0.0.0',
        '255.255.255.255',
        '1.2.3.4',
        '::1',
        '2001:db8:0000:1:1:1:1:1',
      ],
      invalid: [
        'abc',
        '256.0.0.0',
        '0.0.0.256',
        '26.0.0.256',
      ],
    );
  });
}

void _testIsURL() {
  test('isURL', () {
    _check(
      validator: (str) {
        return str.isURL();
      },
      valid: [
        'foobar.com',
        'www.foobar.com',
        'foobar.com/',
        'valid.au',
        'http://www.foobar.com/',
        'http://www.foobar.com:23/',
        'http://www.foobar.com:65535/',
        'http://www.foobar.com:5/',
        'https://www.foobar.com/',
        'ftp://www.foobar.com/',
        'http://www.foobar.com/~foobar',
        'http://user:pass@www.foobar.com/',
        'http://127.0.0.1/',
        'http://10.0.0.0/',
        'http://10.0.0.0:3000/',
        'http://189.123.14.13/',
        'http://duckduckgo.com/?q=%2F',
        'http://foobar.com/t\$-_.+!*\'(),',
        'http://localhost:3000/',
        'http://foobar.com/?foo=bar#baz=qux',
        'http://foobar.com?foo=bar',
        'http://foobar.com#baz=qux',
        'http://www.xn--froschgrn-x9a.net/',
        'http://xn--froschgrn-x9a.com/',
        'http://foo--bar.com',
      ],
      invalid: [
        'xyz://foobar.com',
        'invalid/',
        'invalid.x',
        'invalid.',
        '.com',
        'http://com/',
        'http://300.0.0.1/',
        'mailto:foo@bar.com',
        'rtmp://foobar.com',
        'http://www.xn--.com/',
        'http://xn--.com/',
        'http:// :pass@www.foobar.com/',
        'http://www.foobar.com:0/',
        'http://www.foobar.com:70000/',
        'http://www.foobar.com:99999/',
        'http://www.-foobar.com/',
        'http://www.foobar-.com/',
        'http://www.foo---bar.com/',
        'http://www.foo_bar.com/',
        '',
        'http://foobar.com/${List.filled(2083, null).join('f')}',
        'http://*.foo.com',
        '*.foo.com',
        '!.foo.com',
        'http://localhost:61500this is an invalid url!!!!',
      ],
    );

    expect('www.example.com'.isURL(requireProtocol: true), false);
    expect('example'.isURL(requireTld: false), true);

    expect('www.example.com'.isURL(hostWhitelist: ['www.example.com']), true);
    expect('www.example.com'.isURL(hostWhitelist: ['www.another.com']), false);

    expect('www.example.com'.isURL(hostBlacklist: ['www.example.com']), false);
    expect('www.example.com'.isURL(hostBlacklist: ['www.another.com']), true);
  });
}

void _testIsISBN() {
  test('isISBN', () {
    _check(
      validator: (str) => str.isISBN(version: 10),
      valid: [
        '3836221195',
        '3-8362-2119-5',
        '3 8362 2119 5',
        '1617290858',
        '1-61729-085-8',
        '1 61729 085-8',
        '0007269706',
        '0-00-726970-6',
        '0 00 726970 6',
        '3423214120',
        '3-423-21412-0',
        '3 423 21412 0',
        '340101319X',
        '3-401-01319-X',
        '3 401 01319 X',
      ],
      invalid: [
        '3423214121',
        '3-423-21412-1',
        '3 423 21412 1',
        '978-3836221191',
        '9783836221191',
        '123456789a',
        'foo',
        '',
      ],
    );

    _check(
      validator: (str) => str.isISBN(version: 13),
      valid: [
        '9783836221191',
        '978-3-8362-2119-1',
        '978 3 8362 2119 1',
        '9783401013190',
        '978-3401013190',
        '978 3401013190',
        '9784873113685',
        '978-4-87311-368-5',
        '978 4 87311 368 5',
      ],
      invalid: [
        '9783836221190',
        '978-3-8362-2119-0',
        '978 3 8362 2119 0',
        '3836221195',
        '3-8362-2119-5',
        '3 8362 2119 5',
        '01234567890ab',
        'foo',
        '',
      ],
    );

    _check(
      validator: (str) => str.isISBN(),
      valid: [
        '9783836221191',
        '978-3-8362-2119-1',
        '978 3 8362 2119 1',
        '9783401013190',
        '978-3401013190',
        '978 3401013190',
        '3423214120',
        '3-423-21412-0',
        '3 423 21412 0',
        '340101319X',
        '3-401-01319-X',
        '3 401 01319 X',
      ],
      invalid: [
        '3423214121',
        '9783836221190'
            '01234567890ab',
        'foo',
        '',
      ],
    );
  });
}

void _testIsPostalCode() {
  test('isPostalCode', () {
    _check(
      validator: (str) => str.isPostalCode(countryCode: 'US'),
      valid: ['00000'],
      invalid: ['000000', 'aaaaaa', ''],
    );
    _check(
      validator: (str) => str.isPostalCode(countryCode: 'MY'),
      valid: ['50000', '75450', '26400'],
      invalid: ['000000', 'aaaaaa', ''],
    );
  });
}

void _check({
  List<String> valid = const [],
  List<String> invalid = const [],
  bool validator(String value)?,
}) {
  for (final item in valid) {
    expect(validator!(item), true, reason: '"$item" should be valid');
  }
  for (final item in invalid) {
    expect(validator!(item), false, reason: '"$item" should be invalid');
  }
}
