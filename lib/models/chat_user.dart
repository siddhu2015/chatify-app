class ChatUser {
  final String uid;
  final String name;
  final String email;
  final String imageURL;
  final DateTime lastActive;

  ChatUser(
      {required this.uid,
      required this.name,
      required this.email,
      required this.imageURL,
      required this.lastActive});

  factory ChatUser.fromJSON(Map<String, dynamic> _json) {
    return ChatUser(
        uid: _json['uid'],
        name: _json['name'],
        email: _json['email'],
        imageURL: _json['imageURL'],
        lastActive: _json['last_Active'].toDate());
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'imageURL': imageURL,
      'last_Active': lastActive,
    };
  }

  String lastDayActive() {
    // this is utility method
    return "${lastActive.month}/${lastActive.day}/${lastActive.year}";
  }

  bool recentlyActive() {
    return DateTime.now().difference(lastActive).inHours < 2;
  }
}
