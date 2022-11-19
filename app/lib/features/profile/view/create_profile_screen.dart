import 'dart:math';

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:housecrush_app/constants/colors.dart';
import 'package:housecrush_app/features/auth/data/user_name_repository.dart';
import 'package:riverpod_context/riverpod_context.dart';

import '../controllers/profile_controller.dart';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({Key? key}) : super(key: key);

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {

   double currentIncomeLog = 4;

  double get currentIncome {
    var value = pow(10, currentIncomeLog).toDouble();
    if (value < 1000) {
      value = (value/100).roundToDouble() * 100;
    } else if (value < 10000) {
      value = (value / 1000).roundToDouble() * 1000;
    } else if (value < 100000) {
      value = (value / 10000).roundToDouble() * 10000;
    } else {
      value = (value / 100000).roundToDouble() * 100000;
    }
    return value;
  }

  String format(double v) {
    var s = v.round().toString();
    var l = s.length;
    if (l > 3) s = '${s.substring(0, l-3)}.${s.substring(l-3)}';
    if (l > 6) s = '${s.substring(0, l-6)}.${s.substring(l-6)}';
    return s;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hcDark[800],
      body: Column(
        children: [
          Text('Hello ${context.watch(userNameRepository)}'),

          const SizedBox(height: 20),
          const Text('Current yearly income'),

          Slider(
            value: currentIncomeLog,
            min: 3,
            max: 6,
            onChanged: (value) {
              setState(() {
                currentIncomeLog = value;
              });
            },
          ),

          Text('${format(currentIncome)}€'),

          const SizedBox(height: 20),

          OutlinedButton(
            onPressed: () async {
              await context.read(profileController.notifier).createProfile(
                currentIncome: currentIncome,

              );
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }
}
