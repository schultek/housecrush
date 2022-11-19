
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../firebase_options.dart';

final firebaseRepository = FutureProvider((ref) async {
  return Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
});

final firestoreRepository = FutureProvider((ref) async {
  await ref.watch(firebaseRepository.future);
  return FirebaseFirestore.instance;
});