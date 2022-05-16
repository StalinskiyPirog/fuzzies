import 'package:flutter/material.dart';

import "package:fuzzies/pages/homePageUtilitys/homePageIcons.dart";

class leftDrawer extends StatefulWidget {
  leftDrawer({Key? key}) : super(key: key);

  @override
  State<leftDrawer> createState() => _leftDrawerState();
}

class _leftDrawerState extends State<leftDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        elevation: 1,
        child: Column(
          children: [
            DrawerHeader(
              child: Container(
                color: Theme.of(context).primaryColorLight,
                height: MediaQuery.of(context).size.height / 2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12000.0),
                  child: Image.network(
                    "https://image.shutterstock.com/image-photo/handsome-unshaven-young-darkskinned-male-260nw-640011838.jpg",
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.height / 3,
                  ),
                ),
              ),
            ),
            GridView(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              children: const [
                home(),
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
          ],
        ));
  }
}
