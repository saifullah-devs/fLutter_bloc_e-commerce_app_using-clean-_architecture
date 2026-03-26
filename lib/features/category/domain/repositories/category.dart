import 'package:dartz/dartz.dart';

import '../../data/models/category.dart';

abstract class CategoryRepository {
  Future<Either> getCategories();
  Future<Either> addCategory(CategoryModel category);
  Future<Either> updateCategory(CategoryModel category);
  Future<Either> deleteCategory(String id);
}
