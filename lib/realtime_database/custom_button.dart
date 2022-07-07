import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final GestureTapCallback? onTap;
  final bool change;
  final String text;

  final Widget? child;

  const CustomButton({
    this.child,
    this.onTap,
    this.change = false,
    this.text = "",
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: change ? Colors.grey.shade400 : Colors.blue,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Center(
            child: Text(text,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: change ? Colors.black : Colors.white)),
          ),
        ),
      ),
    );
  }
}
