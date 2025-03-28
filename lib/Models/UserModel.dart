class UserModel {
  final int userId;
  final String name;
  final String surname;

  UserModel({
    required this.userId,
    required this.name,
    required this.surname,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['id'],
      name: json['name'],
      surname: json['surname'],
    );
  }
}