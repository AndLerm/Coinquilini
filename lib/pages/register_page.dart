import 'dart:ui';
import 'package:coinquilini/components/button.dart';
import 'package:coinquilini/components/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();

  void signUp() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation(Colors.white),
        ),
      ),
    );

    if (passwordTextController.text != confirmPasswordTextController.text) {
      Navigator.pop(context);

      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                icon: const Icon(Icons.error),
                iconColor: Colors.grey[500],
                title: const Text('Email non valida'),
                titleTextStyle: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 18,
                ),
              ));
      return;
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailTextController.text,
          password: passwordTextController.text);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(56, 176, 0, 1),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(
                  image: AssetImage('lib/images/C1.png'),
                  width: 200,
                ),
                Text(
                  "Eccoti! Crea il tuo profilo e gestisci la tua casa con i tuoi inquilini.",
                  style: TextStyle(color: Colors.grey[700]),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(
                  height: 20,
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
                const SizedBox(
                  height: 10,
                ),

                MyTextField(
                  controller: confirmPasswordTextController,
                  hintText: 'Conferma password',
                  obscureText: true,
                ),

                // BOTTONE SIGN UP
                const SizedBox(height: 20),

                Mybutton(
                  onTap: signUp,
                  text: "Registrati",
                ),

                const SizedBox(
                  height: 25,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Hai già un account?",
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "Accedi!",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.greenAccent,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
