
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:housecrush_app/features/auth/data/auth_repository.dart';
import 'package:housecrush_app/features/profile/domain/profile_model.dart';

import '../../../main.mapper.g.dart';
import '../../common/data/firebase_repository.dart';

final profileDocRepository = FutureProvider((ref) async {
  var userId = ref.watch(userIdRepository);
  if (userId == null) {
    return null;
  }
  var firestore = await ref.watch(firestoreRepository.future);
  return firestore.collection('users').doc(userId);
});

final profileRepository = StreamProvider<UserProfile?>((ref) async* {
  var doc = await ref.watch(profileDocRepository.future);
  if (doc == null) {
    yield null;
    return;
  }
  yield* doc.snapshots().map((doc) {
    if (!doc.exists) return null;
    return Mapper.fromValue<UserProfile>(doc.data());
  });
});

final hasProfileRepository = FutureProvider((ref) async {
  var profile = await ref.watch(profileRepository.future);
  return profile != null;
});