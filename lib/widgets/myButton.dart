import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {

  final String buttonText;
  final color;
  final onTap;


  MyButton({required this.buttonText, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: color,
            child: Center(
              child: Text(buttonText, style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w400),),
            ),
          ),
        ),
      ),
    );
  }
}
