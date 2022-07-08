import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  final color;
  final textColor;
  final String buttonText;
  final onPressed;

  Buttons(
      {this.color, this.textColor, required this.buttonText, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: isOperator(buttonText)
                ? Color(0xff4B5EFC)
                : isFirstRow(buttonText)
                    ? Color(0xffD2D3DA)
                    : color,
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(
                  fontSize: 24,
                  color: isOperator(buttonText) ? Colors.white : textColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '+' || x == '-' || x == 'X' || x == '/' || x == '=') {
      return true;
    } else {
      return false;
    }
  }

  bool isFirstRow(String x) {
    if (x == 'C' || x == 'DEL' || x == '%') {
      return true;
    } else {
      return false;
    }
  }
}
