import 'package:flutter/material.dart';

class ButtonRegister extends StatelessWidget {
  final String text;
  const ButtonRegister({
    super.key,
    required this.text,
    required Null Function() onPressed,
    required Null Function() onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
        ));
  }
}
