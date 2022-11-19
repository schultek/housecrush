import 'package:beamer/beamer.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/profile/view/create_profile_screen.dart';
import '../../features/profile/view/profile_screen.dart';
import '../layouts/main_layout.dart';

class CreateProfileLocation extends BeamLocation<BeamState> {
  CreateProfileLocation([super.route]);


  @override
  BeamState createState(RouteInformation routeInformation) {
      return super.createState(const RouteInformation(location: '/profile/create'));
  }

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      const BeamPage(
        key: ValueKey('create-profile'),
        title: 'Create Profile',
        child: CreateProfileScreen(),
      ),
    ];
  }

  @override
  List<Pattern> get pathPatterns => ['/profile/create'];
}
