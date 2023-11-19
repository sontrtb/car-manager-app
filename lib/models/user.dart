enum Role { admin, user }

class User {
  User({
    required this.id,
    this.name,
    required this.role,
    required this.amountOfMoney,
    this.phoneNumber,
    required this.userName,
  });

  final int id;
  final String? name;
  final Role role;
  final String userName;
  final String? phoneNumber;
  final int amountOfMoney;
}

class UserLogin {
  UserLogin({required this.token, required this.user});

  final String token;
  final User user;

  factory UserLogin.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> userMap = json["user"];

    return UserLogin(
      token: json["token"],
      user: User(
        id: userMap["id"],
        role: userMap["role"] == "admin" ? Role.admin : Role.user,
        amountOfMoney: userMap["amountOfMoney"],
        name: userMap["name"],
        phoneNumber: userMap["phoneNumber"],
        userName: userMap["userName"],
      ),
    );
  }
}
