import 'package:flutter/material.dart';
import 'package:fuzzies/layout/drawer.dart';
import 'package:fuzzies/layout/appbar.dart';

class ArchivePage extends StatefulWidget {
  ArchivePage({Key? key}) : super(key: key);

  @override
  State<ArchivePage> createState() => _ArchivePageState();
}

class _ArchivePageState extends State<ArchivePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: leftDrawer(),
      appBar: PreferredSize(
          child: ApplicationBar(title: "Архив"),
          preferredSize: Size(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.width / 4)),
    );
  }
}
