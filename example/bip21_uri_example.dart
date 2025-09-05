import 'package:bip21_uri/bip21_uri.dart';

/// Example demonstrating BIP21 URI encoding and decoding
void main() {
  // Decode a BIP21 URI
  Bip21Uri decoded = bip21.decode(
      'bitcoin:1BgGZ9tcN4rm9KBzDn7KprQz87SZ26SAMH?amount=20.3&label=Foobar');

  print('Decoded URI:');
  print({
    "address": decoded.address,
    "amount": decoded.amount,
    "label": decoded.label,
  });

  // Encode a simple BIP21 URI
  print('\nEncoded simple URI:');
  print(bip21.encode(Bip21Uri(address: '1BgGZ9tcN4rm9KBzDn7KprQz87SZ26SAMH')));
  // => bitcoin:1BgGZ9tcN4rm9KBzDn7KprQz87SZ26SAMH

  // Encode a complex BIP21 URI with all parameters
  print('\nEncoded complex URI:');
  print(
    bip21.encode(
      Bip21Uri(
        address: '1BgGZ9tcN4rm9KBzDn7KprQz87SZ26SAMH',
        scheme: 'bitcoin',
        amount: 20.3,
        label: 'Foobar',
        message: 'Hello, world!',
        options: {
          'payjoin': 'true',
          'pj':
              'HTTPS://PAYJO.IN/TXJCGKTKXLUUZ%23EX1WKV8CEC-OH1QYPM59NK2LXXS4890SUAXXYT25Z2VAPHP0X7YEYCJXGWAG6UG9ZU6NQ-RK1Q0DJS3VVDXWQQTLQ8022QGXSX7ML9PHZ6EDSF6AKEWQG758JPS2EV'
        },
      ),
    ),
  );
  // => bitcoin:1BgGZ9tcN4rm9KBzDn7KprQz87SZ26SAMH?amount=20.3&label=Foobar&message=Hello%2C+world%21&payjoin=true

  // Re-encode the decoded URI
  print('\nRe-encoded decoded URI:');
  print(bip21.encode(decoded));

  // Lightning Invoice Example
  print('\n=== Lightning Invoice Example ===');

  // Decode a BIP21 URI with BOLT 11 Lightning Invoice
  final lightningUri =
      'bitcoin:BC1QYLH3U67J673H6Y6ALV70M0PL2YZ53TZHVXGG7U?amount=0.00001&label=sbddesign%3A%20For%20lunch%20Tuesday&message=For%20lunch%20Tuesday&lightning=LNBC10U1P3PJ257PP5YZTKWJCZ5FTL5LAXKAV23ZMZEKAW37ZK6KMV80PK4XAEV5QHTZ7QDPDWD3XGER9WD5KWM36YPRX7U3QD36KUCMGYP282ETNV3SHJCQZPGXQYZ5VQSP5USYC4LK9CHSFP53KVCNVQ456GANH60D89REYKDNGSMTJ6YW3NHVQ9QYYSSQJCEWM5CJWZ4A6RFJX77C490YCED6PEMK0UPKXHY89CMM7SCT66K8GNEANWYKZGDRWRFJE69H9U5U0W57RRCSYSAS7GADWMZXC8C6T0SPJAZUP6';

  final lightningDecoded = bip21.decode(lightningUri);

  print('Lightning URI Details:');
  print({
    "address": lightningDecoded.address,
    "amount": lightningDecoded.amount,
    "label": lightningDecoded.label,
    "message": lightningDecoded.message,
    "hasLightning": lightningDecoded.hasLightningInvoice,
    "lightningInvoice":
        '${lightningDecoded.lightningInvoice?.substring(0, 20) ?? ''}...',
    "isValidLightning": lightningDecoded.hasValidLightningInvoice
  });

  // Create a new URI with Lightning Invoice
  print('\nCreating URI with Lightning Invoice:');
  final newLightningUri = bip21.encode(Bip21Uri(
    address: '1A1zP1eP5QGefi2DMPTfTL5SLmv7DivfNa',
    amount: 0.001,
    label: 'Lightning Payment',
    message: 'Pay via Lightning Network',
    options: {
      'lightning': 'LNBC1M1P3PJ257PP5EXAMPLE...',
    },
  ));

  print(newLightningUri);
}
