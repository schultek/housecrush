import 'package:flutter/material.dart';
import 'package:housecrush_app/constants/colors.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hcRed,
      body: Padding(
        padding: const EdgeInsets.all(80),
        child: Center(
          child: Image.network('https://housecrush.schultek.de/images/HouseCrushSchriftzugZweizeiligWeiss.png'),
        ),
      ),
    );
  }
}
