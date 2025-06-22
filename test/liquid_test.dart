import 'package:bip21_uri/bip21_uri.dart';
import 'package:test/test.dart';

void main() {
  test('liquid', () {
    const scheme = 'liquidnetwork';
    const address =
        'lq1qq0r7uz2f8csrfnr2a4pseszaugm4fefuf6kr0sw0vpk4p5uvfe9yvtg8w8ayllvg7hd39dk6wsma6jvcwyd8sfyk485w25282';
    const uri =
        '$scheme:$address?amount=0.05&label=ethicnology&message=Liquid%20Bip21';
    final decode = bip21.decode(uri, 'liquidnetwork');

    expect(decode.urnScheme, scheme);
    expect(decode.address, address);
    expect(decode.options['amount'], 0.05);
    expect(decode.options['label'], 'ethicnology');
    expect(decode.options['message'], 'Liquid Bip21');
  });
}
