import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:housecrush_app/features/house/view/create/choose_building.dart';
import 'package:housecrush_app/features/house/view/create/choose_location.dart';
import 'package:riverpod_context/riverpod_context.dart';

import '../controllers/house_controller.dart';
import '../domain/house.dart';
import 'create/choose_eco.dart';
import 'create/choose_scale.dart';
import 'create/choose_specials.dart';

class NewHouseScreen extends StatefulWidget {
  const NewHouseScreen({Key? key}) : super(key: key);

  @override
  State<NewHouseScreen> createState() => _NewHouseScreenState();
}

class _NewHouseScreenState extends State<NewHouseScreen> {
  int step = 0;

  HouseCreator creator = HouseCreator();

  Future<void> finish() async {
    var house = await context
        .read(houseController)
        .createNewHouse(creator);
    context.beamToReplacementNamed('/house/${house.id}', data: house);
  }


  void back() {
    if (step > 0) {
      setState(() {
        step--;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    Widget child;
    if (step == 0) {
      child = ChooseLocation(
        creator: creator,
          onLocation: (value) {
        creator.location = value;
        setState(() {
          step++;
        });
      }, back: back,);
    } else if (step == 1) {
      child = ChooseBuilding(
          creator: creator,
          onBuilding: (value) {
            creator.building = value;
            setState(() {
              step++;
            });
          }, back: back,);
    } else if (step == 2) {
      child = ChooseScale(
        creator: creator,
        onScale: (value) {
          creator.scale = value;
          setState(() {
            step++;
          });
        }, back: back,);
    } else if (step == 3) {
      child = ChooseSpecials(
        creator: creator,
        onSpecials: (value) {
          creator.specials = value;
          setState(() {
            step++;
          });
        }, back: back,);
    } else if (step == 4) {
      child = ChooseEco(
        creator: creator,
        onEco: (value) {
          creator.eco = value;
          finish();
        }, back: back,);
    } else {
      child = Container();
    }

    return WillPopScope(
      onWillPop: () async {
        if (step > 0) {
          setState(() {
            step--;
          });
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: child,
        ),
      ),
    );
  }
}
