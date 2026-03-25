import 'package:e_commerce_bloc/core/config/assets/app_vectors.dart';
import 'package:e_commerce_bloc/features/auth/presentations/bloc/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Text('Home', style: Theme.of(context).textTheme.labelLarge),
      ),
      actions: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(40),
          ),
          child: SvgPicture.asset(AppVectors.bag, width: 25, height: 25),
        ),
      ],
      leading: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return GestureDetector(
            onTap: () => Scaffold.of(context).openDrawer(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: (state.user?.image.isNotEmpty ?? false)
                    ? NetworkImage(state.user!.image)
                    : null,
                child: (state.user?.image == null || state.user!.image.isEmpty)
                    ? const Icon(Icons.person)
                    : null,
              ),
            ),
          );
        },
      ),
    );
  }
}
