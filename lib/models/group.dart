import 'package:nest_fronted/models/user.dart';

class Group{
  final int id;
  final String name;
  final User owner;
  List<User>? friends;

  Group({
    required this.id,
    required this.name,
    required this.owner,
    required this.friends,
  });
}