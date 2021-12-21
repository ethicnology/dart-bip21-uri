import 'dart:convert';

import 'package:dart_bip21/src/converters/api.dart';

import 'models/bip21.dart';

export 'models/bip21.dart' show BIP21;

/// The canonical instance of [BIP21Codec].
const bip21 = BIP21Codec();

/// A codec that converts [BIP21]'s to [String] or [String]'s to [BIP21].
///
/// Reference: https://github.com/bitcoin/bips/blob/master/bip-0021.mediawiki
class BIP21Codec extends Codec<BIP21, String> {
  const BIP21Codec();

  @override
  BIP21Decoder get decoder => bip21Decoder;

  @override
  BIP21Encoder get encoder => bip21Encoder;

  @override
  BIP21 decode(String encoded, [String urnScheme = 'bitcoin']) {
    return decoder.convert(encoded, urnScheme);
  }

  @override
  String encode(BIP21 input) {
    return encoder.convert(input);
  }

  String tryEncode(String address,
      [Map<String, dynamic>? options, String urnScheme = 'bitcoin']) {
    return encode(BIP21(address, options ?? <String, dynamic>{}, urnScheme));
  }
}
