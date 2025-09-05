import 'package:bip21_uri/bip21_uri.dart';

void main() {
  // Test the lightning invoice example
  final uri =
      'bitcoin:BC1QYLH3U67J673H6Y6ALV70M0PL2YZ53TZHVXGG7U?amount=0.00001&label=sbddesign%3A%20For%20lunch%20Tuesday&message=For%20lunch%20Tuesday&lightning=LNBC10U1P3PJ257PP5YZTKWJCZ5FTL5LAXKAV23ZMZEKAW37ZK6KMV80PK4XAEV5QHTZ7QDPDWD3XGER9WD5KWM36YPRX7U3QD36KUCMGYP282ETNV3SHJCQZPGXQYZ5VQSP5USYC4LK9CHSFP53KVCNVQ456GANH60D89REYKDNGSMTJ6YW3NHVQ9QYYSSQJCEWM5CJWZ4A6RFJX77C490YCED6PEMK0UPKXHY89CMM7SCT66K8GNEANWYKZGDRWRFJE69H9U5U0W57RRCSYSAS7GADWMZXC8C6T0SPJAZUP6';

  try {
    print('=== BIP21 URI with BOLT 11 Lightning Invoice Example ===\n');

    final decoded = bip21.decode(uri);

    print('Original URI: $uri\n');
    print('Parsed Components:');
    print('  Scheme: ${decoded.scheme}');
    print('  Address: ${decoded.address}');
    print('  Amount: ${decoded.amount} BTC');
    print('  Label: ${decoded.label}');
    print('  Message: ${decoded.message}');
    print('  Lightning Invoice: ${decoded.options['lightning']}\n');

    // Test convenience methods
    print('Lightning Invoice Support:');
    print('  Has Lightning Invoice: ${decoded.hasLightningInvoice}');
    print(
        '  Lightning Invoice: ${decoded.lightningInvoice?.substring(0, 20)}...');
    print(
        '  Is Valid Lightning Invoice: ${decoded.hasValidLightningInvoice}\n');

    // Test encoding back to URI
    final encoded = bip21.encode(decoded);
    print('Encoded back to URI: $encoded\n');
    print('Round-trip successful: ${uri == encoded}\n');

    // Demonstrate creating a new BIP21 URI with lightning invoice
    print('=== Creating new BIP21 URI with Lightning Invoice ===\n');

    final newUri = bip21.encode(Bip21Uri(
      address: '1A1zP1eP5QGefi2DMPTfTL5SLmv7DivfNa',
      amount: 0.0001,
      label: 'Test Payment',
      message: 'Payment for testing lightning invoice',
      options: {
        'lightning': 'LNBC1000N1P3PJ257PP5TEST...',
        'pj': 'https://example.com/payjoin',
      },
    ));

    print('New URI: $newUri');

    final decodedNew = bip21.decode(newUri);
    print('Has Lightning: ${decodedNew.hasLightningInvoice}');
    print('Lightning Invoice: ${decodedNew.lightningInvoice}');
    print('PayJoin URL: ${decodedNew.options['pj']}');
  } catch (e) {
    print('Error: $e');
  }
}
