// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Enter your phone number`
  String get enter_your_phone_number {
    return Intl.message(
      'Enter your phone number',
      name: 'enter_your_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Login into your account`
  String get login_into_your_account {
    return Intl.message(
      'Login into your account',
      name: 'login_into_your_account',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Don't have an account?`
  String get dont_have_an_account {
    return Intl.message(
      'Don\'t have an account?',
      name: 'dont_have_an_account',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get sign_up {
    return Intl.message('Sign Up', name: 'sign_up', desc: '', args: []);
  }

  /// `Already have an account?`
  String get already_have_an_account {
    return Intl.message(
      'Already have an account?',
      name: 'already_have_an_account',
      desc: '',
      args: [],
    );
  }

  /// `Create an account`
  String get create_an_account {
    return Intl.message(
      'Create an account',
      name: 'create_an_account',
      desc: '',
      args: [],
    );
  }

  /// `OTP Code Verification`
  String get otp_code_verification {
    return Intl.message(
      'OTP Code Verification',
      name: 'otp_code_verification',
      desc: '',
      args: [],
    );
  }

  /// `Code has been sent to `
  String get code_has_been_sent_to {
    return Intl.message(
      'Code has been sent to ',
      name: 'code_has_been_sent_to',
      desc: '',
      args: [],
    );
  }

  /// `Resend Code in `
  String get resend_code_in {
    return Intl.message(
      'Resend Code in ',
      name: 'resend_code_in',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get verify {
    return Intl.message('Verify', name: 'verify', desc: '', args: []);
  }

  /// `Fill your profile`
  String get fill_your_profile {
    return Intl.message(
      'Fill your profile',
      name: 'fill_your_profile',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get con {
    return Intl.message('Continue', name: 'con', desc: '', args: []);
  }

  /// `Your full name`
  String get name {
    return Intl.message('Your full name', name: 'name', desc: '', args: []);
  }

  /// `User name`
  String get user_name {
    return Intl.message('User name', name: 'user_name', desc: '', args: []);
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Date of birth`
  String get date_of_birth {
    return Intl.message(
      'Date of birth',
      name: 'date_of_birth',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about {
    return Intl.message('About', name: 'about', desc: '', args: []);
  }

  /// `Congratulations!`
  String get congratulations {
    return Intl.message(
      'Congratulations!',
      name: 'congratulations',
      desc: '',
      args: [],
    );
  }

  /// `Your account is ready to use. You will be redirected to the Home page in a few seconds.`
  String get your_account_has_been_created {
    return Intl.message(
      'Your account is ready to use. You will be redirected to the Home page in a few seconds.',
      name: 'your_account_has_been_created',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Chats`
  String get chats {
    return Intl.message('Chats', name: 'chats', desc: '', args: []);
  }

  /// `Groups`
  String get groups {
    return Intl.message('Groups', name: 'groups', desc: '', args: []);
  }

  /// `Search`
  String get search {
    return Intl.message('Search', name: 'search', desc: '', args: []);
  }

  /// `Edit your profile`
  String get edit_your_profile {
    return Intl.message(
      'Edit your profile',
      name: 'edit_your_profile',
      desc: '',
      args: [],
    );
  }

  /// `Save changes`
  String get save_changes {
    return Intl.message(
      'Save changes',
      name: 'save_changes',
      desc: '',
      args: [],
    );
  }

  /// `Bio`
  String get bio {
    return Intl.message('Bio', name: 'bio', desc: '', args: []);
  }

  /// `Phone number`
  String get phone_number {
    return Intl.message(
      'Phone number',
      name: 'phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Delete account`
  String get delete_account {
    return Intl.message(
      'Delete account',
      name: 'delete_account',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `Are you sure?`
  String get are_you_sure {
    return Intl.message(
      'Are you sure?',
      name: 'are_you_sure',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message('Yes', name: 'yes', desc: '', args: []);
  }

  /// `No`
  String get no {
    return Intl.message('No', name: 'no', desc: '', args: []);
  }

  /// `QR Code`
  String get qr_code {
    return Intl.message('QR Code', name: 'qr_code', desc: '', args: []);
  }

  /// `Start New Chat`
  String get start_new_chat {
    return Intl.message(
      'Start New Chat',
      name: 'start_new_chat',
      desc: '',
      args: [],
    );
  }

  /// `Start a conversation with your friends and family `
  String get start_a_converstion {
    return Intl.message(
      'Start a conversation with your friends and family ',
      name: 'start_a_converstion',
      desc: '',
      args: [],
    );
  }

  /// `to share your thoughts and ideas. `
  String get to_share_your_thoughts_and_ideas {
    return Intl.message(
      'to share your thoughts and ideas. ',
      name: 'to_share_your_thoughts_and_ideas',
      desc: '',
      args: [],
    );
  }

  /// `Start`
  String get start {
    return Intl.message('Start', name: 'start', desc: '', args: []);
  }

  /// `Welcome`
  String get welcome {
    return Intl.message('Welcome', name: 'welcome', desc: '', args: []);
  }

  /// `Start New Group`
  String get start_new_group {
    return Intl.message(
      'Start New Group',
      name: 'start_new_group',
      desc: '',
      args: [],
    );
  }

  /// `Create a new group`
  String get create_a_new_group {
    return Intl.message(
      'Create a new group',
      name: 'create_a_new_group',
      desc: '',
      args: [],
    );
  }

  /// `Get your friends and family together to share your thoughts and ideas`
  String get get_your_friends_to {
    return Intl.message(
      'Get your friends and family together to share your thoughts and ideas',
      name: 'get_your_friends_to',
      desc: '',
      args: [],
    );
  }

  /// `Add Members`
  String get add_members {
    return Intl.message('Add Members', name: 'add_members', desc: '', args: []);
  }

  /// `Choose people from your chats to add to the group`
  String get choose_people_from {
    return Intl.message(
      'Choose people from your chats to add to the group',
      name: 'choose_people_from',
      desc: '',
      args: [],
    );
  }

  /// `Create`
  String get create {
    return Intl.message('Create', name: 'create', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Online`
  String get online {
    return Intl.message('Online', name: 'online', desc: '', args: []);
  }

  /// `Offline`
  String get offline {
    return Intl.message('Offline', name: 'offline', desc: '', args: []);
  }

  /// `recently`
  String get recently {
    return Intl.message('recently', name: 'recently', desc: '', args: []);
  }

  /// `Last seen`
  String get last_seen {
    return Intl.message('Last seen', name: 'last_seen', desc: '', args: []);
  }

  /// `Type a message...`
  String get type_a_message {
    return Intl.message(
      'Type a message...',
      name: 'type_a_message',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgot_password {
    return Intl.message(
      'Forgot Password?',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Login with Google`
  String get login_with_google {
    return Intl.message(
      'Login with Google',
      name: 'login_with_google',
      desc: '',
      args: [],
    );
  }

  /// `Or`
  String get or {
    return Intl.message('Or', name: 'or', desc: '', args: []);
  }

  /// `Enter your email address`
  String get enter_your_email_address {
    return Intl.message(
      'Enter your email address',
      name: 'enter_your_email_address',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message('Send', name: 'send', desc: '', args: []);
  }

  /// `Enter your password`
  String get enter_your_password {
    return Intl.message(
      'Enter your password',
      name: 'enter_your_password',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email`
  String get please_enter_a_valid_email {
    return Intl.message(
      'Please enter a valid email',
      name: 'please_enter_a_valid_email',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid password`
  String get please_enter_a_valid_password {
    return Intl.message(
      'Please enter a valid password',
      name: 'please_enter_a_valid_password',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid name`
  String get please_enter_a_valid_name {
    return Intl.message(
      'Please enter a valid name',
      name: 'please_enter_a_valid_name',
      desc: '',
      args: [],
    );
  }

  /// `Back to Login`
  String get back_to_login {
    return Intl.message(
      'Back to Login',
      name: 'back_to_login',
      desc: '',
      args: [],
    );
  }

  /// `Email address`
  String get email_address {
    return Intl.message(
      'Email address',
      name: 'email_address',
      desc: '',
      args: [],
    );
  }

  /// `No worries! Enter your email address and\nwe’ll send you a link to reset your password.`
  String get no_worries_enter_your_email_address {
    return Intl.message(
      'No worries! Enter your email address and\nwe’ll send you a link to reset your password.',
      name: 'no_worries_enter_your_email_address',
      desc: '',
      args: [],
    );
  }

  /// `Send Reset Link`
  String get send_rest_link {
    return Intl.message(
      'Send Reset Link',
      name: 'send_rest_link',
      desc: '',
      args: [],
    );
  }

  /// `Password reset link sent successfully!`
  String get password_reset_link_sent_successfully {
    return Intl.message(
      'Password reset link sent successfully!',
      name: 'password_reset_link_sent_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Check your inbox`
  String get check_your_inbox {
    return Intl.message(
      'Check your inbox',
      name: 'check_your_inbox',
      desc: '',
      args: [],
    );
  }

  /// `We’ll send a password reset link to the email you provide.`
  String get we_will_send_you_a_link_to_reset_your_password {
    return Intl.message(
      'We’ll send a password reset link to the email you provide.',
      name: 'we_will_send_you_a_link_to_reset_your_password',
      desc: '',
      args: [],
    );
  }

  /// `By Signing up, you agree to our`
  String get by_siging_up {
    return Intl.message(
      'By Signing up, you agree to our',
      name: 'by_siging_up',
      desc: '',
      args: [],
    );
  }

  /// ` Terms & Conditions`
  String get terms_and_conditions {
    return Intl.message(
      ' Terms & Conditions',
      name: 'terms_and_conditions',
      desc: '',
      args: [],
    );
  }

  /// ` and `
  String get and {
    return Intl.message(' and ', name: 'and', desc: '', args: []);
  }

  /// `Privacy Policy`
  String get privacy_policy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacy_policy',
      desc: '',
      args: [],
    );
  }

  /// `Passwords don't match`
  String get passwords_do_not_match {
    return Intl.message(
      'Passwords don\'t match',
      name: 'passwords_do_not_match',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirm_password {
    return Intl.message(
      'Confirm Password',
      name: 'confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `At least 8 characters`
  String get at_least_8_characters {
    return Intl.message(
      'At least 8 characters',
      name: 'at_least_8_characters',
      desc: '',
      args: [],
    );
  }

  /// `At least 1 lowercase letter`
  String get at_least_1_lowercase_letter {
    return Intl.message(
      'At least 1 lowercase letter',
      name: 'at_least_1_lowercase_letter',
      desc: '',
      args: [],
    );
  }

  /// `At least 1 uppercase letter`
  String get at_least_1_uppercase_letter {
    return Intl.message(
      'At least 1 uppercase letter',
      name: 'at_least_1_uppercase_letter',
      desc: '',
      args: [],
    );
  }

  /// `At least 1 number`
  String get at_least_1_number {
    return Intl.message(
      'At least 1 number',
      name: 'at_least_1_number',
      desc: '',
      args: [],
    );
  }

  /// `At least 1 special character`
  String get at_least_1_special_character {
    return Intl.message(
      'At least 1 special character',
      name: 'at_least_1_special_character',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong. Please try again`
  String get something_went_wrong {
    return Intl.message(
      'Something went wrong. Please try again',
      name: 'something_went_wrong',
      desc: '',
      args: [],
    );
  }

  /// `The email or password is incorrect`
  String get invalid_credentials {
    return Intl.message(
      'The email or password is incorrect',
      name: 'invalid_credentials',
      desc: '',
      args: [],
    );
  }

  /// `This account has been disabled`
  String get user_disabled {
    return Intl.message(
      'This account has been disabled',
      name: 'user_disabled',
      desc: '',
      args: [],
    );
  }

  /// `No account found with this email address`
  String get user_not_found {
    return Intl.message(
      'No account found with this email address',
      name: 'user_not_found',
      desc: '',
      args: [],
    );
  }

  /// `The password is incorrect`
  String get wrong_password {
    return Intl.message(
      'The password is incorrect',
      name: 'wrong_password',
      desc: '',
      args: [],
    );
  }

  /// `This email address is already in use`
  String get email_already_in_use {
    return Intl.message(
      'This email address is already in use',
      name: 'email_already_in_use',
      desc: '',
      args: [],
    );
  }

  /// `The password is too weak`
  String get weak_password {
    return Intl.message(
      'The password is too weak',
      name: 'weak_password',
      desc: '',
      args: [],
    );
  }

  /// `Please check your internet connection`
  String get check_your_internet_connection {
    return Intl.message(
      'Please check your internet connection',
      name: 'check_your_internet_connection',
      desc: '',
      args: [],
    );
  }

  /// `Too many attempts. Please try again later`
  String get too_many_requests {
    return Intl.message(
      'Too many attempts. Please try again later',
      name: 'too_many_requests',
      desc: '',
      args: [],
    );
  }

  /// `This operation is currently unavailable`
  String get operation_not_allowed {
    return Intl.message(
      'This operation is currently unavailable',
      name: 'operation_not_allowed',
      desc: '',
      args: [],
    );
  }

  /// `Please sign in again and try again`
  String get requires_recent_login {
    return Intl.message(
      'Please sign in again and try again',
      name: 'requires_recent_login',
      desc: '',
      args: [],
    );
  }

  /// `An unexpected error occurred. Please try again`
  String get unexpected_error {
    return Intl.message(
      'An unexpected error occurred. Please try again',
      name: 'unexpected_error',
      desc: '',
      args: [],
    );
  }

  /// `You don't have permission to perform this operation`
  String get permission_denied {
    return Intl.message(
      'You don\'t have permission to perform this operation',
      name: 'permission_denied',
      desc: '',
      args: [],
    );
  }

  /// `The requested data was not found`
  String get data_not_found {
    return Intl.message(
      'The requested data was not found',
      name: 'data_not_found',
      desc: '',
      args: [],
    );
  }

  /// `The data already exists`
  String get data_already_exists {
    return Intl.message(
      'The data already exists',
      name: 'data_already_exists',
      desc: '',
      args: [],
    );
  }

  /// `The service is currently unavailable`
  String get service_unavailable {
    return Intl.message(
      'The service is currently unavailable',
      name: 'service_unavailable',
      desc: '',
      args: [],
    );
  }

  /// `The request timed out. Please try again`
  String get connection_timeout {
    return Intl.message(
      'The request timed out. Please try again',
      name: 'connection_timeout',
      desc: '',
      args: [],
    );
  }

  /// `The operation was cancelled`
  String get operation_cancelled {
    return Intl.message(
      'The operation was cancelled',
      name: 'operation_cancelled',
      desc: '',
      args: [],
    );
  }

  /// `The resource limit has been exceeded`
  String get resource_exhausted {
    return Intl.message(
      'The resource limit has been exceeded',
      name: 'resource_exhausted',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while accessing the database`
  String get database_error {
    return Intl.message(
      'An error occurred while accessing the database',
      name: 'database_error',
      desc: '',
      args: [],
    );
  }

  /// `The file was not found`
  String get file_not_found {
    return Intl.message(
      'The file was not found',
      name: 'file_not_found',
      desc: '',
      args: [],
    );
  }

  /// `You don't have permission to access this file`
  String get file_access_denied {
    return Intl.message(
      'You don\'t have permission to access this file',
      name: 'file_access_denied',
      desc: '',
      args: [],
    );
  }

  /// `The storage quota has been exceeded`
  String get storage_quota_exceeded {
    return Intl.message(
      'The storage quota has been exceeded',
      name: 'storage_quota_exceeded',
      desc: '',
      args: [],
    );
  }

  /// `The operation failed. Please try again`
  String get operation_failed_retry {
    return Intl.message(
      'The operation failed. Please try again',
      name: 'operation_failed_retry',
      desc: '',
      args: [],
    );
  }

  /// `The file is corrupted`
  String get file_corrupted {
    return Intl.message(
      'The file is corrupted',
      name: 'file_corrupted',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while uploading or downloading the file`
  String get storage_error {
    return Intl.message(
      'An error occurred while uploading or downloading the file',
      name: 'storage_error',
      desc: '',
      args: [],
    );
  }

  /// `The request timed out. Please try again`
  String get request_timeout {
    return Intl.message(
      'The request timed out. Please try again',
      name: 'request_timeout',
      desc: '',
      args: [],
    );
  }

  /// `Your email address is not confirmed`
  String get email_not_confirmed {
    return Intl.message(
      'Your email address is not confirmed',
      name: 'email_not_confirmed',
      desc: '',
      args: [],
    );
  }

  /// `Your phone number is not confirmed`
  String get phone_not_confirmed {
    return Intl.message(
      'Your phone number is not confirmed',
      name: 'phone_not_confirmed',
      desc: '',
      args: [],
    );
  }

  /// `Google sign-in was cancelled by the user`
  String get google_sign_in_cancelled {
    return Intl.message(
      'Google sign-in was cancelled by the user',
      name: 'google_sign_in_cancelled',
      desc: '',
      args: [],
    );
  }

  /// `Unexpected error in SupabaseAuthService`
  String get unexpected_error_in_supabase_auth {
    return Intl.message(
      'Unexpected error in SupabaseAuthService',
      name: 'unexpected_error_in_supabase_auth',
      desc: '',
      args: [],
    );
  }

  /// `Unexpected database error`
  String get unexpected_data_base_error {
    return Intl.message(
      'Unexpected database error',
      name: 'unexpected_data_base_error',
      desc: '',
      args: [],
    );
  }

  /// `User already exists`
  String get user_already_exists {
    return Intl.message(
      'User already exists',
      name: 'user_already_exists',
      desc: '',
      args: [],
    );
  }

  /// `loading`
  String get loading {
    return Intl.message('loading', name: 'loading', desc: '', args: []);
  }

  /// `Phone number already exists`
  String get phone_number_already_exists {
    return Intl.message(
      'Phone number already exists',
      name: 'phone_number_already_exists',
      desc: '',
      args: [],
    );
  }

  /// `Username already exists`
  String get username_already_exists {
    return Intl.message(
      'Username already exists',
      name: 'username_already_exists',
      desc: '',
      args: [],
    );
  }

  /// `Phone number is required`
  String get phoneRequired {
    return Intl.message(
      'Phone number is required',
      name: 'phoneRequired',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid phone number`
  String get invalidPhone {
    return Intl.message(
      'Please enter a valid phone number',
      name: 'invalidPhone',
      desc: '',
      args: [],
    );
  }

  /// `You cannot chat with yourself`
  String get cannot_chat_with_yourself {
    return Intl.message(
      'You cannot chat with yourself',
      name: 'cannot_chat_with_yourself',
      desc: '',
      args: [],
    );
  }

  /// `Find someone by username or phone number`
  String get find_someone_by_username_or_phone_number {
    return Intl.message(
      'Find someone by username or phone number',
      name: 'find_someone_by_username_or_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `New Chat`
  String get new_chat {
    return Intl.message('New Chat', name: 'new_chat', desc: '', args: []);
  }

  /// `@username`
  String get at_username {
    return Intl.message('@username', name: 'at_username', desc: '', args: []);
  }

  /// `Username`
  String get username {
    return Intl.message('Username', name: 'username', desc: '', args: []);
  }

  /// `Starting...`
  String get starting {
    return Intl.message('Starting...', name: 'starting', desc: '', args: []);
  }

  /// `Searching...`
  String get searching {
    return Intl.message('Searching...', name: 'searching', desc: '', args: []);
  }

  /// `Start Chat`
  String get start_chat {
    return Intl.message('Start Chat', name: 'start_chat', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
