import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_context/riverpod_context.dart';

import '../../../../constants/colors.dart';
import '../../../common/view/action_button.dart';
import '../../controllers/new_house_controller.dart';

class ChooseLocation extends StatelessWidget {
  const ChooseLocation({required this.onLocation, Key? key}) : super(key: key);

  final void Function(String) onLocation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            'Choose a location.',
            style: Theme.of(context).textTheme.displayLarge,
          ),
          const SizedBox(height: 40),
          Expanded(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(blurRadius: 20, color: Colors.black12),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  color: hcDark[200],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Private Island',
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const SizedBox(height: 40),
          ActionButton(
            label: 'Next',
            onPressed: () async {
              onLocation('beach');
            },
          ),
        ],
      ),
    );
  }
}
