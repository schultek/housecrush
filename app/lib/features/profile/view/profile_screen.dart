import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:housecrush_app/constants/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: hcDark[800],
        body: Column(
          children: [
            const Center(
              child: Text('Profile'),
            ),
            OutlinedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              child: const Text('Logout'),
            )
          ],
        ));
  }
}
