import 'package:beamer/beamer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:housecrush_app/features/auth/data/auth_repository.dart';
import 'package:riverpod_context/riverpod_context.dart';

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
      BeamPage(
        key: const ValueKey('placeholder'),
        child: Placeholder(
          child: Builder(
            builder: (context) {
              return Column(
                children: [
                  Text('Hello ${context.watch(userNameRepository)}'),
                  Center(
                    child: OutlinedButton(
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                      },
                      child: const Text('Logout'),
                    ),
                  ),
                ],
              );
            }
          ),
        ),
      ),
    ];
  }

  @override
  List<Pattern> get pathPatterns => ['/placeholder'];
}
