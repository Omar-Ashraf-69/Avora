import 'dart:developer';

import 'package:avora/core/error/exceptions.dart';
import 'package:avora/core/error/supabase_exception_mapper.dart';
import 'package:avora/core/services/database/data_base_service.dart';
import 'package:avora/generated/l10n.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseDatabaseService implements DatabaseService {
  SupabaseDatabaseService({required this._supabase});

  final SupabaseClient _supabase;

  @override
  Future<Map<String, dynamic>?> getById({
    required String table,
    required String id,
  }) async {
    return await _execute<Map<String, dynamic>?>(
      operation: 'getById',
      action: () async {
        final response = await _supabase
            .from(table)
            .select()
            .eq('id', id)
            .maybeSingle();

        return response;
      },
    );
  }

  @override
  Future<bool> exists({required String table, required String id}) async {
    return await _execute<bool>(
      operation: 'exists',
      action: () async {
        final response = await _supabase
            .from(table)
            .select('id')
            .eq('id', id)
            .maybeSingle();

        return response != null;
      },
    );
  }

  @override
  Future<Map<String, dynamic>> insert({
    required String table,
    required Map<String, dynamic> data,
  }) async {
    return await _execute<Map<String, dynamic>>(
      operation: 'insert',
      action: () async {
        final response = await _supabase
            .from(table)
            .insert(data)
            .select()
            .single();

        return response;
      },
    );
  }

  @override
  Future<Map<String, dynamic>> update({
    required String table,
    required String id,
    required Map<String, dynamic> data,
  }) async {
    return await _execute<Map<String, dynamic>>(
      operation: 'update',
      action: () async {
        final response = await _supabase
            .from(table)
            .update(data)
            .eq('id', id)
            .select()
            .single();

        return response;
      },
    );
  }

  @override
  Future<void> delete({required String table, required String id}) async {
    return await _execute<void>(
      operation: 'delete',
      action: () async {
        await _supabase.from(table).delete().eq('id', id);
      },
    );
  }

  @override
  Future<List<Map<String, dynamic>>> get({
    required String table,
    Map<String, dynamic>? filters,
  }) async {
    return await _execute<List<Map<String, dynamic>>>(
      operation: 'get',
      action: () async {
        dynamic query = _supabase.from(table).select();
        filters?.forEach((column, value) {
          query = query.eq(column, value);
        });
        final response = await query;
        return List<Map<String, dynamic>>.from(response);
      },
    );
  }

  @override
Future<dynamic> rpc({
  required String functionName,
  Map<String, dynamic>? params,
}) async {

  return await _execute<dynamic>(
    operation: 'rpc',
    action: () async {
      return await _supabase.rpc(
      functionName,
      params: params,
    );
    },
  );
  }

  Future<T> _execute<T>({
    required String operation,
    required Future<T> Function() action,
  }) async {
    try {
      return await action();
    } on PostgrestException catch (e, stackTrace) {
      log(
        'SupabaseDatabaseService.$operation',
        error: e,
        stackTrace: stackTrace,
      );

      throw CustomException(
        message: SupabaseExceptionMapper.mapDatabaseException(
          code: e.code,
          message: e.message,
        ),
      );
    } catch (e, stackTrace) {
      log(
        'SupabaseDatabaseService.$operation',
        error: e,
        stackTrace: stackTrace,
      );

      throw CustomException(message: S.current.unexpected_error);
    }
  }
}
