part of 'admin_bloc.dart';

class AdminState extends Equatable {
  // We track the status of adding and updating separately
  final ApiResponse<String> addCategoryResponse;
  final ApiResponse<String> updateCategoryResponse;
  final ApiResponse<String> deleteCategoryResponse;

  const AdminState({
    this.addCategoryResponse = const ApiResponse.initial(),
    this.updateCategoryResponse = const ApiResponse.initial(),
    this.deleteCategoryResponse = const ApiResponse.initial(),
  });

  AdminState copyWith({
    ApiResponse<String>? addCategoryResponse,
    ApiResponse<String>? updateCategoryResponse,
    ApiResponse<String>? deleteCategoryResponse,
  }) {
    return AdminState(
      addCategoryResponse: addCategoryResponse ?? this.addCategoryResponse,
      deleteCategoryResponse:
          deleteCategoryResponse ?? this.deleteCategoryResponse,
      updateCategoryResponse:
          updateCategoryResponse ?? this.updateCategoryResponse,
    );
  }

  @override
  List<Object> get props => [
    addCategoryResponse,
    updateCategoryResponse,
    deleteCategoryResponse,
  ];
}
