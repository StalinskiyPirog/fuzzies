import "package:flutter/material.dart";
import "package:fuzzies/pages/MessPageUtilitys/chatList.dart";
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:fuzzies/data/messModels.dart';

//?------------------Взаимодействия с бд (CRUD) юзеров--------------------------
void newMessage(String chatId, String userId, String messageText) {
  return;
}

//*------------------------Функции UI c вызовом "виджетов"----------------------
Widget rightChatPanel(BuildContext context, String img) {
  return Drawer(
    child: ListView(padding: EdgeInsets.zero, children: [
      DrawerHeader(
          decoration: const BoxDecoration(
            color: Colors.blue,
          ),
          child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 4),
              child: Expanded(
                flex: 9,
                child: CircleAvatar(
                    backgroundImage: AssetImage(img),
                    minRadius: 20,
                    maxRadius: 40),
              ))),
      ListTile(
        title: const Text(''),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      ListTile(
        title: const Text('Подробности платных проектов'),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      ListTile(
        title: const Text('Другое'),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    ]),
  );
}

PreferredSizeWidget chatAppBar(BuildContext context, String title) {
  return AppBar(
    title: Text(title),
    actions: const [
      CircleAvatar(
        child: Image(
          image: AssetImage("lib/assets/avatar.jpg"),
        ),
      ),
    ],
    leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back)),
  );
}

Widget sidePanel(BuildContext context, Chat chat) {
  return Builder(
    builder: (BuildContext context) {
      return CircleAvatar(
          backgroundImage: AssetImage(chat.image),
          minRadius: 20,
          maxRadius: 40);
    },
  );
}

//?----------------------------Главная часть виджетов---------------------------
TextEditingController messageInputController = TextEditingController();
//*----------------------------Ввод сообщения-----------------------------------
Widget _inputField(BuildContext context) {
  return Align(
    child: TextFormField(
      controller: messageInputController,
      decoration: InputDecoration(
        hintText: "Введите сообщение",
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.elliptical(20, 20)),
            borderSide: BorderSide(color: Colors.black26, width: 3)),
        enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.elliptical(20, 20)),
            borderSide: BorderSide(color: Colors.black45, width: 1)),
        prefixIcon: IconButton(
          icon: const Icon(Icons.attach_file),
          onPressed: () {},
        ),
        suffixIcon: IconButton(
          icon: const Icon(Icons.send),
          onPressed: () {
            newMessage("1", "Current user", messageInputController.text);
          },
        ),
      ),
    ),
    alignment: Alignment.bottomCenter,
  );
}

//*------------------------Генерируемый список сообщений------------------------
Widget _chatBody(BuildContext context, Chat chat) {
  return ListView.builder(
      itemCount: chat.messages.length,
      itemBuilder: (context, i) {
        return BubbleNormal(
          text: "${chat.messages[i].sender}\n${chat.messages[i].text}",
          isSender: i % 2 != 0,
          tail: true,
          color: i % 2 != 0 ? Colors.purple.shade200 : Colors.black,
          textStyle: const TextStyle(
            color: Colors.white,
          ),
          delivered: true,
        );
      });
}

//*-----------------------------------------------------------------------------
class ChatBody extends StatefulWidget {
  final chat;
  const ChatBody({Key? key, required this.chat}) : super(key: key);

  @override
  _ChatBodyState createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawer: sidePanel(context, widget.chat),
        appBar: chatAppBar(context, widget.chat.chatName),
        body: Stack(
          children: [_chatBody(context, widget.chat), _inputField(context)],
        ));
  }
}
