import 'package:flutter/material.dart';
import 'package:fuzzies/layout/drawer.dart';
import 'package:fuzzies/layout/appbar.dart';

import "package:fuzzies/pages/homePageUtilitys/homePageIcons.dart";

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height / 4),
          child: ApplicationBar(
            title: "Пушистики",
          )),
      backgroundColor: Theme.of(context).backgroundColor,
      body: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        children: const [
          posts(),
          map(),
          vetHelp(),
          premium(),
          favorite(),
          archive(),
          homeless(),
          settings(),
          profile(),
          messenger(),
        ],
      ),
    );
  }
}
