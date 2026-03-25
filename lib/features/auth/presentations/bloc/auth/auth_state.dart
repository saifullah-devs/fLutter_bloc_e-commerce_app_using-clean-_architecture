part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final UserEntity? user;
  final ApiResponse<dynamic> getUserResponse;
  final ApiResponse<dynamic> signupResponse;
  final ApiResponse<dynamic> signinResponse;
  final ApiResponse<dynamic> signOutResponse;
  final ApiResponse<dynamic> passwordResetResponse;

  const AuthState({
    this.user,
    required this.getUserResponse,
    required this.signupResponse,
    required this.signinResponse,
    required this.signOutResponse,
    required this.passwordResetResponse,
  });

  AuthState copyWith({
    final UserEntity? user,
    ApiResponse<dynamic>? getUserResponse,
    ApiResponse<dynamic>? signupResponse,
    ApiResponse<dynamic>? signinResponse,
    ApiResponse<dynamic>? signOutResponse,
    ApiResponse<dynamic>? passwordResetResponse,
  }) {
    return AuthState(
      user: user ?? this.user,
      getUserResponse: getUserResponse ?? this.getUserResponse,
      signupResponse: signupResponse ?? this.signupResponse,
      signinResponse: signinResponse ?? this.signinResponse,
      signOutResponse: signOutResponse ?? this.signOutResponse,
      passwordResetResponse:
          passwordResetResponse ?? this.passwordResetResponse,
    );
  }

  @override
  List<Object?> get props => [
    user,
    getUserResponse,
    signupResponse,
    signinResponse,
    signOutResponse,
    passwordResetResponse,
  ];
}
