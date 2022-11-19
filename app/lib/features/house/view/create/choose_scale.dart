import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:housecrush_app/features/house/domain/house.dart';
import 'package:riverpod_context/riverpod_context.dart';

import '../../../../constants/colors.dart';
import '../../../common/view/action_button.dart';
import '../../../common/view/back_button.dart';
import '../../domain/locations.dart';

class ChooseScale extends StatefulWidget {
  ChooseScale({required this.creator, required this.onScale, Key? key})
      : super(key: key);

  final HouseCreator creator;
  final void Function(double) onScale;

  @override
  State<ChooseScale> createState() => _ChooseScaleState();
}

class _ChooseScaleState extends State<ChooseScale> {
  double scale = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const GoBackButton(),
          Text(
            'Set the scale.',
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
                child: LayoutBuilder(builder: (context, constraints) {
                  return Stack(
                    children: [
                      Positioned.fill(
                        child: Image.network(
                          'https://housecrush.schultek.de/images/locations/${locations[widget.creator.location]![1]}',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned.fill(
                        child: Transform.scale(
                          scale: scale,
                          alignment: Alignment.bottomCenter,
                          origin: Offset(0, -constraints.maxHeight / 3),
                          child: Image.network(
                            'https://housecrush.schultek.de/images/buildings/${buildings[widget.creator.building]![1]}',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Slider(
            value: scale,
            min: 0.2,
            max: 3,
            onChanged: (value) {
              setState(() {
                scale = value;
              });
            },
          ),
          const SizedBox(height: 40),
          ActionButton(
            label: 'Create',
            onPressed: () async {
              widget.onScale(scale);
            },
          ),
        ],
      ),
    );
  }
}
