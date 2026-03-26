part of 'admin_bloc.dart';

sealed class AdminEvent extends Equatable {
  const AdminEvent();

  @override
  List<Object> get props => [];
}

class AdminAddCategoryEvent extends AdminEvent {
  final CategoryModel category;

  const AdminAddCategoryEvent({required this.category});
}

class AdminUpdateCategoryEvent extends AdminEvent {
  final CategoryModel category;

  const AdminUpdateCategoryEvent({required this.category});
}

class AdminDeleteCategoryEvent extends AdminEvent {
  final String categoryId;

  const AdminDeleteCategoryEvent({required this.categoryId});
}
