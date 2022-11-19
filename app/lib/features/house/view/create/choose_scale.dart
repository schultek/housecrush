import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:housecrush_app/features/house/domain/house.dart';
import 'package:riverpod_context/riverpod_context.dart';

import '../../../../constants/colors.dart';
import '../../../common/view/action_button.dart';
import '../../../common/view/back_button.dart';
import '../../domain/locations.dart';
import '../render_house.dart';

class ChooseScale extends StatefulWidget {
  ChooseScale({required this.creator, required this.onScale, this.back, Key? key})
      : super(key: key);

  final HouseCreator creator;
  final void Function(double) onScale;
  final VoidCallback? back;

  @override
  State<ChooseScale> createState() => _ChooseScaleState();
}

class _ChooseScaleState extends State<ChooseScale> {
  double scale = 1;


  @override
  void initState() {
    scale = widget.creator.scale ?? 1;
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
                child: RenderHouse(
                  location: widget.creator.location,
                  building: widget.creator.building,
                  scale: scale,
                  specials: widget.creator.specials,
                  eco: widget.creator.eco,
                ),
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
            label: 'Next',
            onPressed: () async {
              widget.onScale(scale);
            },
          ),
        ],
      ),
    );
  }
}
