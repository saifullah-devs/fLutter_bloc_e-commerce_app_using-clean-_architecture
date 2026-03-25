import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BaseDatabaseServices {
  /// Reads a collection or a specific document
  Future<dynamic> readAll({
    required String path,
    Query Function(Query query)? queryBuilder,
  });
  Future<dynamic> readOne({
    required String path,
    Query Function(Query query)? queryBuilder,
  });

  /// Creates a new document with a system-generated ID (was postApi)
  Future<dynamic> create({required String path, dynamic data});

  /// Updates or sets a specific document (was putApi)
  Future<dynamic> update({required String path, dynamic data});

  /// Removes a document by its path/id
  Future<dynamic> delete({required String path});
}
