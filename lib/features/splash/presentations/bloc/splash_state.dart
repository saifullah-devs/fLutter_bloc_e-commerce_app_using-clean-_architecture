part of 'splash_bloc.dart';

abstract class SplashState extends Equatable {
  const SplashState();
  @override
  List<Object?> get props => [];
}

class DisplaySplash extends SplashState {}

class Authenticated extends SplashState {}

class UnAuthenticated extends SplashState {}
