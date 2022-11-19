import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_context/riverpod_context.dart';
import 'package:stack_trace/stack_trace.dart' as stack_trace;

import 'constants/theme.dart';
import 'features/common/data/storage_repository.dart';
import 'routing/routing.dart';
import 'utils/storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Beamer.setPathUrlStrategy();
  runApp(ProviderScope(
    overrides: [
      storageSource.overrideWithValue(await getNativeStorageSource())
    ],
    child: const InheritedConsumer(child: HouseCrushApp()),
  ));
}

class HouseCrushApp extends StatelessWidget {
  const HouseCrushApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BeamerProvider(
      routerDelegate: context.watch(routerDelegateProvider),
      child: MaterialApp.router(
        title: 'HouseCrush 🏠💔',
        theme: hcTheme,
        routerDelegate: context.watch(routerDelegateProvider),
        routeInformationParser: BeamerParser(),
        backButtonDispatcher: context.watch(backButtonDispatcherProvider),
      ),
    );
  }
}
