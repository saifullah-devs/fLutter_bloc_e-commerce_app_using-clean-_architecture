part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class SignupEvent extends AuthEvent {
  final UserCreationReq userReq;
  const SignupEvent(this.userReq);

  @override
  List<Object?> get props => [userReq];
}

class SigninEvent extends AuthEvent {
  final String email;
  final String password;
  const SigninEvent({required this.email, required this.password});
}

class SendPasswordResetEmailEvent extends AuthEvent {
  final String email;
  const SendPasswordResetEmailEvent({required this.email});
}

class SignOutEvent extends AuthEvent {}
