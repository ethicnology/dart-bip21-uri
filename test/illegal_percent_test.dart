import 'package:bip21_uri/bip21_uri.dart';
import 'package:test/test.dart';

void main() {
  test('illegal percent encoding', () {
    final uri = bip21.decode(
        'bitcoin:bc1qdzdufdc6jpacf3t6su7qtaz3g4wlm0pddnrwr4?amount=0.00269981&label=%E2%82%BF%20on%20Lille&message=Order%209XWGG&lightning=lnbc2699810n1p5ttd8tpp504l7fyswkzqgh3ev7q3u9y9rmwu43nv5uuvdzzeqxlpuk8y6r4nqdq5u2pt7gr0dcsyc6tvd3jscqzzsxqzjcsp5qw6nhlue4cl29c98c4zac8yu0ygp06wygu905jyuxyxn8qfty22q9qxpqysgqheum38mmqf8fr2kcx7h6lpq2k97ek5pqtx4wa6w6ceyay32qmc95am6xgp8fm5zka6dgfc93hpmhm9243ky68av226f0302yjfesatgqrp4tgc');
    expect(uri.label, equals('₿ on Lille'));
    expect(uri.message, equals('Order 9XWGG'));
  });
}
