import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:housecrush_app/constants/colors.dart';
import 'package:housecrush_app/features/auth/data/auth_repository.dart';
import 'package:riverpod_context/riverpod_context.dart';

import '../../house/domain/house.dart';
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
              child: Text(
                'See what others dream of.',
                style: Theme.of(context).textTheme.displayLarge,
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

                return Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: hcDark[500],
                  ),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(
                              isLiked ? Icons.favorite : Icons.favorite_border),
                          onPressed: () {
                            context
                                .read(discoverController.notifier)
                                .likeHouse(house, !isLiked);
                          },
                        ),
                        Text(house.likes.length.toString())
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
