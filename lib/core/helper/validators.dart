import 'package:avora/core/funcs/phone_formater.dart';
import 'package:avora/core/helper/app_regex.dart';
import 'package:avora/generated/l10n.dart';

class AppValidators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty || !AppRegex.isEmailValid(value)) {
      return S.current.please_enter_a_valid_email;
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      !AppRegex.isPasswordValid(value!);
      return S.current.please_enter_a_valid_password;
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return S.current.please_enter_a_valid_name;
    }
    return null;
  }


  static String? validatePhone(String? value) {
    final phoneNumber = value?.trim() ?? '';

    if (phoneNumber.isEmpty) {
      return 'Enter a phone number';
    }

    if (!PhoneNumberFormatter.isValidEgyptianPhone(phoneNumber)) {
      return 'Enter a valid Egyptian phone number';
    }

    return null;
  }

  static String? validateUsername(String? value) {
    var username = value?.trim() ?? '';

    if (username.isEmpty) {
      return 'Enter a username';
    }

    // Allow the user to type @username.
    username = username.replaceFirst('@', '');

    final validPattern = RegExp(r'^[a-zA-Z0-9_.]{2,30}$');

    if (!validPattern.hasMatch(username)) {
      return 'Username must be 2-30 characters';
    }

    return null;
  }

}
