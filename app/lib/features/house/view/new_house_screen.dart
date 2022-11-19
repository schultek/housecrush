import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:housecrush_app/features/common/view/action_button.dart';
import 'package:riverpod_context/riverpod_context.dart';

import '../../../constants/colors.dart';
import '../controllers/new_house_controller.dart';

class NewHouseScreen extends StatelessWidget {
  const NewHouseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                'Choose a location.',
                style: Theme.of(context).textTheme.displayLarge,
              ),


              ActionButton(label: 'Create',
                onPressed: () async {
                  await context.read(newHouseController).createNewHouse();
                  context.beamToReplacementNamed('/design');
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
