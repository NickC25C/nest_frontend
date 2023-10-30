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
    User u = User(
      id: 0,
      name: 'Guillem',
      lastname: 'Forr',
      username: 'Gullem98',
      password: '1234',
      mail: 'guillem@gmail.com',
      friends: [u1, u2, u3, u4],
      solicitudesPend: List<User>.empty(growable: true),
      feedPublications: List<Publication>.empty(growable: true),
      diffusionGroups: List<Group>.empty(growable: true),
      notificationActive: false,
    );

    //AMISTADES
    u2.friends!.add(u3); //anton amigo de lanza
    u3.friends!.add(u2); //lanza amigo de anton
    u2.friends!.add(u); //guillem amigo de lanza
    u3.friends!.add(u); //guillem amigo de anton
    u1.friends!.add(u); //guillem amigo de nick
    u4.friends!.add(u); //guillem amigo de ivan
    u1.friends!.add(u2); //lanza amigo de nick

    //SOLICITUDES
    u4.solicitudesPend!.add(u1);
    u4.solicitudesPend!.add(u2);

    usuarios = [u, u1, u2, u3, u4];
    loggedUser = u;
    // GRUPOS
    Group g1 = Group(
      id: 1,
      friends: [u1, u2],
      name: 'SonMisAmigos',
      owner: u,
    );
    Group g2 = Group(
      id: 2,
      friends: [u1, u2, u4],
      name: 'EllosNoSonMisAmigos',
      owner: u,
    );
    u.diffusionGroups!.add(g1);
    u.diffusionGroups!.add(g2);
  }
  void changeLoggedUser(User userToLog) {
    loggedUser = userToLog;
  }

  void addFriend(User loggUser, User userToAdd) {
    if (loggUser != userToAdd) {
      loggUser.friends!.add(userToAdd);
      userToAdd.friends!.add(loggUser);
      loggUser.solicitudesPend!.remove(userToAdd);
    } else {
      print('No puedes ser tu propio amigo soplapollas');
    }
  }

  void rejectFriend(User loggUser, User userToAdd) {
    loggUser.solicitudesPend!.remove(userToAdd);
  }

  void addPublication(User owner, PubliNoId p, List<User> users, File file) {
    for (int i = 0; i < users.length; i++) {
      if (users[i] != owner) {
        users[i].feedPublications!.add(Picture(
            id: users[i].feedPublications!.length,
            titulo: p.titulo,
            owner: p.owner,
            date: p.date,
            publiType: p.publiType,
            url: file.path,
            image: file));
      }
    }
  }

  void addNota(User owner, String titulo, List<User> users, String mensaje) {
    for (int i = 0; i < users.length; i++) {
      if (users[i] != owner) {
        users[i].feedPublications!.add(
              NotaPub(
                id: users[i].feedPublications!.length,
                titulo: titulo,
                owner: loggedUser,
                date: DateTime.now(),
                publiType: PublicationType.note,
                mensaje: mensaje,
              ),
            );
      }
    }
  }

  void addGroup(User owner, String titulo, List<String> friends) {
    List<User> listUserShared = [];
    print(friends);
    for (int i = 0; i < friends.length; i++) {
      listUserShared.add(getUserByUsername(usuarios, friends[i])!);
      print(listUserShared.length);
      print(friends.length);
    }

    owner.diffusionGroups!.add(Group(
        id: owner.diffusionGroups!.length,
        name: titulo,
        owner: owner,
        friends: listUserShared));
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

  List<Group>? getGroupsFromUserId(int userId) {
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

  bool estaEnlista(List<User> us, User u) {
    for (int i = 0; i < us.length; i++) {
      if (us[i] == u) {
        return true;
      }
    }
    return false;
  }
}
