import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:housecrush_app/constants/colors.dart';
import 'package:housecrush_app/features/house/data/houses_repository.dart';
import 'package:housecrush_app/features/profile/data/profile_repository.dart';
import 'package:riverpod_context/riverpod_context.dart';

import '../../profile/view/profile_button.dart';

class DesignPage extends StatelessWidget {
  const DesignPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Align(
              alignment: Alignment.centerLeft,
              child: context.watch(hasProfileRepository).valueOrNull ?? false
                  ? const ProfileButton()
                  : const SizedBox(height: 32),
            ),
          ),
          const SliverPadding(padding: EdgeInsets.only(top: 10)),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Text(
                  'Design your Dream House.',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                OutlinedButton(
                  onPressed: () {
                    context.beamToNamed('/design/new');
                  },
                  child: Text('Design'),
                ),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              (context.watch(housesRepository).valueOrNull ?? []).map((house) {
                return Container(
                  height: 100,
                  margin: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: hcDark[500],
                  ),
                  child: const Text('House'),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
