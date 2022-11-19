import 'dart:math';

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:housecrush_app/constants/colors.dart';
import 'package:housecrush_app/features/auth/data/user_name_repository.dart';
import 'package:housecrush_app/features/profile/view/profile_form.dart';
import 'package:riverpod_context/riverpod_context.dart';

import '../../common/view/action_button.dart';
import '../controllers/profile_controller.dart';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({Key? key}) : super(key: key);

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  double currentIncome = 10000;
  double currentSavings = 1000;
  double expectedIncome = 100000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome, ${context.watch(userNameRepository)}',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(height: 20),
                const Text(
                    'Before you can design your house, fill out some info:'),
                const SizedBox(height: 80),
                ProfileForm(
                  currentIncome: currentIncome,
                  currentSavings: currentSavings,
                  expectedIncome: expectedIncome,
                  onCurrentIncomeChanged: (v) {
                    setState(() => currentIncome = v);
                  },
                  onSavingsChanged: (v) {
                    setState(() => currentSavings = v);
                  },
                  onExpectedIncomeChanged: (v) {
                    setState(() => expectedIncome = v);
                  },
                ),
                const SizedBox(height: 40),
                ActionButton(
                  label: 'Create Profile',
                  onPressed: () async {
                    await context
                        .read(profileController.notifier)
                        .createProfile(
                          currentIncome: currentIncome,
                          currentSavings: currentSavings,
                          expectedIncome: expectedIncome,
                        );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
