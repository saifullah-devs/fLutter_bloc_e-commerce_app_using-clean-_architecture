import 'package:dartz/dartz.dart';
import 'package:e_commerce_bloc/features/category/domain/entities/category.dart';

import '../../../../service_locator.dart';
import '../../domain/repositories/category.dart';
import '../datasources/category_firebase_service.dart';
import '../models/category.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  @override
  Future<Either> getCategories() async {
    var categories = await sl<CategoryFirebaseService>().getCategories();

    return categories.fold(
      (error) {
        return Left(error);
      },
      (data) {
        try {
          final List<dynamic> rawList = data as List<dynamic>;

          final List<CategoryEntity> entities = rawList.map((e) {
            final map = Map<String, dynamic>.from(e as Map);
            return CategoryModel.fromMap(map).toEntity();
          }).toList();

          return Right(entities);
        } catch (e) {
          return Left("Mapping error: ${e.toString()}");
        }
      },
    );
  }

  @override
  Future<Either> addCategory(CategoryModel category) async {
    // We send data WITHOUT the categoryId, because Firebase creates it for us
    final Map<String, dynamic> data = {
      'title': category.title,
      'image': category.image,
    };

    return await sl<CategoryFirebaseService>().addCategory(data);
  }

  @override
  Future<Either> updateCategory(CategoryModel category) async {
    // We convert the updated CategoryModel into a map for Firebase
    final Map<String, dynamic> data = {
      'title': category.title,
      'image': category.image,
    };

    // We pass the categoryId to the service so it knows exactly which document to update
    return await sl<CategoryFirebaseService>().updateCategory(
      category.categoryId,
      data,
    );
  }

  @override
  Future<Either> deleteCategory(String id) async {
    return await sl<CategoryFirebaseService>().deleteCategory(id);
  }
}
