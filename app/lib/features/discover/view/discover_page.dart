
import 'package:flutter/material.dart';
import 'package:housecrush_app/constants/colors.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child:
          Text('See what others dream of.', style: Theme.of(context).textTheme.displayLarge,),
          ),
          const SliverPadding(padding: EdgeInsets.only(top: 20)),
          SliverGrid.count(crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            children: List.generate(20, (index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: hcDark[500],
                ),
              );
            })
          ),
        ],
      ),
    );
  }
}
