import 'package:flutter/material.dart';
import 'package:fuzzies/layout/drawer.dart';
import 'package:fuzzies/layout/appbar.dart';

class HomelessPage extends StatefulWidget {
  HomelessPage({Key? key}) : super(key: key);

  @override
  State<HomelessPage> createState() => _HomelessPageState();
}

class _HomelessPageState extends State<HomelessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: leftDrawer(),
      appBar: PreferredSize(
        child: ApplicationBar(
          title: "Новости",
        ),
        preferredSize: Size(MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height / 10),
      ),
    );
  }
}
