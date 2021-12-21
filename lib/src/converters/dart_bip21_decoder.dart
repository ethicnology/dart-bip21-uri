import 'dart:convert';
import 'dart:core';

import 'package:dart_bip21/src/models/bip21.dart';

/// The canonical instance of [BIP21Decoder].
const bip21Decoder = BIP21Decoder();

/// BIP21 Decoder
///
/// A converter that encodes [String] to [BIP21].
class BIP21Decoder extends Converter<String, BIP21> {
  const BIP21Decoder();

  @override
  BIP21 convert(String input, [String urnScheme = 'bitcoin']) {
    String urnSchemeActual = input.substring(0, urnScheme.length).toLowerCase();
    if (urnSchemeActual != urnScheme || input[urnScheme.length] != ':') {
      throw Exception('Invalid BIP21 URI: $input');
    }
    int split = input.indexOf('?');
    String? address =
        input.substring(urnScheme.length + 1, split == -1 ? null : split);
    String query = split == -1 ? '' : input.substring(split + 1);
    Map<String, dynamic> options =
        Map<String, dynamic>.from(Uri.splitQueryString(query));

    if (options.containsKey('amount')) {
      num? amount = num.tryParse(options['amount'].toString());
      if (amount == null) {
        throw FormatException('Invalid amount');
      }
      if (!amount.isFinite) throw FormatException('Invalid amount');
      if (amount < 0) throw FormatException('Invalid amount');
      options['amount'] = amount;
    }

    return BIP21(address, options);
  }
}
