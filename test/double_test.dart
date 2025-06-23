import 'package:bip21_uri/bip21_uri.dart';
import 'package:test/test.dart';

// I've made these tests to ensure double is safe to use in the context of bitcoin amount
void main() {
  test('floating point precision issues', () {
    final parsed = num.parse('0.1');
    final float = 0.1000000000000000055511151231257827021181583404541015625;
    expect(parsed, equals(float));

    expect(parsed.toString(), equals('0.1')); // Dart rounds it back for display
    expect(parsed == float, isTrue); // But they're considered equal
    expect(parsed == 0.1, isTrue); // But they're considered equal
  });

  test('one sat btc unit', () {
    final small = 0.00000001;
    // The exact IEEE 754 representation
    final exact =
        0.0000000100000000000000002068528198616814855757735148290427960662841796875;

    expect(small, equals(exact));

    // When you parse "0.00000001", you get the exact representation
    final parsed = num.parse('0.00000001');
    expect(parsed, equals(exact));

    // But toString() shows scientific notation for very small numbers
    expect(parsed.toString(), equals('1e-8'));

    // You can force decimal notation
    expect(parsed.toStringAsFixed(8), equals('0.00000001'));
  });

  test('Unfortunatly the amount will be rounded', () {
    // The exact IEEE 754 representation
    final exact = 0.1000000000000000055511151231257827021181583404541015625;
    const rounded = 0.1;

    final encoded = bip21.encode(
      Bip21Uri(
        amount: exact,
        scheme: 'bitcoin',
        address: '1BgGZ9tcN4rm9KBzDn7KprQz87SZ26SAMH',
      ),
    );

    final decoded = bip21.decode(encoded);
    expect(decoded.amount, equals(exact));
    expect(decoded.amount, equals(rounded));

    // const expected =
    //     'bitcoin:1BgGZ9tcN4rm9KBzDn7KprQz87SZ26SAMH?amount=0.1000000000000000055511151231257827021181583404541015625';
    // expect(encoded, equals(expected));
  });
}
