import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

// TODO remove when all locations are implemented
class PlaceholderLocation extends BeamLocation<BeamState> {
  PlaceholderLocation([super.route]);

  @override
  BeamState createState(RouteInformation routeInformation) {
    return super.createState(const RouteInformation(location: '/placeholder'));
  }

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      const BeamPage(
        key: ValueKey('placeholder'),
        child: Placeholder(),
      ),
    ];
  }

  @override
  List<Pattern> get pathPatterns => ['/placeholder'];
}
