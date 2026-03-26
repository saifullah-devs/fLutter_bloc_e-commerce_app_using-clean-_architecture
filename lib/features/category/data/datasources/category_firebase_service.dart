import 'package:dartz/dartz.dart';
import 'package:e_commerce_bloc/core/network/firebase_services_api.dart';

abstract class CategoryFirebaseService {
  Future<Either> getCategories();
  Future<Either> addCategory(Map<String, dynamic> categoryData);
  Future<Either> updateCategory(String id, Map<String, dynamic> categoryData);
  Future<Either> deleteCategory(String id);
}

class CategoryFirebaseServiceImpl extends CategoryFirebaseService {
  final FirebaseServicesApi _apiService = FirebaseServicesApi();

  @override
  Future<Either> getCategories() async {
    try {
      var returnData = await _apiService.readAll(path: 'categories');
      print("RAW FIREBASE DATA: $returnData");
      return Right(returnData);
    } catch (e) {
      return const Left('Please try again');
    }
  }

  @override
  Future<Either> addCategory(Map<String, dynamic> categoryData) async {
    try {
      // 1. Create the document (Firebase auto-generates the ID)
      var response = await _apiService.create(
        path: 'categories',
        data: categoryData,
      );

      // 2. Fetch the newly generated ID and update the document with it
      final String newId = response['id'];
      await _apiService.update(
        path: 'categories/$newId',
        data: {'categoryId': newId},
      );

      return const Right('Category successfully added');
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either> updateCategory(
    String id,
    Map<String, dynamic> categoryData,
  ) async {
    try {
      // Update the specific document using its ID
      await _apiService.update(path: 'categories/$id', data: categoryData);
      return const Right('Category successfully updated');
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either> deleteCategory(String id) async {
    try {
      // Assuming your apiService has a delete method that takes a path.
      // We pass the specific document ID to delete it.
      await _apiService.delete(path: 'categories/$id');
      return const Right('Category successfully deleted');
    } catch (e) {
      return Left(e.toString());
    }
  }
}
