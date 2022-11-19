import 'package:flutter/material.dart';
import 'package:housecrush_app/features/auth/data/user_name_repository.dart';
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
  void initState() {
    super.initState();
    name = context.read(userNameRepository) ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HouseCrush'),
      ),
      body: Column(
        children: [
          if (context.watch(userNameRepository)?.isEmpty ?? true)
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
            onPressed: name.isNotEmpty
                ? () {
                    context.read(signInController.notifier).signIn(name);
                  }
                : null,
            child: const Text('Sign In'),
          ),
        ],
      ),
    );
  }
}
