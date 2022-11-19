import 'package:beamer/beamer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:housecrush_app/constants/colors.dart';
import 'package:housecrush_app/features/common/view/action_button.dart';
import 'package:housecrush_app/features/profile/controllers/profile_controller.dart';
import 'package:housecrush_app/features/profile/data/profile_repository.dart';
import 'package:riverpod_context/riverpod_context.dart';

import '../../common/view/back_button.dart';
import 'profile_form.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  double? currentIncome;
  double? currentSavings;
  double? expectedIncome;

  @override
  Widget build(BuildContext context) {
    var profile = context.watch(profileRepository).valueOrNull;

    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const GoBackButton(),
            Text(
              'Profile',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: 40),
            ProfileForm(
              currentIncome: profile?.currentIncome,
              currentSavings: profile?.currentSavings,
              expectedIncome: profile?.expectedIncome,
              onCurrentIncomeChanged: (double value) {
                setState(() => currentIncome = value);
              },
              onSavingsChanged: (double value) {
                setState(() => currentSavings = value);
              },
              onExpectedIncomeChanged: (double value) {
                setState(() => expectedIncome = value);
              },
            ),

            const SizedBox(height: 40),
            ActionButton(
              label: 'Save',
              onPressed: (currentIncome ?? currentSavings ?? expectedIncome) != null ? () async  {
                await context.read(profileController.notifier).updateProfile(
                    currentIncome, currentSavings, expectedIncome
                );
                context.beamBack();
              } : null,
            ),
            const SizedBox(height: 10),
            ActionButton(
              label: 'Logout',
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
            )
          ],
        ),
      ),
    ));
  }
}
