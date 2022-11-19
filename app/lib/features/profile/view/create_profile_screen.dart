import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:housecrush_app/constants/colors.dart';
import 'package:riverpod_context/riverpod_context.dart';

import '../controllers/profile_controller.dart';

class CreateProfileScreen extends StatelessWidget {
  const CreateProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hcDark[800],
      body: Column(
        children: [
          const Center(child: Text('Create Profile')),
          OutlinedButton(
            onPressed: () async {
              await context.read(profileController.notifier).createProfile();
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }
}
