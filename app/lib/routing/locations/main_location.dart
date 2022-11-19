import 'package:beamer/beamer.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_context/riverpod_context.dart';

import '../../features/common/data/default_page_repository.dart';
import '../../features/workinstructions/view/core/workinstruction_loading_screen.dart';
import '../../generated/l10n.dart';
import '../layouts/home_layout.dart';
import '../layouts/main_layout.dart';

class MainLocation extends BeamLocation<BeamState> {
  MainLocation([super.route]);

  static List<String> pages = ['tasks', 'project', 'apps', 'qr'];

  bool get isWiOpen => state.pathPatternSegments.firstOrNull == 'wi';

  static String popToNamed(BuildContext context) {
    var index = context.read(defaultPageRepository);
    if (index == null && context.currentBeamLocation is MainLocation) {
      index = (context.currentBeamLocation as MainLocation).getPageIndex(context);
    }
    return '/${pages[index ?? 0]}';
  }

  int getPageIndex(BuildContext context) {
    var segment = state.pathPatternSegments.first;
    var index = pathPatterns.map((p) => p.toString().split('/')[1]).toList().indexOf(segment);
    return index < 4 ? index : context.read(defaultPageRepository) ?? 0;
  }

  @override
  BeamState createState(RouteInformation routeInformation) {
    var uri = Uri.tryParse(routeInformation.location ?? '');
    if (pages.contains(uri?.pathSegments.firstOrNull)) {
      return super.createState(routeInformation);
    } else if ((uri?.pathSegments.length ?? 0) > 1 && uri?.pathSegments.firstOrNull == 'wi') {
      return super.createState(routeInformation);
    } else {
      return super.createState(const RouteInformation(location: '/tasks'));
    }
  }

  String titleFor(BuildContext context, String? segment) {
    if (segment == pages[0]) {
      return S.of(context).mt_title;
    } else if (segment == pages[1]) {
      return S.of(context).mt_label;
    } else if (segment == pages[2]) {
      return S.of(context).as_title;
    } else if (segment == pages[3]) {
      return S.of(context).bs_title;
    } else {
      return S.of(context).mt_title;
    }
  }

  @override
  Widget builder(BuildContext context, Widget navigator) {
    return MainLayout(
      child: ProviderScope(
        overrides: [homePageIndexProvider.overrideWithValue(getPageIndex(context))],
        child: navigator,
      ),
    );
  }

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      BeamPage(
        key: const ValueKey('home'),
        title: titleFor(context, state.pathPatternSegments.firstOrNull),
        child: HomeLayout(),
      ),
      if (state.uri.pathSegments[0] == 'wi' && state.pathParameters['workinstructionId'] != null)
        BeamPage(
          key: ValueKey(state.uri.path),
          title: 'Workinstruction',
          child: WillPopScope(
            onWillPop: () async => false,
            child: const WorkinstructionLoadingScreen(),
          ),
          popToNamed: popToNamed(context),
        ),
    ];
  }

  @override
  List<Pattern> get pathPatterns => [...pages.map((p) => '/$p'), '/wi/:workinstructionId'];
}
