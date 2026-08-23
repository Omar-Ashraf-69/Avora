import 'package:avora/generated/l10n.dart';

class SupabaseExceptionMapper {

  static String mapAuthException(String code) {
    switch (code) {
      case 'invalid-email':
        return S.current.invalid_credentials;

      case 'invalid-credential':
        return S.current.invalid_credentials;

      case 'user-disabled':
        return S.current.user_disabled;

      case 'user-not-found':
        return S.current.user_not_found;

      case 'wrong-password':
        return S.current.wrong_password;

      case 'email-already-in-use':
        return S.current.email_already_in_use;

      case 'weak-password':
        return S.current.weak_password;

      case 'network-request-failed':
        return S.current.check_your_internet_connection;

      case 'too-many-requests':
        return S.current.too_many_requests;

      case 'operation-not-allowed':
        return S.current.operation_not_allowed;

      case 'requires-recent-login':
        return S.current.requires_recent_login;
    

      default:
        return S.current.unexpected_error;
    }
  }

 
  static String mapStorageException(String code) {
    switch (code) {
      case 'object-not-found':
        return S.current.file_not_found;

      case 'unauthorized':
        return S.current.file_access_denied;

      case 'canceled':
        return S.current.operation_cancelled;

      case 'quota-exceeded':
        return S.current.storage_quota_exceeded;

      case 'retry-limit-exceeded':
        return S.current.operation_failed_retry;

      case 'invalid-checksum':
        return S.current.file_corrupted;

      default:
        return S.current.storage_error;
    }
  }
}
