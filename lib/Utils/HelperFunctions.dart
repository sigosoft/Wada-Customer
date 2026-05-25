int getPhoneNumberLength(String? countryCode) {
  if (countryCode == null) return 10;
  final code = countryCode.replaceAll('+', '').trim();
  switch (code) {
    case '91': // India
      return 10;
    case '971': // UAE
      return 9;
    case '966': // Saudi Arabia
      return 9;
    case '965': // Kuwait
      return 8;
    case '968': // Oman
      return 8;
    case '973': // Bahrain
      return 8;
    case '974': // Qatar
      return 8;
    default:
      return 10; // Default fallback
  }
}

String? validatePhoneNumber(String? value, String? countryCode) {
  if (value == null || value.trim().isEmpty) {
    return "Please enter your phone number";
  }
  final expectedLength = getPhoneNumberLength(countryCode);
  if (value.length < expectedLength) {
    return "Phone number must be $expectedLength digits";
  }
  return null;
}
