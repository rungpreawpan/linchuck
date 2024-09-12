class UserModel {
  int? id;
  String? employeeId;
  String? firstname;
  String? lastname;
  String? email;
  String? password;
  String? role;
  String? image;
  String? createOn;
  String? updateOn;
  String? lastLogin;

  UserModel({
    this.id,
    this.employeeId,
    this.firstname,
    this.lastname,
    this.email,
    this.password,
    this.role,
    this.image,
    this.createOn,
    this.updateOn,
    this.lastLogin,
  });

  factory UserModel.fromJSON(Map<String, dynamic> json) {
    return UserModel(
      id: json['user_id'] ?? 0,
      employeeId: json['uuid'] ?? '',
      firstname: json['firstname'] ?? '',
      lastname: json['lastname'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      role: json['role'] ?? '',
      image: json['image'] ?? '',
      createOn: json['create_on'] ?? '',
      updateOn: json['update_on'] ?? '',
      lastLogin: json['last_login'] ?? '',
    );
  }
}
