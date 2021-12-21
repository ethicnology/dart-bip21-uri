import 'package:dart_bip21/dart_bip21.dart';

/// BIP21 Model
class BIP21 {
  String urnScheme;

  /// Address
  String address;

  /// Query Options
  Map<String, dynamic> options;

  BIP21(this.address, this.options, [this.urnScheme = 'bitcoin']);

  @override
  String toString() {
    return bip21.encode(this);
  }
}
