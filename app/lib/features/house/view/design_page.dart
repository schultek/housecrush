import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:housecrush_app/constants/colors.dart';
import 'package:housecrush_app/features/house/data/houses_repository.dart';
import 'package:housecrush_app/features/profile/data/profile_repository.dart';
import 'package:riverpod_context/riverpod_context.dart';

import '../../profile/view/profile_button.dart';
import '../controllers/house_controller.dart';
import 'house_card.dart';

class DesignPage extends StatelessWidget {
  const DesignPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var houses = context.watch(housesRepository).valueOrNull ?? [];

    return Scaffold(
      floatingActionButton: FloatingActionButton.large(
        onPressed: () {
          context.beamToNamed('/design/new');
        },
        backgroundColor: hcRed,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child:
                      context.watch(hasProfileRepository).valueOrNull ?? false
                          ? const ProfileButton()
                          : const SizedBox(height: 32),
                ),
                const SizedBox(height: 10),
                Text(
                  'Design your Dream House.',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(height: 20),
                if (houses.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 80),
                    child: Center(
                      child: Opacity(
                        opacity: 0.4,
                        child: Text('Add a house by cicking \'+\'',
                            style: Theme.of(context).textTheme.bodySmall),
                      ),
                    ),
                  ),
                ...houses.map((house) {
                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      context.beamToNamed('/house/${house.id}', data: house);
                    },
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 20),
                      child: Dismissible(
                        key: ValueKey(house.id),
                        direction: DismissDirection.endToStart,
                        confirmDismiss: (_) async {
                          await context
                              .read(houseController)
                              .deleteHouse(house.id);
                          return true;
                        },
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Hero(tag: 'hero-${house.id}',child: HouseCard(house: house)),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
