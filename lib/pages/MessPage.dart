import 'dart:ffi';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:fuzzies/layout/drawer.dart';
import 'package:fuzzies/layout/appbar.dart';
import "package:fuzzies/data/messModels.dart";
import 'package:fuzzies/pages/MessPageUtilitys/chatList.dart';
//*------------------------Функции UI c вызовом "виджетов"----------------------

final search = TextEditingController();
Widget searchBox(BuildContext context) {
  return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: search,
        decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search),
            label: Text("Введите название чата")),
        onChanged: (text) {
          return;
        },
      ),
      height: MediaQuery.of(context).size.height / 10);
}

//*!-------------------Главная часть--------------------------------------------
class MessengerPage extends StatefulWidget {
  const MessengerPage({Key? key}) : super(key: key);

  @override
  _MessengerPageState createState() => _MessengerPageState();
}

class _MessengerPageState extends State<MessengerPage> {
  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < 2; i++) {
      chats[i].newMessage(
          "1", "Привет, это тестовое сообщение", "14.05.2022", "15:03");
      chats[i].newMessage(
          "2", "Привет, это тестовое сообщение", "15.05.2022", "13:03");
    }
    return Scaffold(
      drawer: leftDrawer(),
      appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height / 10),
          child: ApplicationBar(
            title: "Мессенджер",
          )),
      backgroundColor: Theme.of(context).backgroundColor,
      body: ListView.separated(
        shrinkWrap: true,
        itemCount: chats.length,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, i) {
          return OpenContainer(
              useRootNavigator: true,
              closedBuilder: (context, action) {
                return ListTile(
                  title: Text(chats[i].chatName),
                  subtitle: Text(
                      "${chats[i].messages.last.sender}: ${chats[i].messages.last.text}"),
                  leading: CircleAvatar(
                    child: Image.asset(chats[i].image),
                    backgroundColor: Colors.white,
                  ),
                );
              },
              openBuilder: (context, action) {
                return ChatBody(chat: chats[i]);
              });
        },
      ),
    );
  }
}
//*-----------------------------------------------------------------------------