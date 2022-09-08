import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:guitar/pages/register.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/Dtos.dart';
import '../providers/AuthProvider.dart';
import '../providers/BackendProvider.dart';
import '../services/FirebaseService.dart';
import '../utils/alert.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  var rememberValue = false;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  checkLogin() async {
    final prefs = await SharedPreferences.getInstance();

    var str = prefs.getString("user");
    print(str);
    if(str != null && str.isNotEmpty){
      final bool? video = prefs.getBool('video');
      await Provider.of<BackendProvider>(context, listen: false).getByEmail(str);

      if(video != null && video){
        await Navigator.pushReplacementNamed(context, '/home');
        return;
      }

      await prefs.setBool('video', true);
      await Navigator.pushReplacementNamed(context, '/video');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
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
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  width: MediaQuery.of(context).size.width * 0.5,
                  image: const AssetImage('assets/logo.png'),
                )
              ],
            ),
            const SizedBox(
              height: 60,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    validator: (value) => EmailValidator.validate(value!)
                        ? null
                        : "Ingresa un email valido",
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Ingresa tu Email',
                      prefixIcon  : const Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 8) {
                        return 'Ingresa una contraseña valida de 8 o más letras';
                      }
                      return null;
                    },
                    maxLines: 1,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      hintText: 'Ingresa tu contraseña',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if(_formKey.currentState!.validate()){

                        var response = await FirebaseService.auth(LoginDto(email: emailController.text, password: passwordController.text));
                        final prefs = await SharedPreferences.getInstance();

                        if (response.user != null) {
                          Provider.of<AuthProvider>(context, listen: false).setUser(response.user!);

                          final bool? video = prefs.getBool('video');
                          await prefs.setString("user", response.user!.email!);
                          await Provider.of<BackendProvider>(context, listen: false).getByEmail(response.user!.email!);

                          if(video != null && video){
                            await Navigator.pushReplacementNamed(context, '/home');
                            return;
                          }
                          await prefs.setBool('video', true);
                          await Navigator.pushReplacementNamed(context, '/video');
                        }else{
                          Utils.showMyDialog(context, "Error", "credenciales incorrectas");
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                    ),
                    child: const Text(
                      'Ingresar',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Aún no te has registrado?'),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                              const RegisterPage(),
                            ),
                          );
                        },
                        child: const Text('Crear una cuenta'),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}