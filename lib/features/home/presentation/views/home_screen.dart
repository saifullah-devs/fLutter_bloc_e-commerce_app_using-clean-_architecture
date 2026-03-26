import 'package:e_commerce_bloc/core/routes/routes_name.dart';
import 'package:e_commerce_bloc/core/utils/enum.dart';
import 'package:e_commerce_bloc/core/utils/flash_bar_helper.dart';
import 'package:e_commerce_bloc/core/utils/gap.dart';
import 'package:e_commerce_bloc/features/auth/presentations/bloc/auth/auth_bloc.dart';
import 'package:e_commerce_bloc/features/category/presentation/bloc/category_bloc.dart';
import 'package:e_commerce_bloc/features/home/presentation/widgets/custom_drawer.dart';
import 'package:e_commerce_bloc/features/home/presentation/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/categories_widget.dart';
import '../widgets/search_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(GetUserEvent());
    context.read<CategoryBloc>().add(DisplayCategoriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.signOutResponse.status == FetchStatus.loading) {
          FlashBarHelper.flashBarLoadingMessage(context, 'Logging out...');
        }
        if (state.signOutResponse.status == FetchStatus.complete) {
          FlashBarHelper.flashBarSuccessMessage(context, 'Succeed');

          Navigator.pushNamedAndRemoveUntil(
            context,
            RoutesName.signinScreen,
            (r) => false,
          );
        }
        if (state.getUserResponse.status == FetchStatus.error) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            RoutesName.signinScreen,
            (r) => false,
          );
        }
      },
      child: Scaffold(
        drawer: const CustomDrawer(),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: HeaderWidget(),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [SearchField(), Gap.h20, Categories(), Gap.h20],
          ),
        ),
      ),
    );
  }
}
