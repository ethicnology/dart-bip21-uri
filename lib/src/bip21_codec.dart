import 'dart:convert';
import 'package:bip21_uri/bip21_uri.dart';

/// The canonical instance of [BIP21Codec].
const bip21 = BIP21Codec();

/// A codec that converts [Bip21Uri]'s to [String] or [String]'s to [Bip21Uri].
///
/// Reference: https://github.com/bitcoin/bips/blob/master/bip-0021.mediawiki
class BIP21Codec extends Codec<Bip21Uri, String> {
  const BIP21Codec();

  @override
  BIP21Decoder get decoder => bip21Decoder;

  @override
  BIP21Encoder get encoder => bip21Encoder;

  @override
  Bip21Uri decode(String encoded) => decoder.convert(encoded);

  @override
  String encode(Bip21Uri input) => encoder.convert(input);
}
