import 'package:escape_fatec/scenes/abajurpage.dart';
import 'package:escape_fatec/scenes/info.page.dart';
import 'package:escape_fatec/scenes/computer.page.dart';
import 'package:escape_fatec/scenes/livro.page.dart';
import 'package:escape_fatec/scenes/password.page.dart';
import 'package:escape_fatec/scenes/past.page.dart';
import 'package:escape_fatec/scenes/register.page.dart';
import 'package:escape_fatec/scenes/website.page.dart';
import 'package:flutter/material.dart';
import 'scenes/present.page.dart';
import 'scenes/start.page.dart';
import 'scenes/config.page.dart';
import 'scenes/login_screen.dart';
import 'scenes/livro2.page.dart';
import 'scenes/livro3.page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: false),
      routes: {
        "/start": (context) => const StartPage(),
        "/present": (context) => PresentPage(),
        "/past": (context) =>  PastPage(),
        "/config": (context) => const ConfigPage(),
        "/computer": (context) => const ComputerPage(),
        "/password": (context) => PasswordPage(),
        "/webpage": (context) => const WebpagePage(),
        "/info": (context) => const InfoPage(),
        "/livro": (context) => const TextPage(),
        "/abajur": (context) => const AbajurPage(),
        "/login":(context) => const LoginScreen(),
        "/register":(context) => RegisterScreen(),
         "/livro2":(context) => const BookPage(),
        "/livro3":(context) => const BookPage2(),
      },
      initialRoute: '/past',
    );
  }
}
