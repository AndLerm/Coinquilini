import 'package:flutter/material.dart';

class Mybutton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  const Mybutton({
    super.key,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        width: 250,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.green, fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ),
      ),
    );
  }
}
