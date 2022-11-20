import 'package:flutter/material.dart';
import 'package:housecrush_app/constants/colors.dart';
import 'package:housecrush_app/features/auth/data/user_name_repository.dart';
import 'package:housecrush_app/features/common/view/action_button.dart';
import 'package:riverpod_context/riverpod_context.dart';

import '../../../constants/theme.dart';
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
      backgroundColor: hcRed,
      body: Theme(
        data: hcThemeDark,
        child: Builder(
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(40),
                    child: Image.network(
                        'https://housecrush.schultek.de/images/HouseCrushSchriftzugZweizeiligWeiss.png'),
                  ),
                  const SizedBox(height: 100),
                  TextFormField(
                    initialValue: name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      hintText: 'What\'s your name?',
                    ),
                    onChanged: (text) {
                      setState(() {
                        name = text;
                      });
                    },
                  ),
                  const SizedBox(height: 30),
                  ActionButton(
                    label: 'Get Started',
                    onPressed: name.isNotEmpty
                        ? () {
                            context.read(signInController.notifier).signIn(name);
                          }
                        : null,
                  ),
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
