import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fuzzies/layout/drawer.dart';
import 'package:fuzzies/layout/appbar.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

void _setAuth() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool("auth", true);
}

void _unsetAuth() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove("auth");
}

void _showLoginModal() async {}

class _AuthPageState extends State<AuthPage> with RestorationMixin {
  final isSelected = [
    RestorableBool(false),
    RestorableBool(false),
    RestorableBool(false),
  ];
  List<String> snackPhrases = [
    "Автоматический вход",
    "Краткое руководство",
    "Темная тема",
  ];
  @override
  String get restorationId => 'auth_toggle';
  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(isSelected[0], "keep");
    registerForRestoration(isSelected[1], "play_presentation");
    registerForRestoration(isSelected[2], "light_mode");
  }

  @override
  void dispose() {
    for (final restorableBool in isSelected) {
      restorableBool.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              child: Image.asset(
                "lib/assets/logo.png",
                scale: 3,
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Регистрация"),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.purple.shade400),
                minimumSize:
                    MaterialStateProperty.all<Size>(const Size(100, 50)),
                maximumSize:
                    MaterialStateProperty.all<Size>(const Size(200, 100)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                if (isSelected[0].value) {
                  _setAuth();
                } else {
                  _unsetAuth();
                }
                Navigator.pushNamed(context, "/home");
              },
              child: const Text("Войти"),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.pink[500]!),
                minimumSize:
                    MaterialStateProperty.all<Size>(const Size(100, 50)),
                maximumSize:
                    MaterialStateProperty.all<Size>(const Size(200, 100)),
              ),
            ),
            const Divider(
              color: Colors.grey,
              height: 20,
              thickness: 1,
              indent: 40,
              endIndent: 40,
            ),
            ToggleButtons(
              onPressed: (index) {
                setState(() {
                  isSelected[index].value = !isSelected[index].value;
                });
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                if (isSelected[index].value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(snackPhrases[index])));
                }
              },
              isSelected: isSelected.map((element) => element.value).toList(),
              children: const [
                Icon(Icons.lock),
                Icon(Icons.slideshow),
                Icon(Icons.nightlight),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
