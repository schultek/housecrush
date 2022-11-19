import 'package:flutter/material.dart';
import 'package:riverpod_context/riverpod_context.dart';

import '../controllers/sign_in_controller.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  String name = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HouseCrush'),
      ),
      body: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
              hintText: 'What\'s your name?',
            ),
            onChanged: (text) {
              setState(() {
                name = text;
              });
            },
          ),
          const SizedBox(height: 10),
          OutlinedButton(
            onPressed: name.isNotEmpty ? () {
              context.read(signInController.notifier).signIn(name);
            } : null,
            child: const Text('Sign In'),
          ),
        ],
      ),
    );
  }
}
