class User {
  final String id;
  final String name;
  final String lastname;
  final String username;
  final String password;
  final String mail;
  final bool enableNotifications;

  User(
      {required this.id,
      required this.name,
      required this.lastname,
      required this.username,
      required this.password,
      required this.mail,
      required this.enableNotifications});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        name: json['name'],
        lastname: json['lastname'],
        username: json['username'],
        password: json['password'],
        mail: json['mail'],
        enableNotifications : json['enableNotifications']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'lastname': lastname,
      'username': username,
      'password': password,
      'mail': mail,
      'enableNotifications': enableNotifications
    };
  }
}
