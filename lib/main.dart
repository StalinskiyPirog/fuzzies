import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:flutter/services.dart";

import "package:fuzzies/ui/theme.dart";

import "package:fuzzies/pages/HomePage.dart";
import "package:fuzzies/pages/ArchivePage.dart";
import "package:fuzzies/pages/AuthPage.dart";
import "package:fuzzies/pages/MapPage.dart";
import "package:fuzzies/pages/FavoritePage.dart";
import "package:fuzzies/pages/HomelessPage.dart";
import "package:fuzzies/pages/MessPage.dart";
import "package:fuzzies/pages/PostsPage.dart";
import "package:fuzzies/pages/PremiumPage.dart";
import "package:fuzzies/pages/VetPage.dart";
import "package:fuzzies/pages/ProfilePage.dart";
import "package:fuzzies/pages/SettingsPage.dart";

var secondaryTheme = ThemeData();

bool auth = false;

void main() {
  runApp(const Main());
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  initState() {
    super.initState();
    _auth().then((j) {
      setState(() {
        auth = j;
      });
    });
  }

  Future<bool> _auth() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("auth") ?? false;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MainTheme,
      home: auth ? const HomePage() : const AuthPage(),
      routes: {
        "/home": (context) => const HomePage(),
        "/auth": (context) => const AuthPage(),
        "/map": (context) => MapPage(),
        "/mes": (context) => const MessengerPage(),
        "/posts": (context) => PostsPage(),
        "/vetHelp": (context) => VetPage(),
        "/premium": (context) => PremiumPage(),
        "/favorite": (context) => FavoritePage(),
        "/archive": (context) => ArchivePage(),
        "/homeless": (context) => HomelessPage(),
        "/profile": (context) => ProfilePage(),
        "/settings": (context) => SettingsPage(),
      },
    );
  }
}
