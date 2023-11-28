import 'dart:ui';
import 'package:coinquilini/components/button.dart';
import 'package:coinquilini/components/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  void signIn() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation(Colors.white),
        ),
      ),
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailTextController.text,
        password: passwordTextController.text,
      );

      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // LOADING
      Navigator.pop(context);
      displayMesssage(e.code);
    }
  }

  // ERROR MESSAGGIO
  void displayMesssage(String message) {
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
                Text(
                  "C O I N Q U I ┘ I N I",
                  style: GoogleFonts.zenDots(
                      color: Colors.grey[200],
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                      wordSpacing: 8),
                  textAlign: TextAlign.center,
                ),

                const Image(
                  image: AssetImage('lib/images/C1.png'),
                  width: 200,
                ),
                Text(
                  "Rieccoti!",
                  style: GoogleFonts.zenDots(
                      color: Colors.grey[200], fontSize: 15),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Inserisci la tua email e la tua password per accedere.",
                  style: GoogleFonts.zenDots(
                      color: Colors.grey[200], fontSize: 15),
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

                // BOTTONE SIGN IN
                const SizedBox(height: 20),

                Mybutton(
                  onTap: signIn,
                  text: "Accedi",
                ),

                const SizedBox(
                  height: 25,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Non sei un membro?",
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "Registrati ora",
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
