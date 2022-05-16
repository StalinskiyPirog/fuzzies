import 'package:flutter/material.dart';

class posts extends StatelessWidget {
  const posts({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pushNamed(context, "/posts");
        },
        icon: const Icon(Icons.newspaper));
  }
}

class messenger extends StatelessWidget {
  const messenger({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pushNamed(context, "/mes");
        },
        icon: const Icon(Icons.message));
  }
}

class map extends StatelessWidget {
  const map({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pushNamed(context, "/map");
        },
        icon: const Icon(Icons.map));
  }
}

class vetHelp extends StatelessWidget {
  const vetHelp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pushNamed(context, "/vetHelp");
        },
        icon: const Icon(Icons.local_hospital));
  }
}

class premium extends StatelessWidget {
  const premium({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pushNamed(context, "/premium");
      },
      icon: const Icon(Icons.attach_money),
    );
  }
}

class favorite extends StatelessWidget {
  const favorite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pushNamed(context, "/favorite");
        },
        icon: const Icon(Icons.favorite_outlined));
  }
}

class home extends StatelessWidget {
  const home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pushNamed(context, "/home");
        },
        icon: const Icon(Icons.house));
  }
}

class archive extends StatelessWidget {
  const archive({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pushNamed(context, "/archive");
        },
        icon: const Icon(Icons.archive));
  }
}

class homeless extends StatelessWidget {
  const homeless({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pushNamed(context, "/homeless");
        },
        icon: const Icon(Icons.home_outlined));
  }
}

class settings extends StatelessWidget {
  const settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pushNamed(context, "/settings");
        },
        icon: const Icon(Icons.settings));
  }
}

class profile extends StatelessWidget {
  const profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pushNamed(context, "/profile");
        },
        icon: const Icon(Icons.person));
  }
}
