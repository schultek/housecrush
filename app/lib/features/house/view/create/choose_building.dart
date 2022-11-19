import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:housecrush_app/features/house/domain/house.dart';
import 'package:riverpod_context/riverpod_context.dart';

import '../../../../constants/colors.dart';
import '../../../common/view/action_button.dart';
import '../../domain/locations.dart';

class ChooseBuilding extends StatefulWidget {
  ChooseBuilding({required this.creator, required this.onBuilding, Key? key}) : super(key: key);

  final HouseCreator creator;
  final void Function(String) onBuilding;

  @override
  State<ChooseBuilding> createState() => _ChooseBuildingState();
}

class _ChooseBuildingState extends State<ChooseBuilding> {
  String building = buildings.keys.first;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            'Choose a building.',
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
                child: Stack(
                  children: [
                    Positioned.fill(child: Image.network('https://housecrush.schultek.de/images/locations/${locations[widget.creator.location]![1]}',
                      fit: BoxFit.cover,
                    ),),
                    PageView(
                    onPageChanged: (value) {
                      setState(() {
                        building = buildings.keys.toList()[value];
                      });
                    },
                    children: [
                      for (var loc in buildings.keys)
                        Image.network('https://housecrush.schultek.de/images/buildings/${buildings[loc]![1]}',
                        fit: BoxFit.cover,
                        ),
                    ],
                  ),
                  Positioned(
                    left: 0,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: Icon(Icons.keyboard_arrow_left, size: 50,
                      color: hcDark[800],)
                    ),
                  ),
                    Positioned(
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: Center(
                          child: Icon(Icons.keyboard_arrow_right, size: 50,
                            color: hcDark[800],)
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            buildings[building]![0],
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const SizedBox(height: 40),
          ActionButton(
            label: 'Next',
            onPressed: () async {
              widget.onBuilding(building);
            },
          ),
        ],
      ),
    );
  }
}
