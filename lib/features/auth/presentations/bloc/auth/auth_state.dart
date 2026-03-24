part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final ApiResponse<dynamic> signupResponse;
  final ApiResponse<dynamic> signinResponse;
  final ApiResponse<dynamic> signOutResponse;
  final ApiResponse<dynamic> passwordResetResponse;

  const AuthState({
    required this.signupResponse,
    required this.signinResponse,
    required this.signOutResponse,
    required this.passwordResetResponse,
  });

  AuthState copyWith({
    ApiResponse<dynamic>? signupResponse,
    ApiResponse<dynamic>? signinResponse,
    ApiResponse<dynamic>? signOutResponse,
    ApiResponse<dynamic>? passwordResetResponse,
  }) {
    return AuthState(
      signupResponse: signupResponse ?? this.signupResponse,
      signinResponse: signinResponse ?? this.signinResponse,
      signOutResponse: signOutResponse ?? this.signOutResponse,
      passwordResetResponse:
          passwordResetResponse ?? this.passwordResetResponse,
    );
  }

  @override
  List<Object?> get props => [
    signupResponse,
    signinResponse,
    signOutResponse,
    passwordResetResponse,
  ];
}
