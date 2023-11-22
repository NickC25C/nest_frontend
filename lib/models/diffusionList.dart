class DiffusionList {
  final String id;
  final String name;
  final String ownerId;
  final List<String> friendsIds;

  DiffusionList({
    required this.id,
    required this.name,
    required this.ownerId,
    required this.friendsIds,
  });

  factory DiffusionList.fromJson(Map<String, dynamic> json) {
    return DiffusionList(
      id: json['id'],
      name: json['name'],
      ownerId: json['ownerId'],
      friendsIds: json['friendsIds'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'ownerId': ownerId,
      'friendsIds': friendsIds,
    };
  }
}