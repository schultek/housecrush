import 'package:beamer/beamer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:housecrush_app/routing/locations/signin_location.dart';

import 'locations/loading_location.dart';
import 'locations/placeholder_location.dart';

enum RoutingState { loading, signIn, main }

final routingStateProvider =
    StateNotifierProvider<RoutingStateNotifier, RoutingState>((ref) => RoutingStateNotifier(ref));

// TODO: connect to auth / version state providers and emit correct routing state
class RoutingStateNotifier extends StateNotifier<RoutingState> {
  RoutingStateNotifier(this.ref) : super(RoutingState.signIn) {
  }

  final Ref ref;

}

// TODO: replace placeholder locations with real locations when implemented
final locationsByStateProvider = Provider((ref) => {
      RoutingState.loading: LoadingLocation.new,
      RoutingState.signIn: SignInLocation.new,
      RoutingState.main: PlaceholderLocation.new, // MainLocation.new
    });

final routerDelegateProvider = Provider((ref) {
  var locationsByState = ref.read(locationsByStateProvider);

  var delegate = BeamerDelegate(
    locationBuilder: BeamerLocationBuilder(
      // this will select the location based on the current url / path
      beamLocations: locationsByState.values.map((l) => l()).toList(),
    ),
    guards: [
      BeamGuard(
        pathPatterns: ['/*'],
        check: (context, location) {
          var state = ref.read(routingStateProvider);
          var targetLocation = locationsByState[state]!();
          // check whether the target location is the one allowed for the current routing state
          return location.runtimeType == targetLocation.runtimeType;
        },
        beamTo: (context, from, to) {
          var state = ref.read(routingStateProvider);
          var nextLocation = to.state.routeInformation;
          if (from is SignInLocation && to is SignInLocation) {
            nextLocation = from.continueTo ?? nextLocation;
          }
          var next = locationsByState[state]!(nextLocation);
          return next;
        },
      )
    ],
  );

  // this will change the current location based on the routing state
  ref.listen(routingStateProvider, (_, s) {
    var next = locationsByState[s]!();
    if (delegate.currentBeamLocation.runtimeType != next.runtimeType) {
      delegate.beamToReplacement(next);
    }
  });

  return delegate;
});

final backButtonDispatcherProvider = Provider((ref) {
  return BeamerBackButtonDispatcher(
    delegate: ref.watch(routerDelegateProvider),
    onBack: (delegate) async {
      var location = delegate.currentBeamLocation;
      /*if (location is MainLocation && location.isWiOpen) {
        return true; // Prevents exiting wi via back button
      } else */if (delegate.navigator.canPop()) {
        return delegate.navigator.maybePop();
      } else if (delegate.canBeamBack) {
        return delegate.beamBack();
      } else {
        return true; // Prevents app from exiting via back button
      }
    },
  );
});

/// Provides the current navigation route.
final currentRouteProvider = Provider((ref) {
  var delegate = ref.watch(routerDelegateProvider);
  var route = delegate.currentBeamLocation;

  // We need to manually manage listeners and cannot use ChangeNotifierProvider
  // since we do not manage the lifecycle of the change notifiers (delegate and route).
  void listener() => ref.invalidateSelf();

  delegate.addListener(listener);
  route.addListener(listener);

  ref.onDispose(() {
    delegate.removeListener(listener);
    route.removeListener(listener);
  });

  return route;
});
