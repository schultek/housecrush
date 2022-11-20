import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:housecrush_app/constants/colors.dart';
import 'package:housecrush_app/features/auth/data/auth_repository.dart';
import 'package:riverpod_context/riverpod_context.dart';

import '../../house/domain/house.dart';
import '../../house/view/house_card.dart';
import '../controllers/discover_controller.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: RefreshIndicator(
        onRefresh: () {
          return context.refresh(discoverController.future);
        },
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SafeArea(
                child: Text(
                  'Discover what others dream of.',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
            ),
            const SliverPadding(padding: EdgeInsets.only(top: 20)),
            SliverGrid.count(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              children:
                  (context.watch(discoverController).valueOrNull ?? <House>[])
                      .map<Widget>((house) {
                var isLiked =
                    house.likes.contains(context.read(userIdRepository)!);

                return Stack(
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        context.beamToNamed('/house/${house.id}', data: house,
                        popToNamed: '/discover');
                      },
                      child: HouseCard(house: house),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: InkWell(
                          onTap: () {
                            context
                                .read(discoverController.notifier)
                                .likeHouse(house, !isLiked);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(width: 2),
                                Icon(
                                    isLiked
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: hcRed),
                                const SizedBox(width: 2),
                                Text(
                                  house.likes.length.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 4),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
