part of 'user_requirements_bloc.dart';

class UserRequirementsState extends Equatable {
  final int selectedGender;
  final String selectedAge;

  final ApiResponse<List<dynamic>>? agesResponse;
  final ApiResponse<dynamic>? signupResponse;

  const UserRequirementsState({
    this.selectedGender = 1,
    this.selectedAge = 'Age Range',
    this.agesResponse,
    this.signupResponse,
  });

  UserRequirementsState copyWith({
    int? selectedGender,
    String? selectedAge,
    ApiResponse<List<dynamic>>? agesResponse,
    ApiResponse<dynamic>? signupResponse,
  }) {
    return UserRequirementsState(
      selectedGender: selectedGender ?? this.selectedGender,
      selectedAge: selectedAge ?? this.selectedAge,
      agesResponse: agesResponse ?? this.agesResponse,
      signupResponse: signupResponse ?? this.signupResponse,
    );
  }

  @override
  List<Object?> get props => [
    selectedGender,
    selectedAge,
    agesResponse,
    signupResponse,
  ];
}
