import 'package:flutter/material.dart';

import '../domain/locations.dart';

class RenderHouse extends StatelessWidget {
  const RenderHouse(
      {this.location,
      this.building,
      this.scale,
      this.specials,
      this.eco,
      Key? key})
      : super(key: key);

  final String? location;
  final String? building;
  final double? scale;
  final List<String>? specials;
  final int? eco;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        children: [
          if (location != null)
            Positioned.fill(
              child: Image.network(
                'https://housecrush.schultek.de/images/locations/${locations[location]![1]}',
                fit: BoxFit.cover,
              ),
            ),
          if (building != null)
            Positioned.fill(
              child: Transform.scale(
                scale: scale ?? 1,
                alignment: Alignment.bottomCenter,
                origin: Offset(0, -constraints.maxHeight / 3),
                child: Image.network(
                  'https://housecrush.schultek.de/images/buildings/${buildings[building]![1]}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          if (specials != null)
            for (var s in specials!)
              Positioned.fill(
                child: Image.network(
                  'https://housecrush.schultek.de/images/specials/${allSpecials[s]![1]}',
                  fit: BoxFit.cover,
                ),
              ),
          if (eco != null && eco! > 0)
            for (var i in List.generate(eco!, (index) => index))
              Positioned.fill(
                child: Image.network(
                  'https://housecrush.schultek.de/images/eco/${ecos[i]![1]}',
                  fit: BoxFit.cover,
                ),
              ),
        ],
      );
    });
  }
}
