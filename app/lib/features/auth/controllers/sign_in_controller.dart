
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:housecrush_app/features/auth/data/auth_repository.dart';
import 'package:housecrush_app/features/auth/data/user_name_repository.dart';
import 'package:housecrush_app/features/common/data/device_id_repository.dart';
import 'package:housecrush_app/features/common/data/firebase_repository.dart';

import '../../../utils/logger.dart';

final signInController = NotifierProvider(SignInNotifier.new);

class SignInNotifier extends Notifier<void> {
  @override
  void build() {
    // TODO: implement build
  }

  Future<void> signIn(String name) async {
    var auth = await ref.read(authRepository.future);

    String deviceId = ref.read(deviceIdRepository)!;
    String idHash = sha1.convert(utf8.encode(deviceId)).toString();

    var email = '$idHash@housecrush.schultek.de';
    var results = await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);

    if (results.isEmpty) {
      await auth.createUserWithEmailAndPassword(email: email, password: deviceId);
    } else {
      await auth.signInWithEmailAndPassword(email: email, password: deviceId);
    }

    ref.read(userNameRepository.notifier).state = name;
  }
}