//  "qchar" corresponds to valid characters of an RFC 3986 URI query component, excluding the "=" and "&" characters, which this BIP takes as separators.
bool isValidString(String input) {
  return !input.contains('=') && !input.contains('&');
}

bool isValidAmount(double amount) {
  try {
    return amount.isFinite && amount >= 0;
  } catch (_) {
    return false;
  }
}

String encodeParam(String input) => Uri.encodeComponent(input);

String decodeParam(String input) => Uri.decodeComponent(input);
