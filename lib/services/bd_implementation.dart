import 'dart:io';

import 'package:nest_fronted/models/nota.dart';
import 'package:nest_fronted/models/picture.dart';
import 'package:nest_fronted/models/publiNoId.dart';
import 'package:nest_fronted/models/publication.dart';
import 'package:nest_fronted/models/user.dart';

import '../models/group.dart';

class Bd {
  late List<User> usuarios;
  late User loggedUser;
  Bd() {
    User u = User(
      id: 0,
      name: 'Guillem',
      lastname: 'Forr',
      username: 'Gullem98',
      password: '1234',
      mail: 'guillem@gmail.com',
      friends: List<User>.empty(growable: true),
      solicitudesPend: List<User>.empty(growable: true),
      feedPublications: List<Publication>.empty(growable: true),
      diffusionGroups: List<Group>.empty(growable: true),
      notificationActive: false,
    );
    User u1 = User(
      id: 1,
      name: 'Nick',
      lastname: 'Contreras',
      username: 'NickP20',
      password: '1234',
      mail: 'nick@gmail.com',
      friends: List<User>.empty(growable: true),
      solicitudesPend: List<User>.empty(growable: true),
      feedPublications: List<Publication>.empty(growable: true),
      diffusionGroups: List<Group>.empty(growable: true),
      notificationActive: false,
    );
    User u2 = User(
      id: 2,
      name: 'Javier',
      lastname: 'Lanza',
      username: 'lanza10',
      password: '1234',
      mail: 'lanza@gmail.com',
      friends: List<User>.empty(growable: true),
      solicitudesPend: List<User>.empty(growable: true),
      feedPublications: List<Publication>.empty(growable: true),
      diffusionGroups: List<Group>.empty(growable: true),
      notificationActive: false,
    );
    User u3 = User(
      id: 3,
      name: 'Alejandro',
      lastname: 'Anton',
      username: 'Anton32',
      password: '1234',
      mail: 'AleAnton@gmail.com',
      friends: List<User>.empty(growable: true),
      solicitudesPend: List<User>.empty(growable: true),
      feedPublications: List<Publication>.empty(growable: true),
      diffusionGroups: List<Group>.empty(growable: true),
      notificationActive: false,
    );
    User u4 = User(
      id: 4,
      name: 'Ivan',
      lastname: 'Haro',
      username: 'ivanharo',
      password: '1234',
      mail: 'iavan@gmail.com',
      friends: List<User>.empty(growable: true),
      solicitudesPend: List<User>.empty(growable: true),
      feedPublications: List<Publication>.empty(growable: true),
      diffusionGroups: List<Group>.empty(growable: true),
      notificationActive: false,
    );

    usuarios = [u, u1, u2, u3, u4];
    loggedUser = u;
  }
  void changeLoggedUser(User userToLog) {
    loggedUser = userToLog;
  }

  void addFriend(User loggUser, User userToAdd) {
    loggUser.friends!.add(userToAdd);
    userToAdd.friends!.add(loggUser);
    loggUser.solicitudesPend!.remove(userToAdd);
  }

  void rejectFriend(User loggUser, User userToAdd) {
    loggUser.solicitudesPend!.remove(userToAdd);
  }

  void addPublication(User owner, PubliNoId p, List<User> users, File file) {
    List<User> usersToSend = users;
    usersToSend.remove(owner);
    for (int i = 0; i < usersToSend.length; i++) {
      usersToSend[i].feedPublications!.add(Picture(
          id: usersToSend[i].feedPublications!.length,
          titulo: p.titulo,
          owner: p.owner,
          date: p.date,
          publiType: p.publiType,
          url: file.path,
          image: file));
    }
  }

  void addNota(User owner, String titulo, List<User> users, String mensaje) {
    List<User> usersToSend = users;
    usersToSend.remove(owner);
    for (int i = 0; i < usersToSend.length; i++) {
      usersToSend[i].feedPublications!.add(
        NotaPub(
          id: usersToSend[i].feedPublications!.length,
          titulo: titulo,
          owner: loggedUser,
          date: DateTime.now(),
          publiType: PublicationType.note,
          mensaje: mensaje,
        ),
      );
    }
  }



  void enviarSolicitud(User loggUser, User userToAdd) {
    userToAdd.solicitudesPend!.add(loggUser);
  }

  User? getUserByUsername(List<User> users, String nameOfUser) {
    for (int i = 0; i < users.length; i++) {
      if (nameOfUser == users[i].username) {
        return users[i];
      }
    }
    return null;
  }

  List<Group>? getGroupsFromUserId(int userId){
    return getUserById(usuarios, userId)!.diffusionGroups;
  }

  User? getUserById(List<User> users, int idUser) {
    for (int i = 0; i < users.length; i++) {
      if (idUser == users[i].id) {
        return users[i];
      }
    }
    return null;
  }

  void toggleNotification(User loggUser) {
    loggUser.notificationActive = !loggUser.notificationActive;
  }
}
