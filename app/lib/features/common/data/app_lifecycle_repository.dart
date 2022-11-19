import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provides a repository to track the app lifecycle.
final appLifecycleProvider = StateNotifierProvider<AppLifecycleRepository, AppLifecycleState>((ref) {
  return AppLifecycleObserverRepository(ref);
});

typedef AppLifecycleRepository = StateNotifier<AppLifecycleState>;

/// A repository that tracks the app lifecycle through observing the [WidgetsBinding].
class AppLifecycleObserverRepository extends StateNotifier<AppLifecycleState> with WidgetsBindingObserver {
  AppLifecycleObserverRepository(this.ref)
      : super(WidgetsBinding.instance.lifecycleState ?? AppLifecycleState.resumed) {
    WidgetsBinding.instance.addObserver(this);
    ref.onDispose(() {
      WidgetsBinding.instance.removeObserver(this);
    });
  }

  final Ref ref;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    this.state = state;
    super.didChangeAppLifecycleState(state);
  }
}
