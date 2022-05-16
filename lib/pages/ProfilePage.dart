import 'package:flutter/material.dart';
import 'package:fuzzies/layout/drawer.dart';
import 'package:fuzzies/layout/appbar.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
