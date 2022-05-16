import 'package:flutter/material.dart';

class ApplicationBar extends StatefulWidget {
  final String title;
  ApplicationBar({Key? key, required this.title}) : super(key: key);

  @override
  State<ApplicationBar> createState() => _ApplicationBarState();
}

class _ApplicationBarState extends State<ApplicationBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        widget.title,
        style: Theme.of(context).textTheme.bodyText2,
      ),
      backgroundColor: Theme.of(context).primaryColorLight,
    );
  }
}
