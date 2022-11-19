import 'package:flutter/material.dart';
import 'package:housecrush_app/constants/colors.dart';

class FriendsPage extends StatelessWidget {
  const FriendsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Text(
              'Your Friends.',
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              List.generate(20, (index) {
                return Container(
                  height: 100,
                  margin: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: hcDark[500],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
