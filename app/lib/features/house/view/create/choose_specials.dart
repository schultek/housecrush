import 'package:beamer/beamer.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:housecrush_app/features/house/domain/house.dart';
import 'package:riverpod_context/riverpod_context.dart';

import '../../../../constants/colors.dart';
import '../../../common/view/action_button.dart';
import '../../../common/view/back_button.dart';
import '../../domain/locations.dart';
import '../render_house.dart';

class ChooseSpecials extends StatefulWidget {
  ChooseSpecials({required this.creator, required this.onSpecials, this.back, Key? key})
      : super(key: key);

  final HouseCreator creator;
  final void Function(List<String>) onSpecials;
  final VoidCallback? back;

  @override
  State<ChooseSpecials> createState() => _ChooseSpecialsState();
}

class _ChooseSpecialsState extends State<ChooseSpecials> {
  List<String> specials = [];

  @override
  void initState() {
    specials = widget.creator.specials ?? [];
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
                child: RenderHouse(
                  location: widget.creator.location,
                  building: widget.creator.building,
                  scale: widget.creator.scale,
                  specials: specials,
                ),
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
