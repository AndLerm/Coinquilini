import 'package:coinquilini/auth/login_or_register.dart';
import 'package:coinquilini/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'pages/intro_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginOrRegister(),
      routes: {},
    );
  }
}
