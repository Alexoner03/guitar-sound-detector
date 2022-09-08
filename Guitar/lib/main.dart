import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:guitar/pages/SelectLevelAudition.dart';
import 'package:guitar/pages/login.dart';
import 'package:guitar/pages/register.dart';
import 'package:guitar/pages/video.dart';
import 'package:guitar/providers/AuthProvider.dart';
import 'package:guitar/providers/BackendProvider.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'pages/LearnAcordes.dart';
import 'pages/LearnCuerdas.dart';
import 'pages/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderApp());
}

ColorScheme defaultColorScheme = const ColorScheme(
  primary: Color.fromRGBO(7, 188, 136, 1),
  secondary: Color(0xff03DAC6),
  surface: Color(0xff181818),
  background: Color(0xff121212),
  error: Color(0xffCF6679),
  onPrimary: Color(0xff000000),
  onSecondary: Color(0xff000000),
  onSurface: Color(0xffffffff),
  onBackground: Color(0xffffffff),
  onError: Color(0xff000000),
  brightness: Brightness.dark,
);

class ProviderApp extends StatelessWidget {
  const ProviderApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
        providers : [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => BackendProvider()),
      ],
      child : const MyApp()
    );
  }
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
  FirebaseAnalyticsObserver(analytics: analytics);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    logAnalityc();

    return MaterialApp(
      navigatorObservers: <NavigatorObserver>[observer],
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: defaultColorScheme,
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/' : (context) => const LoginPage(),
        '/register' : (context) => const RegisterPage(),
        '/home' : (context) => const HomePage(),
        '/video' : (context) => const VideoPage(),
        '/cuerdas' : (context) => const LearnCuerdas(),
        '/acordes' : (context) => const LearnAcordes(),
        '/examen' : (context) => const SelectLevelAudition(),
      },
    );
  }

  void logAnalityc() async {
    await FirebaseAnalytics.instance
        .logBeginCheckout(
        value: 10.0,
        currency: 'USD',
        items: [
          AnalyticsEventItem(
              itemName: 'Socks',
              itemId: 'xjw73ndnw',
              price: 10
          ),
        ],
        coupon: '10PERCENTOFF'
    );
  }
}