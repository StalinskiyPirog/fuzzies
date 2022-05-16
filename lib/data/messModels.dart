import 'package:yandex_mapkit/yandex_mapkit.dart';

class Message {
  Map<String, dynamic> toMap(self) {
    return {'id': id, 'sender': sender, 'text': text};
  }

  final String id;
  final String sender;
  final String receiver;
  final String date;
  final String time;
  final String text;
  Message(
      {required this.id,
      required this.sender,
      required this.receiver,
      required this.text,
      required this.date,
      required this.time});
}

class Chat {
  //final String? password;
  final List<String> membersId;
  final String chatName;
  final String id;
  final String image;
  List<Message> messages = [];

  void newMessage(sender, text, date, time) {
    messages.add(Message(
        id: messages.length.toString(),
        sender: sender,
        receiver: id,
        text: text,
        date: date,
        time: time));
  }

  void deleteMessage() {
    messages.removeLast();
  }

  void addMember(id) {
    membersId.add(id);
  }

  Chat(this.membersId, this.image, this.chatName, this.id);
}

List<Chat> chats = [
  Chat(
    ["1", "2"],
    'lib/assets/avatar.jpg',
    "Пироги",
    "0",
  ),
  Chat(
    ["1"],
    'lib/assets/avatar.jpg',
    "Влад",
    "2",
  )
];
