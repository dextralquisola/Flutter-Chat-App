import 'dart:convert';

class Chat {
  final String chat;
  final String author;
  final String timeStamp;

  Chat({
    required this.chat,
    required this.author,
    required this.timeStamp,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'chat': chat});
    result.addAll({'author': author});
    result.addAll({'timeStamp': timeStamp});

    return result;
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      chat: map['chat'] ?? '',
      author: map['author'] ?? '',
      timeStamp: map['timeStamp'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  //factory Chat.fromJson(String source) => Chat.fromMap(json.decode(source));

  factory Chat.fromJson(Map<String, dynamic> data) {
    return Chat(
      chat: data['chat'],
      author: data['author'],
      timeStamp: data['timeStamp'],
    );
  }
}
