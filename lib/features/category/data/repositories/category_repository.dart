import 'package:dartz/dartz.dart';

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
        return Right(
          List.from(
            data,
          ).map((e) => CategoryModel.fromMap(e).toEntity()).toList(),
        );
      },
    );
  }
}
