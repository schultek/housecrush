import 'package:flutter/material.dart';
import 'package:housecrush_app/features/house/domain/house.dart';

import '../../../common/view/action_button.dart';
import '../../../common/view/back_button.dart';
import '../../domain/locations.dart';
import '../render_house.dart';

class ChooseEco extends StatefulWidget {
  ChooseEco({required this.creator, required this.onEco, this.back, Key? key})
      : super(key: key);

  final HouseCreator creator;
  final void Function(int) onEco;
  final VoidCallback? back;

  @override
  State<ChooseEco> createState() => _ChooseEcoState();
}

class _ChooseEcoState extends State<ChooseEco> {
  int eco = 0;

  @override
  void initState() {
    eco = widget.creator.eco ?? 0;
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
            'Set Eco Factor.',
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
                  specials: widget.creator.specials,
                  eco: eco,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Slider(
            value: eco.toDouble(),
            min: 0,
            max: 3,
            divisions: 3,
            onChanged: (value) {
              setState(() {
                eco = value.round();
              });
            },
          ),
          const SizedBox(height: 40),
          ActionButton(
            label: 'Create',
            onPressed: () async {
              widget.onEco(eco);
            },
          ),
        ],
      ),
    );
  }
}
