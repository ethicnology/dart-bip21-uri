[![codecov](https://codecov.io/github/ethicnology/dart-bip21-uri/branch/main/graph/badge.svg?token=Q0JQ1O8S84)](https://codecov.io/github/ethicnology/dart-bip21-uri)


# dart-bip21-uri

A [BIP21](https://github.com/bitcoin/bips/blob/master/bip-0021.mediawiki) compatible URL encoding package developed for DartLang.

Supports standard BIP21 URIs and BIP21 URIs with BOLT 11 Lightning Network invoices.

## Example

``` dart
import 'package:bip21_uri/bip21_uri.dart';

void main() {
  // Basic BIP21 URI decoding
  Bip21Uri decoded = bip21.decode(
      'bitcoin:1BgGZ9tcN4rm9KBzDn7KprQz87SZ26SAMH?amount=20.3&label=Foobar');
      
  print({
    "address": decoded.address,
    "amount": decoded.amount,
    "label": decoded.label,
  });

  // Simple encoding
  print(bip21.encode(Bip21Uri(address: '1BgGZ9tcN4rm9KBzDn7KprQz87SZ26SAMH')));
  /// => bitcoin:1BgGZ9tcN4rm9KBzDn7KprQz87SZ26SAMH

  // Complex encoding with PayJoin
  print(
    bip21.encode(
      Bip21Uri(
        address: '1BgGZ9tcN4rm9KBzDn7KprQz87SZ26SAMH',
        scheme: 'bitcoin',
        amount: 20.3,
        label: 'Foobar',
        message: 'Hello, world!',
        options: {'payjoin': true, 'pj': 'HTTPS://PAYJO.IN/TXJCGKTKXLUUZ%23EX1WKV8CEC-OH1QYPM59NK2LXXS4890SUAXXYT25Z2VAPHP0X7YEYCJXGWAG6UG9ZU6NQ-RK1Q0DJS3VVDXWQQTLQ8022QGXSX7ML9PHZ6EDSF6AKEWQG758JPS2EV'},
      ),
    ),
  );

  print(bip21.encode(decoded));
  /// => bitcoin:1BgGZ9tcN4rm9KBzDn7KprQz87SZ26SAMH?amount=20.3&label=Foobar&message=Hello%2C+world%21&payjoin=true

  // Lightning Invoice Example - BIP21 URI with BOLT 11 Lightning Invoice
  final lightningUri = 'bitcoin:BC1QYLH3U67J673H6Y6ALV70M0PL2YZ53TZHVXGG7U?amount=0.00001&label=sbddesign%3A%20For%20lunch%20Tuesday&message=For%20lunch%20Tuesday&lightning=LNBC10U1P3PJ257PP5YZTKWJCZ5FTL5LAXKAV23ZMZEKAW37ZK6KMV80PK4XAEV5QHTZ7QDPDWD3XGER9WD5KWM36YPRX7U3QD36KUCMGYP282ETNV3SHJCQZPGXQYZ5VQSP5USYC4LK9CHSFP53KVCNVQ456GANH60D89REYKDNGSMTJ6YW3NHVQ9QYYSSQJCEWM5CJWZ4A6RFJX77C490YCED6PEMK0UPKXHY89CMM7SCT66K8GNEANWYKZGDRWRFJE69H9U5U0W57RRCSYSAS7GADWMZXC8C6T0SPJAZUP6';
  
  final lightningDecoded = bip21.decode(lightningUri);
  
  print('Lightning URI Details:');
  print({
    "address": lightningDecoded.address,
    "amount": lightningDecoded.amount,
    "hasLightning": lightningDecoded.hasLightningInvoice,
    "lightningInvoice": lightningDecoded.lightningInvoice?.substring(0, 20) + '...',
    "isValidLightning": lightningDecoded.hasValidLightningInvoice
  });

  // Create new URI with Lightning Invoice
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
  /// => bitcoin:1A1zP1eP5QGefi2DMPTfTL5SLmv7DivfNa?amount=0.001&label=Lightning%20Payment&message=Pay%20via%20Lightning%20Network&lightning=LNBC1M1P3PJ257PP5EXAMPLE...
}
```


## Features

- ✅ Standard BIP21 URI support
- ✅ BOLT 11 Lightning Network invoice support
- ✅ PayJoin (BIP78) URI support  
- ✅ Custom scheme support (bitcoin, liquidnetwork, etc.)
- ✅ URL encoding/decoding
- ✅ Comprehensive validation
- ✅ Convenience methods for lightning invoices

## Lightning Invoice Support

This library supports BIP21 URIs with BOLT 11 Lightning Network invoices through the `lightning` parameter:

```dart
// Parse a BIP21 URI with Lightning invoice
final uri = 'bitcoin:address?lightning=LNBC10U1P3PJ257PP5...';
final decoded = bip21.decode(uri);

// Check if URI contains lightning invoice
if (decoded.hasLightningInvoice) {
  print('Lightning invoice: ${decoded.lightningInvoice}');
  print('Is valid: ${decoded.hasValidLightningInvoice}');
}
```

## License [MIT](LICENSE)