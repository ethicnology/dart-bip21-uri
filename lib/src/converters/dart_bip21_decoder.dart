import 'dart:convert';
import 'dart:core';

import 'package:bip21_uri/src/bip21_uri_model.dart';
import 'package:bip21_uri/utils.dart';

/// The canonical instance of [BIP21Decoder].
const bip21Decoder = BIP21Decoder();

/// BIP21 Decoder
///
/// A converter that encodes [String] to [Bip21Uri].
class BIP21Decoder extends Converter<String, Bip21Uri> {
  const BIP21Decoder();

  @override
  Bip21Uri convert(String input) {
    final parts = input.split(':');
    final scheme = parts.first.toLowerCase();

    Map<String, dynamic> options = {};
    String address = parts.last.split('?').first;
    if (!input.contains('?')) {
      address = parts.last;
    } else {
      String query = parts.last.split('?').last;
      options = Map<String, dynamic>.from(Uri.splitQueryString(query));

      // Remove empty values
      options.removeWhere((key, value) => value == '');
    }

    double? amount;
    if (options['amount'] != null) {
      try {
        amount = double.parse(options['amount']!);
      } catch (_) {
        throw 'Invalid amount';
      }
    }

    String? label;
    if (options.containsKey('label') && options['label']!.isNotEmpty) {
      label = decodeParam(options['label']!);
    }

    String? message;
    if (options.containsKey('message') && options['message']!.isNotEmpty) {
      message = decodeParam(options['message']!);
    }

    // Remove amount, label, and message from options
    options.removeWhere(
      (key, value) => ['amount', 'label', 'message'].contains(key),
    );

    return Bip21Uri(
      scheme: scheme,
      address: address,
      amount: amount,
      label: label,
      message: message,
      options: options,
    );
  }
}
