import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import '../../features/common/view/loading_screen.dart';

class LoadingLocation extends BeamLocation<BeamState> {
  LoadingLocation([super.route]);

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      const BeamPage(
        key: ValueKey('loading'),
        child: LoadingScreen(),
      ),
    ];
  }

  @override
  List<Pattern> get pathPatterns => [''];
}
