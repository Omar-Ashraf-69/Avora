// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "already_have_an_account": MessageLookupByLibrary.simpleMessage(
      "Already have an account?",
    ),
    "code_has_been_sent_to": MessageLookupByLibrary.simpleMessage(
      "Code has been sent to ",
    ),
    "create_an_account": MessageLookupByLibrary.simpleMessage(
      "Create an account",
    ),
    "dont_have_an_account": MessageLookupByLibrary.simpleMessage(
      "Don\'t have an account?",
    ),
    "enter_your_phone_number": MessageLookupByLibrary.simpleMessage(
      "Enter your phone number",
    ),
    "login": MessageLookupByLibrary.simpleMessage("Login"),
    "login_into_your_account": MessageLookupByLibrary.simpleMessage(
      "Login into your account",
    ),
    "otp_code_verification": MessageLookupByLibrary.simpleMessage(
      "OTP Code Verification",
    ),
    "resend_code_in": MessageLookupByLibrary.simpleMessage("Resend Code in "),
    "sign_up": MessageLookupByLibrary.simpleMessage("Sign Up"),
    "verify": MessageLookupByLibrary.simpleMessage("Verify"),
  };
}
