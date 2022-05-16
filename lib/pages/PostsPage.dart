import 'package:flutter/material.dart';
import 'package:fuzzies/layout/drawer.dart';
import 'package:fuzzies/layout/appbar.dart';

class PostsPage extends StatefulWidget {
  PostsPage({Key? key}) : super(key: key);

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
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
      body: GridView.builder(gridDelegate: const SliverGridDelegate, itemBuilder: itemBuilder),
    );
  }
}
