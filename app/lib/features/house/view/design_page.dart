import 'package:flutter/material.dart';
import 'package:housecrush_app/constants/colors.dart';

import '../../profile/view/profile_button.dart';

class DesignPage extends StatelessWidget {
  const DesignPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child:
                Align(alignment: Alignment.centerLeft, child: ProfileButton(),),
          ),
          const SliverPadding(padding: EdgeInsets.only(top: 10)),
          SliverToBoxAdapter(
            child: Text(
              'Design your Dream House.',
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
