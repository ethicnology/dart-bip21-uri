import 'package:bip21_uri/bip21_uri.dart';
import 'package:test/test.dart';

void main() {
  final plusPayjoinUri =
      'HTTPS://PAYJO.IN/TXJCGKTKXLUUZ%23EX1WKV8CEC+OH1QYPM59NK2LXXS4890SUAXXYT25Z2VAPHP0X7YEYCJXGWAG6UG9ZU6NQ+RK1Q0DJS3VVDXWQQTLQ8022QGXSX7ML9PHZ6EDSF6AKEWQG758JPS2EV';
  final minusPayjoinUri =
      'HTTPS://PAYJO.IN/TXJCGKTKXLUUZ%23EX1WKV8CEC-OH1QYPM59NK2LXXS4890SUAXXYT25Z2VAPHP0X7YEYCJXGWAG6UG9ZU6NQ-RK1Q0DJS3VVDXWQQTLQ8022QGXSX7ML9PHZ6EDSF6AKEWQG758JPS2EV';
  final percentPayjoinUri =
      'HTTPS%3A%2F%2FPAYJO.IN%2FTXJCGKTKXLUUZ%2523EX1WKV8CEC-OH1QYPM59NK2LXXS4890SUAXXYT25Z2VAPHP0X7YEYCJXGWAG6UG9ZU6NQ-RK1Q0DJS3VVDXWQQTLQ8022QGXSX7ML9PHZ6EDSF6AKEWQG758JPS2EV';

  final valids = [
    'bitcoin:tb1q6q6de88mj8qkg0q5lupmpfexwnqjsr4d2gvx2p?amount=0.00666666&pjos=0&pj=$plusPayjoinUri',
    'bitcoin:tb1q6q6de88mj8qkg0q5lupmpfexwnqjsr4d2gvx2p?amount=0.00666666&pjos=0&pj=$minusPayjoinUri',
    'bitcoin:tb1q6q6de88mj8qkg0q5lupmpfexwnqjsr4d2gvx2p?amount=0.00666666&pjos=0&pj=$percentPayjoinUri'
  ];

  test('payjoin', () {
    for (final payload in valids) {
      final uri = bip21.decode(payload);
      expect(uri.options['pj'], equals(minusPayjoinUri));
    }
  });
}
