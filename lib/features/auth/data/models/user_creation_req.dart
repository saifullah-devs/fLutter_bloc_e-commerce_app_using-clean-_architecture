class UserCreationReq {
  String? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? gender;
  String? age;
  String? image;

  UserCreationReq({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.gender,
    this.age,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'gender': gender,
      'age': age,
      'image': image,
    };
  }
}
