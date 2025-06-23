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
        options: {'payjoin': true},
      ),
    ),
  );

  print(bip21.encode(decoded));

  /// => bitcoin:1BgGZ9tcN4rm9KBzDn7KprQz87SZ26SAMH?amount=20.3&label=Foobar&message=Hello%2C+world%21&payjoin=true
}
