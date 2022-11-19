import 'package:flutter/material.dart';
import 'package:housecrush_app/features/house/domain/house.dart';

import '../../../constants/colors.dart';
import '../domain/locations.dart';
import 'render_house.dart';

class HouseCard extends StatelessWidget {
  const HouseCard({required this.house, Key? key}) : super(key: key);

  final House house;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: hcDark[200],
        ),
        child: RenderHouse(
          location: house.location,
          building: house.building,
          scale: house.scale,
          specials: house.specials,
          eco: house.eco,
        ),
      ),
    );
  }
}
