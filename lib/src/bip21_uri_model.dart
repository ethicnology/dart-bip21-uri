import 'package:bip21_uri/bip21_uri.dart';
import 'package:bip21_uri/utils.dart';

/// BIP21 Model
class Bip21Uri {
  final String scheme;

  /// Address
  final String address;

  /// Address
  final double? amount;

  /// Label
  final String? label;

  /// Message
  final String? message;

  /// Query Options
  final Map<String, dynamic> options;

  Bip21Uri({
    required this.address,
    this.options = const {},
    this.scheme = 'bitcoin',
    this.amount,
    this.label,
    this.message,
  }) {
    if (scheme.isEmpty) throw 'Scheme cannot be empty';

    if (address.isEmpty) throw 'Address cannot be empty';

    if (amount != null && !isValidAmount(amount!)) throw 'Invalid amount';

    if (label != null && !isValidString(label!)) throw 'Invalid label';

    if (message != null && !isValidString(message!)) throw 'Invalid message';

    if (options.isNotEmpty) {
      for (final key in options.keys) {
        final value = options[key].toString();
        if (!isValidString(key)) throw 'Invalid option key: $key';
        if (!isValidString(value)) throw 'Invalid option value: $value';
      }
    }
  }

  @override
  String toString() => bip21.encode(this);
}
