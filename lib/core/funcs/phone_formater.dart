class PhoneNumberFormatter {
  PhoneNumberFormatter._();

  static const _egyptianPrefixes = {'10', '11', '12', '15'};

  static bool isValidEgyptianPhone(String phone) {
    var value = phone.trim().replaceAll(RegExp(r'[\s-]'), '');

    // 010XXXXXXXX
    if (value.startsWith('0')) {
      return value.length == 11 && RegExp(r'^01[0125]\d{8}$').hasMatch(value);
    }
    // +2010XXXXXXXX
    if (value.startsWith('+20')) {
      value = value.substring(3);
    }
    // 2010XXXXXXXX
    else if (value.startsWith('20')) {
      value = value.substring(2);
    }
    // No valid Egyptian country code.
    else {
      if (value.length != 10) {
        return false;
      }
    }

    return value.length == 10 &&
        _egyptianPrefixes.contains(value.substring(0, 2)) &&
        RegExp(r'^\d{10}$').hasMatch(value);
  }

  static String normalizeEgyptianPhone(String phone) {
    var value = phone.trim().replaceAll(RegExp(r'[\s-]'), '');

    if (!isValidEgyptianPhone(value)) {
      throw const FormatException('Invalid Egyptian phone number');
    }

    if (value.startsWith('+20')) {
      return value;
    }

    if (value.startsWith('20')) {
      return '+$value';
    }

    // 010XXXXXXXX -> +2010XXXXXXXX
    if (value.startsWith('0')) {
      return '+20${value.substring(1)}';
    }

    // 10XXXXXXXX -> +2010XXXXXXXX
    return '+20$value';
  }
}
