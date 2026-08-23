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
}
