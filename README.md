[![codecov](https://codecov.io/github/ethicnology/dart-bip21-uri/branch/main/graph/badge.svg?token=Q0JQ1O8S84)](https://codecov.io/github/ethicnology/dart-bip21-uri)


# dart-bip21-uri

A [BIP21](https://github.com/bitcoin/bips/blob/master/bip-0021.mediawiki) compatible URL encoding package developed for DartLang.

## Example

``` dart
import 'package:bip21_uri/bip21_uri.dart';

void main() {
  Bip21Uri decoded = bip21.decode(
      'bitcoin:1BgGZ9tcN4rm9KBzDn7KprQz87SZ26SAMH?amount=20.3&label=Foobar');
      
  print({
    "address": decoded.address,
    "amount": decoded.amount,
    "label": decoded.label,
  });

  print(bip21.encode(Bip21Uri(address: '1BgGZ9tcN4rm9KBzDn7KprQz87SZ26SAMH')));

  /// => bitcoin:1BgGZ9tcN4rm9KBzDn7KprQz87SZ26SAMH

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
}

```


## License [MIT](LICENSE)