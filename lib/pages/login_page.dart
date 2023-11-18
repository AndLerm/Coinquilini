import 'package:coinquilini/components/button.dart';
import 'package:coinquilini/components/text_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(56, 176, 0, 1),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              children: [
                const SizedBox(height: 0),
                SizedBox(child: Image.asset('lib/images/C1.png'), height: 200),
                Text("message"),
                const SizedBox(
                  height: 30,
                ),
                // RICHIESTA EMAIL
                MyTextField(
                  controller: emailTextController,
                  hintText: 'Email',
                  obscureText: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                // RICHIESTA PASSWORD
                MyTextField(
                  controller: passwordTextController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                // BOTTONE SIGN IN
                const SizedBox(height: 20),

                Mybutton(onTap: () {}, text: "Accedi")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
