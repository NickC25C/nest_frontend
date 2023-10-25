import 'package:nest_fronted/models/user.dart';

enum PublicationType {
  note,
  picture,
  song
}

class Publication {
  final int id;
  final User owner;
  final DateTime date;
  final PublicationType publiType;

  Publication({required this.id, required this.owner, required this.date, required this.publiType});

  factory Publication.fromJson(Map<String, dynamic> json) {
    return Publication(
        id: json['id'],
        owner: json['owner'],
        date: json['date'],
        publiType: json['publiType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'owner': owner,
      'date': date,
      'publiType': publiType
    };
  }
}
