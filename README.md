# dart-bip21

A [BIP21](https://github.com/bitcoin/bips/blob/master/bip-0021.mediawiki) compatible URL encoding package developed for DartLang.

## Example

``` dart
import 'package:dart_bip21/dart_bip21.dart';

void main() {
  BIP21 decoded = bip21.decode(
      'bitcoin:1BgGZ9tcN4rm9KBzDn7KprQz87SZ26SAMH?amount=20.3&label=Foobar');
  print({
    "address": decoded.address,
    "options": decoded.options,
  });

  /// => {address: 1BgGZ9tcN4rm9KBzDn7KprQz87SZ26SAMH, options: {amount: 20.3, label: Foobar}}

  print(bip21.tryEncode('1BgGZ9tcN4rm9KBzDn7KprQz87SZ26SAMH'));

  /// => bitcoin:1BgGZ9tcN4rm9KBzDn7KprQz87SZ26SAMH
  print(bip21.tryEncode('1BgGZ9tcN4rm9KBzDn7KprQz87SZ26SAMH',
      {"amount": 20.3, "label": 'Foobar'}));

  /// => bitcoin:1BgGZ9tcN4rm9KBzDn7KprQz87SZ26SAMH?amount=20.3&label=Foobar

  print(bip21.encode(decoded));
  /// => bitcoin:1BgGZ9tcN4rm9KBzDn7KprQz87SZ26SAMH?amount=20.3&label=Foobar
}
```


## License [MIT](LICENSE)