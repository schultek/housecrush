import 'package:beamer/beamer.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/house/view/new_house_screen.dart';
import '../../features/profile/view/profile_screen.dart';
import '../layouts/main_layout.dart';

class MainLocation extends BeamLocation<BeamState> {
  MainLocation([super.route]);

  static const List<String> pages = ['design', 'discover', 'friends'];

  int getPageIndex(BuildContext context) {
    var segment = state.pathPatternSegments.first;
    var index = pathPatterns.map((p) => p.toString().split('/')[1]).toList().indexOf(segment);
    return index < 3 ? index : 0;
  }

  @override
  BeamState createState(RouteInformation routeInformation) {
    var uri = Uri.tryParse(routeInformation.location ?? '');
    if (pages.contains(uri?.pathSegments.firstOrNull) || uri?.pathSegments.firstOrNull == 'profile') {
      return super.createState(routeInformation);
    } else {
      return super.createState(RouteInformation(location: '/${pages.first}'));
    }
  }

  String titleFor(BuildContext context, String? segment) {
    if (segment == pages[0]) {
      return 'Design your House';
    } else if (segment == pages[1]) {
      return 'Discover Houses';
    } else if (segment == pages[2]) {
      return 'Friends';
    } else {
      return 'HouseCrush';
    }
  }

  @override
  Widget builder(BuildContext context, Widget navigator) {
    return ProviderScope(
      overrides: [pageIndexProvider.overrideWithValue(getPageIndex(context))],
      child: navigator,
    );
  }

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      BeamPage(
        key: const ValueKey('main'),
        title: titleFor(context, state.pathPatternSegments.firstOrNull),
        child: MainLayout(),
      ),
      if (state.uri.pathSegments.first == 'profile')
        const BeamPage(
          key: ValueKey('profile'),
          title: 'Profile',
          child: ProfileScreen(),
        ),
      if (state.uri.path == '/design/new')
        const BeamPage(
          key: ValueKey('new_house'),
          title: 'Design a new Dream House',
          child: NewHouseScreen(),
        ),
    ];
  }

  @override
  List<Pattern> get pathPatterns => [...pages.map((p) => '/$p/*'), '/profile'];
}
