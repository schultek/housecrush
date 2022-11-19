import 'package:flutter/material.dart';
import 'package:housecrush_app/constants/colors.dart';

class FriendsPage extends StatelessWidget {
  const FriendsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SafeArea(
              child: Padding(
        padding: const EdgeInsets.all(20),
    child: Text(
                'Your Friends.',
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              List.generate(20, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                height: 100,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: hcDark[500],
                  ),
                );
              }),
            ),
          ),
        ],

    );
  }
}
