import 'package:nest_fronted/models/user.dart';

class Letter {
  final String id;
  final String title;
  final String text;
  final DateTime date;
  final bool opened;
  final User origin;
  final User receiver;

  Letter({
    required this.id,
    required this.title,
    required this.text,
    required this.date,
    required this.opened,
    required this.origin,
    required this.receiver,
  });

  factory Letter.fromJson(Map<String, dynamic> json) {
    return Letter(
      id: json['id'],
      title: json['title'],
      text: json['text'],
      date: DateTime.parse(json['date']),
      opened: json['opened'],
      origin: User.fromJson(json['origin']),
      receiver: User.fromJson(json['receiver']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'text': text,
      'date': date.toIso8601String(),
      'opened': opened,
      'origin': origin.toJson(),
      'receiver': receiver.toJson(),
    };
  }
}
