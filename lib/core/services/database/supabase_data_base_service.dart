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
    try {
      final response = await _supabase
          .from(table)
          .select()
          .eq('id', id)
          .maybeSingle();

      return response;
    } on PostgrestException catch (e, stackTrace) {
      log('SupabaseDatabaseService.getById', error: e, stackTrace: stackTrace);

      throw CustomException(
        message: SupabaseExceptionMapper.mapDatabaseException(
          code: e.code,
          message: e.message,
        ),
      );
    } catch (e, stackTrace) {
      log(S.current.unexpected_data_base_error, error: e, stackTrace: stackTrace);

      throw CustomException(message: S.current.unexpected_error);
    }
  }

  @override
  Future<bool> exists({required String table, required String id}) async {
    try {
      final response = await _supabase
          .from(table)
          .select('id')
          .eq('id', id)
          .maybeSingle();

      return response != null;
    } on PostgrestException catch (e, stackTrace) {
      log('SupabaseDatabaseService.exists', error: e, stackTrace: stackTrace);

      throw CustomException(
        message: SupabaseExceptionMapper.mapDatabaseException(
          code: e.code,
          message: e.message,
        ),
      );
    }
  }

  @override
  Future<Map<String, dynamic>> insert({
    required String table,
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await _supabase
          .from(table)
          .insert(data)
          .select()
          .single();

      return response;
    } on PostgrestException catch (e, stackTrace) {
      log('SupabaseDatabaseService.insert', error: e, stackTrace: stackTrace);

      throw CustomException(
        message: SupabaseExceptionMapper.mapDatabaseException(
          code: e.code,
          message: e.message,
        ),
      );
    }
  }

  @override
  Future<Map<String, dynamic>> update({
    required String table,
    required String id,
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await _supabase
          .from(table)
          .update(data)
          .eq('id', id)
          .select()
          .single();

      return response;
    } on PostgrestException catch (e, stackTrace) {
      log('SupabaseDatabaseService.update', error: e, stackTrace: stackTrace);

      throw CustomException(
        message: SupabaseExceptionMapper.mapDatabaseException(
          code: e.code,
          message: e.message,
        ),
      );
    }
  }

  @override
  Future<void> delete({required String table, required String id}) async {
    try {
      await _supabase.from(table).delete().eq('id', id);
    } on PostgrestException catch (e, stackTrace) {
      log('SupabaseDatabaseService.delete', error: e, stackTrace: stackTrace);

      throw CustomException(
        message: SupabaseExceptionMapper.mapDatabaseException(
          code: e.code,
          message: e.message,
        ),
      );
    }
  }

  @override
  Future<List<Map<String, dynamic>>> get({
    required String table,
    Map<String, dynamic>? filters,
  }) async {
    try {
      dynamic query = _supabase.from(table).select();

      filters?.forEach((column, value) {
        query = query.eq(column, value);
      });

      final response = await query;

      return List<Map<String, dynamic>>.from(response);
    } on PostgrestException catch (e, stackTrace) {
      log('SupabaseDatabaseService.get', error: e, stackTrace: stackTrace);

      throw CustomException(
        message: SupabaseExceptionMapper.mapDatabaseException(
          code: e.code,
          message: e.message,
        ),
      );
    }
  }
}
