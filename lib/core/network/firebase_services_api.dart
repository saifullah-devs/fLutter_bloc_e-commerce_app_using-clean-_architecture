import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../exceptions/app_exceptions.dart';
import 'base_api_services.dart';

class FirebaseServicesApi implements BaseDatabaseServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const int _defaultTimeout = 15;

  @override
  Future<dynamic> readAll({
    required String path,
    Query Function(Query query)? queryBuilder,
  }) async {
    return _processRequest(() async {
      Query query = _firestore.collection(path);

      if (queryBuilder != null) {
        query = queryBuilder(query);
      }

      final snapshot = await query.get();

      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return data;
      }).toList();
    });
  }

  @override
  Future<dynamic> readOne({
    required String path,
    Query Function(Query query)? queryBuilder,
  }) async {
    return _processRequest(() async {
      if (queryBuilder != null) {
        Query query = _firestore.collection(path);
        query = queryBuilder(query).limit(1);

        final snapshot = await query.get();

        if (snapshot.docs.isEmpty) {
          throw BadRequestException(
            'No document found at the given path/query.',
          );
        }

        final doc = snapshot.docs.first;
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return data;
      }

      final snapshot = await _firestore.doc(path).get();

      if (!snapshot.exists) {
        throw BadRequestException('Document does not exist.');
      }

      final data = snapshot.data() as Map<String, dynamic>;
      data['id'] = snapshot.id;
      return data;
    });
  }

  @override
  Future<dynamic> create({
    required String path,
    dynamic data,
    String? id,
  }) async {
    return _processRequest(() async {
      DocumentReference docRef;

      if (id != null) {
        docRef = _firestore.collection(path).doc(id);
        await docRef.set(data);
      } else {
        docRef = await _firestore.collection(path).add(data);
      }

      final snapshot = await docRef.get();

      final responseData = (snapshot.data() as Map<String, dynamic>?) ?? {};
      responseData['id'] = snapshot.id;
      return responseData;
    });
  }

  @override
  Future<dynamic> update({required String path, dynamic data}) async {
    return _processRequest(() async {
      // Path should be "Collection/DocumentID"
      await _firestore.doc(path).set(data, SetOptions(merge: true));
      return data;
    });
  }

  @override
  Future<dynamic> delete({required String path}) async {
    return _processRequest(() async {
      await _firestore.doc(path).delete();
      return {'status': 'success', 'path': path};
    });
  }

  Future<dynamic> _processRequest(Future<dynamic> Function() action) async {
    try {
      return await action().timeout(const Duration(seconds: _defaultTimeout));
    } on FirebaseException catch (e) {
      throw _handleFirebaseError(e);
    } on TimeoutException {
      throw NetworkException('Connection timed out. Check your internet.');
    } catch (e) {
      throw DataParsingException('Unexpected Firebase Error: ${e.toString()}');
    }
  }

  Exception _handleFirebaseError(FirebaseException e) {
    switch (e.code) {
      case 'permission-denied':
        return UnauthorisedException(
          'You do not have permission to access this.',
        );
      case 'not-found':
        return BadRequestException('The requested resource was not found.');
      case 'unavailable':
        return NetworkException('Firebase service is currently unavailable.');
      default:
        return DataParsingException('Firebase Error (${e.code}): ${e.message}');
    }
  }
}
