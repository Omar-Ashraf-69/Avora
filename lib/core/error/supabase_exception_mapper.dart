import 'package:avora/generated/l10n.dart';

class SupabaseExceptionMapper {
  const SupabaseExceptionMapper._();

  static String mapAuthException({
    String? code,
    int? statusCode,
    String? message,
  }) {
    switch (code) {
      case 'invalid_credentials':
        return S.current.invalid_credentials;

      case 'email_exists':
        return S.current.email_already_in_use;

      case 'user_not_found':
        return S.current.user_not_found;

      case 'user_banned':
        return S.current.user_disabled;

      case 'weak_password':
        return S.current.weak_password;

      case 'email_not_confirmed':
        return S.current.email_not_confirmed;

      case 'phone_not_confirmed':
        return S.current.phone_not_confirmed;

      case 'over_request_rate_limit':
      case 'over_email_send_rate_limit':
        return S.current.too_many_requests;

      case 'email_address_invalid':
        return S.current.invalid_credentials;

      case 'signup_disabled':
        return S.current.operation_not_allowed;

      case 'provider_disabled':
        return S.current.operation_not_allowed;

      case 'validation_failed':
        return S.current.invalid_credentials;
    }

    switch (statusCode) {
      case 400:
        return S.current.invalid_credentials;

      case 401:
        return S.current.invalid_credentials;

      case 403:
        return S.current.permission_denied;

      case 408:
        return S.current.request_timeout;

      case 429:
        return S.current.too_many_requests;

      case 500:
      case 502:
      case 503:
      case 504:
        return S.current.service_unavailable;
    }

    return S.current.unexpected_error;
  }

  static String mapDatabaseException({
    String? code,
    String? message,
  }) {
    switch (code) {
      case '42501':
        return S.current.permission_denied;

      case '23505':
        return S.current.data_already_exists;

      case '23503':
        return S.current.data_not_found;

      case 'PGRST116':
        return S.current.data_not_found;

      default:
        return S.current.database_error;
    }
  }

  static String mapStorageException({
    String? statusCode,
    String? message,
  }) {
    switch (statusCode) {
      case '400':
        return S.current.storage_error;

      case '401':
        return S.current.file_access_denied;

      case '403':
        return S.current.file_access_denied;

      case '404':
        return S.current.file_not_found;

      case '409':
        return S.current.operation_cancelled;

      case '413':
        return S.current.storage_quota_exceeded;

      case '429':
        return S.current.too_many_requests;

      default:
        return S.current.storage_error;
    }
  }
}