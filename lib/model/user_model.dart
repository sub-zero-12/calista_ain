class UserModel {
  String email;
  String number;
  String name;

  UserModel({
    required this.name,
    required this.email,
    required this.number,

  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] as String,
      email: json['email'] as String,
      number: json['number'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'number': number,
    };
  }
}

