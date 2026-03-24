part of 'user_requirements_bloc.dart';

abstract class UserRequirementsEvent extends Equatable {
  const UserRequirementsEvent();
  @override
  List<Object?> get props => [];
}

class SelectGenderEvent extends UserRequirementsEvent {
  final int genderIndex;
  const SelectGenderEvent(this.genderIndex);
  @override
  List<Object?> get props => [genderIndex];
}

class SelectAgeEvent extends UserRequirementsEvent {
  final String age;
  const SelectAgeEvent(this.age);
  @override
  List<Object?> get props => [age];
}

class DisplayAgesEvent extends UserRequirementsEvent {}
