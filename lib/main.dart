import 'package:e_commerce_bloc/core/config/themes/app_themes.dart';
import 'package:e_commerce_bloc/core/routes/routes.dart';
import 'package:e_commerce_bloc/core/routes/routes_name.dart';
import 'package:e_commerce_bloc/firebase_options.dart';
import 'package:e_commerce_bloc/service_locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/auth/presentations/bloc/auth/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initializeDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => sl<AuthBloc>())],
      child: MaterialApp(
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        initialRoute: RoutesName.splashScreen,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
