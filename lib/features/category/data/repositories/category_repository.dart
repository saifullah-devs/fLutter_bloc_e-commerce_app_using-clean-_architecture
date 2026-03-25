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
}
