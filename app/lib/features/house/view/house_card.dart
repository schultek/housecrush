import 'package:flutter/material.dart';
import 'package:housecrush_app/features/house/domain/house.dart';

import '../../../constants/colors.dart';
import '../domain/locations.dart';

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
      child: Stack(
        children: [
          if (house.location != null)
            Positioned.fill(
              child: Image.network(
                'https://housecrush.schultek.de/images/locations/${locations[house.location!]![1]}',
                fit: BoxFit.cover,
              ),
            ),
        ],
      ),),
    );
  }
}
