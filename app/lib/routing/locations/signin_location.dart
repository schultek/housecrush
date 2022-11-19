import 'package:beamer/beamer.dart';
import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';

import '../../features/signin/view/signin_screen.dart';

class SignInLocation extends BeamLocation<BeamState> {
  SignInLocation([super.route]);

  RouteInformation? continueTo;

  @override
  BeamState createState(RouteInformation routeInformation) {
    var uri = Uri.tryParse(routeInformation.location ?? '');
    if (uri?.pathSegments.firstOrNull == 'signin') {
      return super.createState(routeInformation);
    } else {
      continueTo = routeInformation;
      return super.createState(const RouteInformation(location: '/signin'));
    }
  }

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      const BeamPage(
        title: 'Sign In',
        key: ValueKey('signin'),
        child: SignInScreen(),
      ),
    ];
  }

  @override
  List<Pattern> get pathPatterns => ['/signin'];
}
