part of 'category_bloc.dart';

class CategoryState extends Equatable {
  final List<CategoryEntity>? categoryList;
  final ApiResponse<dynamic> getcategoriesResponse;

  const CategoryState({
    this.categoryList = const [],
    required this.getcategoriesResponse,
  });

  CategoryState copyWith({
    List<CategoryEntity>? categoryList,
    ApiResponse<dynamic>? getcategoriesResponse,
  }) {
    return CategoryState(
      categoryList: categoryList ?? this.categoryList,
      getcategoriesResponse:
          getcategoriesResponse ?? this.getcategoriesResponse,
    );
  }

  @override
  List<Object?> get props => [categoryList, getcategoriesResponse];
}
