part of 'user_requirements_bloc.dart';

class UserRequirementsState extends Equatable {
  final String selectedGender;
  final String selectedAge;
  final String? imagePath;

  final ApiResponse<List<dynamic>>? agesResponse;
  final ApiResponse<dynamic>? signupResponse;

  const UserRequirementsState({
    this.selectedGender = 'Men',
    this.selectedAge = 'Age Range',
    this.agesResponse,
    this.signupResponse,
    this.imagePath,
  });

  UserRequirementsState copyWith({
    String? selectedGender,
    String? selectedAge,
    ApiResponse<List<dynamic>>? agesResponse,
    ApiResponse<dynamic>? signupResponse,
    String? imagePath,
  }) {
    return UserRequirementsState(
      selectedGender: selectedGender ?? this.selectedGender,
      selectedAge: selectedAge ?? this.selectedAge,
      agesResponse: agesResponse ?? this.agesResponse,
      signupResponse: signupResponse ?? this.signupResponse,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  @override
  List<Object?> get props => [
    selectedGender,
    selectedAge,
    imagePath,
    agesResponse,
    signupResponse,
  ];
}
