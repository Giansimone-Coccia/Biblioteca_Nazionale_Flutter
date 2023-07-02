class Users {
  final int id;
  final String email;
  final String password;
  bool isLogged;

  Users({
    required this.id,
    required this.email,
    required this.password,
    this.isLogged = false,
  });

}
