import 'package:flutter/material.dart';
import 'package:housecrush_app/features/common/view/loading_screen.dart';
import 'package:housecrush_app/features/house/controllers/house_controller.dart';
import 'package:riverpod_context/riverpod_context.dart';

import '../../common/view/back_button.dart';
import '../domain/house.dart';
import 'house_card.dart';

class HouseScreen extends StatelessWidget {
  const HouseScreen({required this.id, this.house, Key? key}) : super(key: key);

  final String id;
  final House? house;

  @override
  Widget build(BuildContext context) {
    if (house != null) {
      return buildHouseData(context, house!);
    } else {
      return FutureBuilder(
        future: context.read(houseController).loadHouse(id),
        builder: (context, data) {
          if (data.data != null) {
            return buildHouseData(context, data.data!);
          } else {
            return const LoadingScreen();
          }
        },
      );
    }
  }

  Widget buildHouseData(BuildContext context, House house) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const GoBackButton(),
                Text(
                  'Your House.',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(height: 40),
                AspectRatio(
                  aspectRatio: 1,
                  child: Hero(
                    tag: 'hero-${house.id}',
                      child: HouseCard(house: house)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
