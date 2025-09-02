import 'dart:convert';
import 'dart:core';

import 'package:bip21_uri/src/bip21_uri_model.dart';

/// The canonical instance of [BIP21Decoder].
const bip21Decoder = BIP21Decoder();

/// BIP21 Decoder
///
/// A converter that encodes [String] to [Bip21Uri].
class BIP21Decoder extends Converter<String, Bip21Uri> {
  const BIP21Decoder();

  @override
  Bip21Uri convert(String input) {
    final semiSplit = input.split(':');
    final scheme = semiSplit.first;

    Map<String, dynamic> options = {};
    final questionSplit = input.split('?');
    String address = questionSplit.first.replaceAll('$scheme:', '');
    if (!input.contains('?')) {
      address = semiSplit.last;
    } else {
      String query = questionSplit.last;
      options = Map<String, dynamic>.from(Uri.splitQueryString(query));
    }

    if (options['pj'] != null) {
      final pj = options['pj']!
          .replaceAll(' ', '+')
          .replaceAll('-', '+')
          .replaceAll('#', '%23');
      options['pj'] = pj.toUpperCase();
    }

    double? amount;
    if (options['amount'] != null && options['amount']!.isNotEmpty) {
      try {
        amount = double.parse(options['amount']!);
      } catch (_) {
        throw 'Invalid amount';
      }
    }

    String? label = options['label'];

    String? message = options['message'];

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
