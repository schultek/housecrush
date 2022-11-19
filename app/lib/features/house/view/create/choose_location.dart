import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';
import '../../../common/view/action_button.dart';
import '../../../common/view/back_button.dart';
import '../../domain/house.dart';
import '../../domain/locations.dart';

class ChooseLocation extends StatefulWidget {
  ChooseLocation({required this.onLocation, required this.creator, Key? key})
      : super(key: key);

  final void Function(String) onLocation;
  final HouseCreator creator;

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  late PageController controller;
  String location = locations.keys.first;

  @override
  void initState() {
    controller = PageController(
        initialPage: widget.creator.location != null
            ? locations.keys.toList().indexOf(widget.creator.location!)
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
          GoBackButton(),
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
                child: Stack(
                  children: [
                    PageView(
                      controller: controller,
                      onPageChanged: (value) {
                        setState(() {
                          location = locations.keys.toList()[value];
                        });
                      },
                      children: [
                        for (var loc in locations.keys)
                          Image.network(
                            'https://housecrush.schultek.de/images/locations/${locations[loc]![1]}',
                            fit: BoxFit.cover,
                          ),
                      ],
                    ),
                    Positioned(
                      left: 0,
                      top: 0,
                      bottom: 0,
                      child: Center(
                          child: Icon(
                        Icons.keyboard_arrow_left,
                        size: 50,
                        color: hcDark[800],
                      )),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: Center(
                          child: Icon(
                        Icons.keyboard_arrow_right,
                        size: 50,
                        color: hcDark[800],
                      )),
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(
              locations[location]![0],
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
          const SizedBox(height: 40),
          ActionButton(
            label: 'Next',
            onPressed: () async {
              widget.onLocation(location);
            },
          ),
        ],
      ),
    );
  }
}
