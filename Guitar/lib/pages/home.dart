import 'package:flutter/material.dart';
import 'package:guitar/providers/BackendProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    @override
    Widget build(BuildContext context) {
      return Scaffold(
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .background,

          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/fondo.png"),
                fit: BoxFit.cover,
              ),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: _getColum(),
            ),
          )
      );
    }

    List<Widget> _getColum() {
      return [
        const Text(
          'Selecciona que quieres aprender',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40,
          ),
        ),
        const SizedBox(
          height: 60,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/video');
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
          ),
          child: const Text(
            'Ver Tutorial',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 60,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/cuerdas');
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
          ),
          child: const Text(
            'Cuerdas al Aire',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 60,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/acordes');
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
          ),
          child: const Text(
            'Acordes',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 60,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/examen');
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
          ),
          child: const Text(
            'Mide tu audición!',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 60,
        ),
        ElevatedButton(
          onPressed: () async {
            final prefs = await SharedPreferences.getInstance();
            await prefs.remove("user");
            await Provider.of<BackendProvider>(context, listen: false).clear();
            Navigator.pushReplacementNamed(context, '/');
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
          ),
          child: const Text(
            'Cerrar Sesión',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ];
    }
}