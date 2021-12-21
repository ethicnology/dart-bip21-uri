import 'dart:convert';
import 'dart:core';

import 'package:dart_bip21/src/models/bip21.dart';

/// The canonical instance of [BIP21Encoder].
const bip21Encoder = BIP21Encoder();

/// BIP21 Encoder
///
/// A converter that encodes [BIP21] to [String].
class BIP21Encoder extends Converter<BIP21, String> {
  const BIP21Encoder();

  @override
  String convert(BIP21 input) {
    Map<String, dynamic> options = Map<String, dynamic>.from(input.options).map(
        (key, value) => MapEntry(Uri.encodeQueryComponent(key),
            value is num ? value : Uri.encodeQueryComponent(value)));
    if (options['amount'] != null) {
      num? amount = num.tryParse(options['amount'].toString());
      if (amount == null || !amount.isFinite || amount < 0) {
        throw FormatException('Invalid amount');
      }
    }

    String query = options.keys.map((key) => '$key=${options[key]}').join('&');

    return [
      input.urnScheme,
      ':',
      input.address,
      options.keys.isNotEmpty ? '?' : '',
      query
    ].join('');
  }
}
