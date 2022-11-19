import 'package:beamer/beamer.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:housecrush_app/features/house/domain/house.dart';
import 'package:riverpod_context/riverpod_context.dart';

import '../../../../constants/colors.dart';
import '../../../common/view/action_button.dart';
import '../../../common/view/back_button.dart';
import '../../domain/locations.dart';

class ChooseSpecials extends StatefulWidget {
  ChooseSpecials({required this.creator, required this.onSpecials, Key? key})
      : super(key: key);

  final HouseCreator creator;
  final void Function(List<String>) onSpecials;

  @override
  State<ChooseSpecials> createState() => _ChooseSpecialsState();
}

class _ChooseSpecialsState extends State<ChooseSpecials> {
  List<String> specials = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const GoBackButton(),
          Text(
            'Select Specials.',
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
                          scale: widget.creator.scale,
                          alignment: Alignment.bottomCenter,
                          origin: Offset(0, -constraints.maxHeight / 3),
                          child: Image.network(
                            'https://housecrush.schultek.de/images/buildings/${buildings[widget.creator.building]![1]}',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      for (var s in specials)
                        Positioned.fill(
                          child: Image.network(
                            'https://housecrush.schultek.de/images/specials/${allSpecials[s]![1]}',
                            fit: BoxFit.cover,
                          ),
                        ),
                    ],
                  );
                }),
              ),
            ),
          ),
          const SizedBox(height: 10),
          ChipsChoice<String>.multiple(
            value: specials,
            onChanged: (value) {
              setState(() {
                specials = value;
              });
            },
            choiceCheckmark: true,
            wrapped: true,
            choiceItems: allSpecials.entries
                .map((e) => C2Choice(value: e.key, label: e.value[0]))
                .toList(),
          ),
          const SizedBox(height: 40),
          ActionButton(
            label: 'Create',
            onPressed: () async {
              widget.onSpecials(specials);
            },
          ),
        ],
      ),
    );
  }
}
