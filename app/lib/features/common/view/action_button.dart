import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({required this.label, this.onPressed, Key? key}) : super(key: key);

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style:ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(16),
        shape: const StadiumBorder(),
        maximumSize: Size.infinite,
      ),
      onPressed: onPressed,
      child: Center(child: Text(label)),
    );
  }
}
