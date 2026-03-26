import 'package:e_commerce_bloc/core/routes/routes_name.dart';
import 'package:e_commerce_bloc/features/auth/presentations/bloc/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          final user = state.user;

          return Column(
            children: [
              UserAccountsDrawerHeader(
                decoration: const BoxDecoration(color: Colors.deepPurple),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: (user?.image.isNotEmpty ?? false)
                      ? NetworkImage(user!.image)
                      : null,
                  child: (user?.image.isEmpty ?? true)
                      ? const Icon(Icons.person, size: 40, color: Colors.grey)
                      : null,
                ),
                accountName: Text(
                  '${user?.firstName ?? "Loading..."} ${user?.lastName ?? ""}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                accountEmail: Text(user?.email ?? ""),
              ),

              ListTile(
                leading: const Icon(Icons.cake),
                title: const Text('Age Group'),
                trailing: Text(user?.ageGroup ?? ""),
              ),
              ListTile(
                leading: const Icon(Icons.person_outline),
                title: const Text('Gender'),
                trailing: Text(user?.gender ?? ""),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.help_outline),
                title: const Text('Support & FAQ'),
                onTap: () {},
              ),

              const Spacer(),
              const Divider(),
              if (user?.role == 'admin')
                ListTile(
                  leading: const Icon(Icons.admin_panel_settings),
                  title: const Text(
                    'Admin Panel',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onTap: () async {
                    // 1. Wait for 200 milliseconds (standard delay for ripple effects)
                    await Future.delayed(const Duration(milliseconds: 200));

                    // 2. Check if the widget is still on screen before navigating
                    if (context.mounted) {
                      Navigator.pop(context);
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        RoutesName.homeScreen,
                        (route) => false,
                      );
                    }
                  },
                ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  context.read<AuthBloc>().add(SignOutEvent());
                },
              ),
              const SizedBox(height: 20), // Bottom padding
            ],
          );
        },
      ),
    );
  }
}
