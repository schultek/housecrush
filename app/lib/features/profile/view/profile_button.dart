import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:housecrush_app/constants/colors.dart';
import 'package:housecrush_app/features/auth/data/auth_repository.dart';
import 'package:housecrush_app/features/profile/data/profile_repository.dart';
import 'package:riverpod_context/riverpod_context.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var profile = context.watch(profileRepository).valueOrNull;
    if (profile == null) {
      return Container();
    }
    return ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Material(
          color: Theme.of(context).colorScheme.surfaceVariant,
          child: InkWell(
            onTap: () {
              context.beamToNamed('/profile');
            },
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    backgroundColor: hcDark[400],
                    radius: 10,
                    backgroundImage: NetworkImage(profile.profileUrl!),
                  ),
                  const SizedBox(width: 5),
                  Text(profile.name),
                  const SizedBox(width: 5),
                ],
              ),
            ),

        ),
      ),
    );
  }
}
