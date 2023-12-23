class User {
  final int? id;
  final String email;
  final String gender;

  User({
    this.id,
    required this.email, 
    required this.gender
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      gender: json['gender'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'gender': gender,
    };
  }
}
