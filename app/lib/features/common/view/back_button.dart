import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:housecrush_app/constants/colors.dart';
import 'package:housecrush_app/features/auth/data/auth_repository.dart';
import 'package:housecrush_app/features/profile/data/profile_repository.dart';
import 'package:riverpod_context/riverpod_context.dart';

class GoBackButton extends StatelessWidget {
  const GoBackButton({this.back, Key? key}) : super(key: key);

  final VoidCallback? back;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Material(
              color: hcDark[300],
              child: InkWell(
                onTap: () {
                  if (back != null) {
                    back!();
                  } else {
                    context.beamBack();
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.arrow_back),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ),

    );
  }
}
