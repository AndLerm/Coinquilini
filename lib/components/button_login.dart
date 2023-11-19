import 'package:flutter/material.dart';

class ButtonLogin extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const ButtonLogin({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(
              color: Color.fromRGBO(55, 134, 15, 1),
              borderRadius: BorderRadius.circular(40)),
          padding: EdgeInsets.all(10),
          width: 250,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(width: 10),

              // icon Bottone
              Icon(Icons.arrow_forward, color: Colors.white)
            ],
          )),
    );
  }
}
