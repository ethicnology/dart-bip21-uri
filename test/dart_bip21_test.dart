import 'package:bip21_uri/bip21_uri.dart';
import 'package:test/test.dart';

import 'fixtures.dart';

void main() {
  group('BIP21', () {
    group('Valid', () {
      for (var f in fixtures.valid) {
        test('encodes ${f.uri}', () {
          String result = bip21.encode(
            Bip21Uri(
              scheme: f.scheme ?? 'bitcoin',
              address: f.address,
              amount: f.amount,
              label: f.label?.toString(),
              message: f.message?.toString(),
              options: f.options ?? <String, dynamic>{},
            ),
          );

          expect(result, f.uri);
        });

        test('decodes ${f.uri}', () {
          final uri = f.uri;
          final decode = bip21.decode(uri);
          expect(decode.scheme, f.scheme);
          expect(decode.address, f.address);
          expect(decode.amount, f.amount);
          expect(decode.label, f.label?.toString());
          expect(decode.message, f.message?.toString());
          expect(decode.options, f.options ?? <String, dynamic>{});
        });
      }
    });

    group('Invalid', () {
      for (Invalid f in fixtures.invalid) {
        test('throws ${f.exception} for ${f.uri}', () {
          try {
            bip21.decode(f.uri!);
          } catch (e) {
            return expect(e.toString(), matches(RegExp(f.exception)));
          }
          throw 'It should throw "${f.exception}" exception.';
        });
      }
    });
  });
}
