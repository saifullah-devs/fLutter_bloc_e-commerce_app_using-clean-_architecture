import 'package:e_commerce_bloc/core/utils/enum.dart';
import 'package:e_commerce_bloc/features/category/domain/entities/category.dart';
import 'package:e_commerce_bloc/features/category/presentation/bloc/category_bloc.dart';
import 'package:e_commerce_bloc/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CategoryBloc>()..add(DisplayCategoriesEvent()),

      child: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state.getcategoriesResponse.status == FetchStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.getcategoriesResponse.status == FetchStatus.complete) {
            final categories = state.categoryList ?? [];
            return Column(
              children: [
                _seaAll(context),
                const SizedBox(height: 20),
                _categories(categories),
              ],
            );
          }

          if (state.getcategoriesResponse.status == FetchStatus.error) {
            return Center(
              child: Text(
                state.getcategoriesResponse.message ??
                    'Failed to load categories',
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _seaAll(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Categories',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          GestureDetector(
            onTap: () {},
            child: const Text(
              'See All',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _categories(List<CategoryEntity> categories) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(categories[index].image),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                categories[index].title,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ],
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 15),
        itemCount: categories.length,
      ),
    );
  }
}
