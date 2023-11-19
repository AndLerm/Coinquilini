import 'dart:io';

import 'package:coinquilini/components/button_login.dart';
import 'package:coinquilini/components/button_register.dart';
import 'package:coinquilini/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(56, 176, 0, 1),
      body: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(height: 20),
              Text(
                "COINQUILINI",
                style: GoogleFonts.zillaSlab(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),

              // LOGO
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(0),
                child: Image.asset('lib/images/C1.png'),
              ),

              // TITOLO PAGE
              const SizedBox(height: 0),
              Text(
                "L'app che gestisce la tua casa insieme ai tuoi inquilini.",
                style: GoogleFonts.zillaSlab(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),

              // SOTTOTITOLO
              const SizedBox(height: 10),
              Text(
                "Coinquilini ti permette di organizzare programmi, attività e liste di cose da fare",
                style: GoogleFonts.zillaSlab(
                    fontSize: 12,
                    color: Color.fromARGB(255, 91, 96, 89),
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),

              // BOTTONI
              const SizedBox(height: 10),

              ButtonLogin(
                text: "Accedi",
                onTap: () {
                  Navigator.pushNamed(context, '/login_or_register');
                },
              ),

              ButtonRegister(
                text: "Iscriviti",
                onTap: () {},
                onPressed: () {},
              ),
            ],
          )),
    );
  }
}
