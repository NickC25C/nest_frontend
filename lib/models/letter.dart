class Letter {
  final String id;
  final String title;
  final String text;
  final String date;
  final bool opened;
  final String originUserId;
  final String receiverUserId;

  Letter({
    required this.id,
    required this.title,
    required this.text,
    required this.date,
    required this.opened,
    required this.originUserId,
    required this.receiverUserId,
  });

  factory Letter.fromJson(Map<String, dynamic> json) {
    return Letter(
      id: json['id'],
      title: json['title'],
      text: json['text'],
      date: json['date'],
      opened: json['opened'],
      originUserId: json['originUserId'],
      receiverUserId: json['receiverUserId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'text': text,
      'date': date,
      'originUserId': originUserId,
      'receiverUserId': receiverUserId,
    };
  }
}
