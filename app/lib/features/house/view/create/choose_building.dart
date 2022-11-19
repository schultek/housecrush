import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:housecrush_app/features/common/view/back_button.dart';
import 'package:housecrush_app/features/house/domain/house.dart';
import 'package:riverpod_context/riverpod_context.dart';

import '../../../../constants/colors.dart';
import '../../../common/view/action_button.dart';
import '../../domain/locations.dart';
import '../render_house.dart';

class ChooseBuilding extends StatefulWidget {
  ChooseBuilding({required this.creator, required this.onBuilding, this.back, Key? key}) : super(key: key);

  final HouseCreator creator;
  final void Function(String) onBuilding;
  final VoidCallback? back;

  @override
  State<ChooseBuilding> createState() => _ChooseBuildingState();
}

class _ChooseBuildingState extends State<ChooseBuilding> {
  String building = buildings.keys.first;
  late PageController controller;


  @override
  void initState() {
    controller = PageController(
        initialPage: widget.creator.building != null
            ? buildings.keys.toList().indexOf(widget.creator.building!)
            : 0);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GoBackButton(back: widget.back),
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
                    RenderHouse(
                      location: widget.creator.location,
                    ),
                    PageView(
                      controller: controller,
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
                      child: InkWell(
                          onTap: () {
                            controller.previousPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
                          },
                          child: Icon(Icons.keyboard_arrow_left, size: 50,
                      color: hcDark[800],),),
                    ),
                  ),
                    Positioned(
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: Center(
                          child: InkWell(
                              onTap: () {
                                controller.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
                              },
                              child: Icon(Icons.keyboard_arrow_right, size: 50,
                            color: hcDark[800],),),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(
              buildings[building]![0],
              style: Theme.of(context).textTheme.displaySmall,
            ),
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
