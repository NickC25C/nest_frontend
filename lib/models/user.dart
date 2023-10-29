import 'dart:ffi';

import 'package:nest_fronted/models/publication.dart';

class User {
  final int id;
  final String name;
  final String lastname;
  final String username;
  final String password;
  final String mail;
  List<User>? friends;
  List<User>? solicitudesPend;
  List<Publication>? feedPublications;
  bool notificationActive;

  User(
      {required this.id,
      required this.name,
      required this.lastname,
      required this.username,
      required this.password,
      required this.mail,
      required this.friends,
      required this.solicitudesPend,
      required this.feedPublications,
      required this.notificationActive});
}
