import 'package:dart_bip21/dart_bip21.dart';
import 'package:test/test.dart';

import 'fixtures.dart';

void main() {
  group('BIP21', () {
    for (var f in fixtures.valid) {
      if (f.compliant == false) continue;

      test('encodes ${f.uri}', () {
        String result =
            bip21.tryEncode(f.address, f.options, f.urnScheme ?? 'bitcoin');
        // replace the bitcoin: portion (case-insensitive) with lowercase
        expect(
            result,
            f.uri.replaceAll(
                RegExp(r'^bitcoin:', caseSensitive: false, multiLine: true),
                'bitcoin:'));
      });

      test(
          'decodes ' + f.uri + (f.compliant == false ? ' (non-compliant)' : ''),
          () {
        BIP21 decode = bip21.decode(f.uri, f.urnScheme ?? 'bitcoin');

        expect(decode.address, f.address);

        if (f.options != null) return;
        expect(
            decode.options['amount'],
            f.options!['amount'] != null
                ? num.tryParse(f.options!['amount'])
                : null);
        expect(decode.options['label'], f.options!['label']);
        expect(decode.options['message'], f.options!['message']);
      });
    }
    for (Invalid f in fixtures.invalid) {
      if (f.address != null) {
        test('throws ${f.exception} for ${f.uri}', () {
          try {
            bip21.tryEncode(f.address!, f.options);
          } catch (e) {
            return expect(e.toString(), matches(RegExp(f.exception)));
          }
          throw Exception('It should throw "${f.exception}" exception.');
        });
      }

      if (f.uri != null) {
        test('throws ${f.exception} for ${f.uri!}', () {
          try {
            bip21.decode(f.uri!);
          } catch (e) {
            return expect(e.toString(), matches(RegExp(f.exception)));
          }
          throw Exception('It should throw "${f.exception}" exception.');
        });
      }
    }
  });
}
