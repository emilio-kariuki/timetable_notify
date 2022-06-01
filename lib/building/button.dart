import "package:flutter/material.dart";

import 'contants.dart';

class Button extends StatelessWidget {
  final String label;
  final Function() function;
  const Button({Key? key, required this.label, required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
          height: 60,
          width: 100,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              label,
              style: subtitleStyle,
            ),
          )),
    );
  }
}
