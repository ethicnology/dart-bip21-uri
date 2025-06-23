import 'dart:convert';
import 'dart:core';

import 'package:bip21_uri/src/bip21_uri_model.dart';
import 'package:bip21_uri/utils.dart';

/// The canonical instance of [BIP21Encoder].
const bip21Encoder = BIP21Encoder();

/// BIP21 Encoder
///
/// A converter that encodes [Bip21Uri] to [String].
class BIP21Encoder extends Converter<Bip21Uri, String> {
  const BIP21Encoder();

  @override
  String convert(Bip21Uri input) {
    final options = Map<String, dynamic>.from(input.options).map(
      (key, value) => MapEntry(
        encodeParam(key),
        encodeParam(value.toString()),
      ),
    );

    String query = options.keys.map((key) => '$key=${options[key]}').join('&');

    final params = [
      if (input.amount != null) 'amount=${input.amount}',
      if (input.label != null) 'label=${encodeParam(input.label!)}',
      if (input.message != null) 'message=${encodeParam(input.message!)}',
      if (options.keys.isNotEmpty) query
    ];

    return [
      '${input.scheme}:${input.address}',
      if (params.isNotEmpty) '?${params.join('&')}',
    ].join('');
  }
}
