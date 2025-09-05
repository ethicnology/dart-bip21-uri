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

  test('test empty decode', () {
    final uri =
        'bitcoin:1A1zP1eP5QGefi2DMPTfTL5SLmv7DivfNa?label=&message=&something=value&empty=';
    final decode = bip21.decode(uri);
    expect(decode.amount, null);
    expect(decode.label, '');
    expect(decode.message, '');
    expect(decode.options['something'], 'value');
    expect(decode.options['empty'], '');
    expect(decode.toString(), uri);
  });

  test('test empty encode', () {
    final encoded = bip21.encode(Bip21Uri(
      address: '1A1zP1eP5QGefi2DMPTfTL5SLmv7DivfNa',
      label: '',
      amount: null,
      message: '',
      options: {
        'something': 'value',
        'empty': '',
      },
    ));

    final uri =
        'bitcoin:1A1zP1eP5QGefi2DMPTfTL5SLmv7DivfNa?label=&message=&something=value&empty=';
    expect(encoded, uri);
  });

  test('test lightning invoice decode', () {
    final uri =
        'bitcoin:BC1QYLH3U67J673H6Y6ALV70M0PL2YZ53TZHVXGG7U?amount=0.00001&label=sbddesign%3A%20For%20lunch%20Tuesday&message=For%20lunch%20Tuesday&lightning=LNBC10U1P3PJ257PP5YZTKWJCZ5FTL5LAXKAV23ZMZEKAW37ZK6KMV80PK4XAEV5QHTZ7QDPDWD3XGER9WD5KWM36YPRX7U3QD36KUCMGYP282ETNV3SHJCQZPGXQYZ5VQSP5USYC4LK9CHSFP53KVCNVQ456GANH60D89REYKDNGSMTJ6YW3NHVQ9QYYSSQJCEWM5CJWZ4A6RFJX77C490YCED6PEMK0UPKXHY89CMM7SCT66K8GNEANWYKZGDRWRFJE69H9U5U0W57RRCSYSAS7GADWMZXC8C6T0SPJAZUP6';
    final decode = bip21.decode(uri);

    expect(decode.scheme, 'bitcoin');
    expect(decode.address, 'BC1QYLH3U67J673H6Y6ALV70M0PL2YZ53TZHVXGG7U');
    expect(decode.amount, 0.00001);
    expect(decode.label, 'sbddesign: For lunch Tuesday');
    expect(decode.message, 'For lunch Tuesday');
    expect(decode.options['lightning'],
        'LNBC10U1P3PJ257PP5YZTKWJCZ5FTL5LAXKAV23ZMZEKAW37ZK6KMV80PK4XAEV5QHTZ7QDPDWD3XGER9WD5KWM36YPRX7U3QD36KUCMGYP282ETNV3SHJCQZPGXQYZ5VQSP5USYC4LK9CHSFP53KVCNVQ456GANH60D89REYKDNGSMTJ6YW3NHVQ9QYYSSQJCEWM5CJWZ4A6RFJX77C490YCED6PEMK0UPKXHY89CMM7SCT66K8GNEANWYKZGDRWRFJE69H9U5U0W57RRCSYSAS7GADWMZXC8C6T0SPJAZUP6');
  });

  test('test lightning invoice encode', () {
    final encoded = bip21.encode(Bip21Uri(
      address: 'BC1QYLH3U67J673H6Y6ALV70M0PL2YZ53TZHVXGG7U',
      amount: 0.00001,
      label: 'sbddesign: For lunch Tuesday',
      message: 'For lunch Tuesday',
      options: {
        'lightning':
            'LNBC10U1P3PJ257PP5YZTKWJCZ5FTL5LAXKAV23ZMZEKAW37ZK6KMV80PK4XAEV5QHTZ7QDPDWD3XGER9WD5KWM36YPRX7U3QD36KUCMGYP282ETNV3SHJCQZPGXQYZ5VQSP5USYC4LK9CHSFP53KVCNVQ456GANH60D89REYKDNGSMTJ6YW3NHVQ9QYYSSQJCEWM5CJWZ4A6RFJX77C490YCED6PEMK0UPKXHY89CMM7SCT66K8GNEANWYKZGDRWRFJE69H9U5U0W57RRCSYSAS7GADWMZXC8C6T0SPJAZUP6',
      },
    ));

    final expectedUri =
        'bitcoin:BC1QYLH3U67J673H6Y6ALV70M0PL2YZ53TZHVXGG7U?amount=0.00001&label=sbddesign%3A%20For%20lunch%20Tuesday&message=For%20lunch%20Tuesday&lightning=LNBC10U1P3PJ257PP5YZTKWJCZ5FTL5LAXKAV23ZMZEKAW37ZK6KMV80PK4XAEV5QHTZ7QDPDWD3XGER9WD5KWM36YPRX7U3QD36KUCMGYP282ETNV3SHJCQZPGXQYZ5VQSP5USYC4LK9CHSFP53KVCNVQ456GANH60D89REYKDNGSMTJ6YW3NHVQ9QYYSSQJCEWM5CJWZ4A6RFJX77C490YCED6PEMK0UPKXHY89CMM7SCT66K8GNEANWYKZGDRWRFJE69H9U5U0W57RRCSYSAS7GADWMZXC8C6T0SPJAZUP6';
    expect(encoded, expectedUri);
  });

  test('test lightning invoice convenience methods', () {
    // Test URI with lightning invoice
    final uriWithLightning = bip21.decode(
        'bitcoin:BC1QYLH3U67J673H6Y6ALV70M0PL2YZ53TZHVXGG7U?lightning=LNBC10U1P3PJ257PP5YZTKWJCZ5FTL5LAXKAV23ZMZEKAW37ZK6KMV80PK4XAEV5QHTZ7QDPDWD3XGER9WD5KWM36YPRX7U3QD36KUCMGYP282ETNV3SHJCQZPGXQYZ5VQSP5USYC4LK9CHSFP53KVCNVQ456GANH60D89REYKDNGSMTJ6YW3NHVQ9QYYSSQJCEWM5CJWZ4A6RFJX77C490YCED6PEMK0UPKXHY89CMM7SCT66K8GNEANWYKZGDRWRFJE69H9U5U0W57RRCSYSAS7GADWMZXC8C6T0SPJAZUP6');

    expect(uriWithLightning.hasLightningInvoice, true);
    expect(uriWithLightning.lightningInvoice, startsWith('LNBC'));
    expect(uriWithLightning.hasValidLightningInvoice, true);

    // Test URI without lightning invoice
    final uriWithoutLightning =
        bip21.decode('bitcoin:BC1QYLH3U67J673H6Y6ALV70M0PL2YZ53TZHVXGG7U');

    expect(uriWithoutLightning.hasLightningInvoice, false);
    expect(uriWithoutLightning.lightningInvoice, null);
    expect(uriWithoutLightning.hasValidLightningInvoice, false);
  });
}
