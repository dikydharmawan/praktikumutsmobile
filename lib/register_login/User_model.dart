class UserModel {
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });

  static void clear() {}
}

class UserAuth {
  static final List<UserModel> _users = [];
  
  static void registerUser(UserModel user) {
    if (_users.any((u) => u.email == user.email)) {
      throw Exception('Email sudah terdaftar');
    }
    _users.add(user);
  }
  
  static bool loginUser(String email, String password) {
    return _users.any((user) => 
      user.email == email && user.password == password
    );
  }
  
  static UserModel? getCurrentUser(String email) {
    return _users.firstWhere((user) => user.email == email);
  }
  
  static bool isEmailValid(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
  
  static bool isPasswordValid(String password) {
    return RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$').hasMatch(password);
  }
  
}