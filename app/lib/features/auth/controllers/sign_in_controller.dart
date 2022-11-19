
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:housecrush_app/features/auth/data/auth_repository.dart';
import 'package:housecrush_app/features/common/data/device_id_repository.dart';

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

    Log.d('URI: $deviceId ($idHash)');

    var email = '$idHash@housecrush.schultek.de';
    var results = await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);

    UserCredential credential;
    if (results.isEmpty) {
      credential = await auth.createUserWithEmailAndPassword(email: email, password: deviceId);
    } else {
      credential = await auth.signInWithEmailAndPassword(email: email, password: deviceId);
    }

    await credential.user!.updateDisplayName(name);
  }
}