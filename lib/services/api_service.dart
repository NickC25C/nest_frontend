import 'dart:convert';
import 'dart:io';
import 'package:nest_fronted/models/publication.dart';
import 'package:nest_fronted/models/user.dart';
import 'package:http/http.dart' as http;

import '../models/note.dart';
import '../models/picture.dart';

class ApiService {
  final String baseUrl =
      'http://10.0.2.2:8080'; // para el movil es 192.168.1.59; para el emulador 10.0.2.2:8080
  late User loggedUser;

  static final ApiService _instance = ApiService._internal();

  factory ApiService() {
    return _instance;
  }

  ApiService._internal();

  //
  // USER
  //

  Future<List<User>> getUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/users'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception('Error al obtener usuarios');
    }
  }

  Future<User> getUser(String userId) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$userId'));

    if (response.statusCode == 200) {
      Map<String, dynamic> userData = json.decode(response.body);
      return User.fromJson(userData);
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<User> getUserByUsername(String username) async {
    final response = await http.get(
      Uri.parse('$baseUrl/users/username/$username'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      User user = User.fromJson(data);
      return user;
    } else if (response.statusCode == 404) {
      throw Exception('User not found');
    } else {
      return User(
          id: '', name: '', lastname: '', username: '', password: '', mail: '');
    }
  }

  Future<User> createUser(User user) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);
      return User.fromJson(responseData);
    } else {
      throw Exception('Failed to create user');
    }
  }

  Future<User> updateUser(String userId, User user) async {
    final response = await http.put(
      Uri.parse('$baseUrl/users/$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);
      return User.fromJson(responseData);
    } else {
      throw Exception('Failed to update user');
    }
  }

  Future<void> deleteUser(String userId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/users/$userId'),
    );

    if (response.statusCode == 204) {
      return;
    } else {
      throw Exception('Failed to delete user');
    }
  }

  Future<List<User>> getUserFriends(String userId) async {
    final response =
        await http.get(Uri.parse('$baseUrl/users/$userId/friends'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception('Error getting user friends: ${response.statusCode}');
    }
  }

  Future<User> addFriend(String id, String friendId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users/$id/friends?friendId=$friendId'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      User user = User.fromJson(data);
      return user;
    } else {
      throw Exception('Failed to add a friend: ${response.statusCode}');
    }
  }

  Future<User> deleteFriend(String id, String friendId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/users/$id/friends?friendId=$friendId'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);
      return User.fromJson(responseData);
    } else {
      throw Exception('Failed to delete a friend: ${response.statusCode}');
    }
  }

  //
  // IMAGE
  //

  Future<void> uploadImage(File image, String description) async {
    final url = Uri.parse("$baseUrl/publications/picture");
    Picture picture = Picture(
        id: 'noid',
        owner: loggedUser,
        date: DateTime.now(),
        publiType: PublicationType.picture,
        description: description,
        url: null,
        image: image);

    var request = http.MultipartRequest('POST', url);
    request.fields.addAll(
        picture.toJson().map((key, value) => MapEntry(key, value.toString())));
    request.files.add(await http.MultipartFile.fromPath('file', image.path));

    var response = await request.send();

    if (response.statusCode == 200) {
      print("Image uploaded successfully");
    } else {
      print("Image not uploaded, error code: ${response.statusCode} ");
    }
  }

  Future<List<Publication>> getFeed(String userId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/publications/$userId/feed'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = await json.decode(response.body);
      List<Publication> feed = List.empty(growable: true);
      await Future.wait(data.map((element) async {
        await getUser(element['ownerId']
                .toString()
                .replaceAll("(", "")
                .replaceAll(")", ""))
            .then((value) => feed.add(Publication.fromJson(element, value)));
      }));
      return feed;
    } else {
      throw Exception('Failed to load feed: ${response.statusCode}');
    }
  }

  Future<Publication> getPublicationById(String id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/publications/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      User? us;
      List<dynamic> datas = json.decode(response.body);
      getUser(datas
              .map((item) => item['ownerId'])
              .toString()
              .replaceAll("(", "")
              .replaceAll(")", ""))
          .then((value) => us = value)
          .whenComplete(() => null);
      Publication publication = Publication.fromJson(data, us!);
      return publication;
    } else {
      throw Exception('Failed to load publication: ${response.statusCode}');
    }
  }

  Future<Note> createNote(Note n) async {
    final response = await http.post(
      Uri.parse('$baseUrl/publications/note'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(n.toJson()),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      User us = await getUser(
          data['ownerId'].toString().replaceAll("(", "").replaceAll(")", ""));
      Note note = Note.fromJson(data, us);
      return note;
    } else {
      throw Exception('Failed to create note: ${response.statusCode}');
    }
  }

  Future<String> postRequest(String id, String friendId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users/$id/friends/request?friendId=$friendId'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return json.toString();
    } else {
      throw Exception('Failed to send request: ${response.statusCode}');
    }
  }

  Future<List<User>> getRequests(String userId) async {
    final response =
        await http.get(Uri.parse('$baseUrl/users/$userId/friends/requests'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception('Error al obtener usuarios');
    }
  }
}
