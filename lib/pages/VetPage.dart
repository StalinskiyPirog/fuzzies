import 'package:flutter/material.dart';
import 'package:fuzzies/layout/drawer.dart';
import 'package:fuzzies/layout/appbar.dart';

class VetPage extends StatefulWidget {
  VetPage({Key? key}) : super(key: key);

  @override
  State<VetPage> createState() => _VetPageState();
}

class _VetPageState extends State<VetPage> {
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
