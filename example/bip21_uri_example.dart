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
        options: {'payjoin': 'true'},
      ),
    ),
  );
  // => bitcoin:1BgGZ9tcN4rm9KBzDn7KprQz87SZ26SAMH?amount=20.3&label=Foobar&message=Hello%2C+world%21&payjoin=true

  // Re-encode the decoded URI
  print('\nRe-encoded decoded URI:');
  print(bip21.encode(decoded));
}
