part of 'splash_bloc.dart';

abstract class SplashState extends Equatable {
  const SplashState();
  @override
  List<Object?> get props => [];
}

class DisplaySplash extends SplashState {}

class Authenticated extends SplashState {
  final bool isAdmin;

  const Authenticated({required this.isAdmin});

  @override
  List<Object> get props => [isAdmin];
}

class UnAuthenticated extends SplashState {}
