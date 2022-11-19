import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:housecrush_app/features/house/view/create/choose_location.dart';
import 'package:riverpod_context/riverpod_context.dart';

import '../controllers/new_house_controller.dart';

class NewHouseScreen extends StatefulWidget {
  const NewHouseScreen({Key? key}) : super(key: key);

  @override
  State<NewHouseScreen> createState() => _NewHouseScreenState();
}

class _NewHouseScreenState extends State<NewHouseScreen> {

  int step = 0;

  String? location;

  Future<void> finish() async {
    await context.read(newHouseController).createNewHouse();
    context.beamToReplacementNamed('/design');
  }

  @override
  Widget build(BuildContext context) {

    Widget child;
    if (step == 0) {
      child = ChooseLocation(onLocation: (value) {
        location = value;
        setState(() {
          step++;
        });
      });
    } else {
      child = Container();
    }

    return Scaffold(
      body: SafeArea(
        child: child,
      ),
    );
  }
}
