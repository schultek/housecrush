import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_context/riverpod_context.dart';

import '../../../constants/colors.dart';
import '../controllers/new_house_controller.dart';

class NewHouseScreen extends StatelessWidget {
  const NewHouseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hcDark[800],
      body: Column(
        children: [


          OutlinedButton(
            onPressed: () async {
              await context.read(newHouseController).createNewHouse();
              context.beamToReplacementNamed('/design');
            },
            child: Text('Create'),
          ),

        ],
      ),
    );
  }
}
