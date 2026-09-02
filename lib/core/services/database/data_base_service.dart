abstract class DatabaseService {
  Future<Map<String, dynamic>?> getById({
    required String table,
    required String id,
  });

  Future<List<Map<String, dynamic>>> get({
    required String table,
    Map<String, dynamic>? filters,
  });

  Future<Map<String, dynamic>> insert({
    required String table,
    required Map<String, dynamic> data,
  });

  Future<Map<String, dynamic>> update({
    required String table,
    required String id,
    required Map<String, dynamic> data,
  });

  Future<void> delete({
    required String table,
    required String id,
  });

  Future<bool> exists({
    required String table,
    required String id,
  });

  Future<dynamic> rpc({
  required String functionName,
  Map<String, dynamic>? params,
});

}