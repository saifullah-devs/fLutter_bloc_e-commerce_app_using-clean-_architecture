import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_bloc/core/utils/enum.dart';
import 'package:e_commerce_bloc/core/utils/flash_bar_helper.dart';
import 'package:e_commerce_bloc/features/category/data/models/category.dart';
import 'package:e_commerce_bloc/features/category/presentation/bloc/category_bloc.dart';

import '../bloc/admin_bloc.dart';

class AdminCategoryScreen extends StatefulWidget {
  const AdminCategoryScreen({super.key});

  @override
  State<AdminCategoryScreen> createState() => _AdminCategoryScreenState();
}

class _AdminCategoryScreenState extends State<AdminCategoryScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  void _showCategoryBottomSheet({CategoryModel? existingCategory}) {
    if (existingCategory != null) {
      _titleController.text = existingCategory.title;
      _imageController.text = existingCategory.image;
    } else {
      _titleController.clear();
      _imageController.clear();
    }

    // 1. Capture the bloc from the current context BEFORE opening the sheet
    final adminBloc = context.read<AdminBloc>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (bottomSheetContext) {
        // Renamed context to avoid confusion

        // 2. Wrap the sheet's content in BlocProvider.value to pass the bloc inside!
        return BlocProvider.value(
          value: adminBloc,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(bottomSheetContext).viewInsets.bottom,
              left: 16,
              right: 16,
              top: 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  existingCategory == null ? 'Add Category' : 'Edit Category',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Category Title',
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _imageController,
                  decoration: const InputDecoration(labelText: 'Image URL'),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    final newCategory = CategoryModel(
                      categoryId: existingCategory?.categoryId ?? '',
                      title: _titleController.text,
                      image: _imageController.text,
                    );

                    // 3. Now it will successfully find the BLoC!
                    if (existingCategory == null) {
                      adminBloc.add(
                        AdminAddCategoryEvent(category: newCategory),
                      );
                    } else {
                      adminBloc.add(
                        AdminUpdateCategoryEvent(category: newCategory),
                      );
                    }

                    Navigator.pop(bottomSheetContext); // Close the bottom sheet
                  },
                  child: Text(existingCategory == null ? 'Save' : 'Update'),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        );
      },
    );
  }

  void _confirmDelete(String categoryId) {
    // 1. Capture the BLoC from the current screen BEFORE opening the dialog
    final adminBloc = context.read<AdminBloc>();

    showDialog(
      context: context,
      // 2. Rename this context to 'dialogContext' so we don't confuse Flutter
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Category?'),
        content: const Text('Are you sure you want to delete this?'),
        actions: [
          TextButton(
            // Use dialogContext to close the dialog
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // 3. Use the captured 'adminBloc' variable instead of context.read!
              adminBloc.add(AdminDeleteCategoryEvent(categoryId: categoryId));

              Navigator.pop(dialogContext); // Close the dialog
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Categories')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCategoryBottomSheet(),
        child: const Icon(Icons.add),
      ),

      // 1. Listen to AdminBloc for Success/Error messages
      body: BlocListener<AdminBloc, AdminState>(
        listener: (context, state) {
          // Listen for ADD
          if (state.addCategoryResponse.status == FetchStatus.complete) {
            FlashBarHelper.flashBarSuccessMessage(
              context,
              state.addCategoryResponse.data!,
            );
            context.read<CategoryBloc>().add(
              DisplayCategoriesEvent(),
            ); // Refresh the list
          } else if (state.addCategoryResponse.status == FetchStatus.error) {
            FlashBarHelper.flashBarErrorMessage(
              context,
              state.addCategoryResponse.message!,
            );
          }

          // Listen for UPDATE
          if (state.updateCategoryResponse.status == FetchStatus.complete) {
            FlashBarHelper.flashBarSuccessMessage(
              context,
              state.updateCategoryResponse.data!,
            );
            context.read<CategoryBloc>().add(
              DisplayCategoriesEvent(),
            ); // Refresh the list
          } else if (state.updateCategoryResponse.status == FetchStatus.error) {
            FlashBarHelper.flashBarErrorMessage(
              context,
              state.updateCategoryResponse.message!,
            );
          }

          // Listen for DELETE
          if (state.deleteCategoryResponse.status == FetchStatus.complete) {
            FlashBarHelper.flashBarSuccessMessage(
              context,
              state.deleteCategoryResponse.data!,
            );
            context.read<CategoryBloc>().add(
              DisplayCategoriesEvent(),
            ); // Refresh the list
          } else if (state.deleteCategoryResponse.status == FetchStatus.error) {
            FlashBarHelper.flashBarErrorMessage(
              context,
              state.deleteCategoryResponse.message!,
            );
          }
        },

        // 2. Build the UI using the global CategoryBloc
        child: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            if (state.getcategoriesResponse.status == FetchStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.getcategoriesResponse.status == FetchStatus.complete) {
              final categories = state.categoryList ?? [];

              if (categories.isEmpty) {
                return const Center(child: Text('No categories found.'));
              }

              return ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey[200],
                      backgroundImage: category.image.isNotEmpty
                          ? NetworkImage(category.image)
                          : null,
                      child: category.image.isEmpty
                          ? const Icon(
                              Icons.image_not_supported,
                              color: Colors.grey,
                            )
                          : null,
                    ),
                    title: Text(category.title),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            final model = CategoryModel(
                              categoryId: category.categoryId,
                              title: category.title,
                              image: category.image,
                            );
                            _showCategoryBottomSheet(existingCategory: model);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _confirmDelete(category.categoryId),
                        ),
                      ],
                    ),
                  );
                },
              );
            }

            if (state.getcategoriesResponse.status == FetchStatus.error) {
              return Center(
                child: Text(
                  state.getcategoriesResponse.message ??
                      'Error loading categories',
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
