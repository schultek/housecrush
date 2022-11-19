import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_context/riverpod_context.dart';

import '../../../../constants/colors.dart';
import '../../../common/view/action_button.dart';
import '../../controllers/new_house_controller.dart';

class ChooseBuilding extends StatefulWidget {
  ChooseBuilding({required this.onLocation, Key? key}) : super(key: key);

  final void Function(String) onLocation;

  @override
  State<ChooseBuilding> createState() => _ChooseBuildingState();
}

class _ChooseBuildingState extends State<ChooseBuilding> {
  static final locations = {
    'arctic': ['In the Arctic', 'Arktis916.png'],
    'mountain': ['On a mountain', 'Berg916.png'],
    'bridge': ['Under a bridge', 'Brucke916.png'],
    'island': ['A private island', 'Insel916.png'],
    'slum': ['At the slum', 'Slum916.png'],
    'city': ['In the city', 'Stadt916.png'],
  };

  String location = locations.keys.first;

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
                  children: [PageView(
                    onPageChanged: (value) {
                      setState(() {
                        location = locations.keys.toList()[value];
                      });
                    },
                    children: [
                      for (var loc in locations.keys)
                        Image.network('https://housecrush.schultek.de/images/locations/${locations[loc]![1]}',
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
            locations[location]![0],
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const SizedBox(height: 40),
          ActionButton(
            label: 'Next',
            onPressed: () async {
              widget.onLocation('beach');
            },
          ),
        ],
      ),
    );
  }
}
