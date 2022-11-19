
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/data/firebase_repository.dart';

final authRepository = FutureProvider((ref) async {
  await ref.watch(firebaseRepository.future);
  return FirebaseAuth.instance;
});

final userRepository = StreamProvider((ref) async* {
  var auth = await ref.watch(authRepository.future);
  yield* auth.userChanges();
});

final userIdRepository = Provider((ref) {
  return ref.watch(userRepository).whenOrNull<String?>(data: (user) => user?.uid);
});

final userNameRepository = Provider((ref) {
  return ref.watch(userRepository).whenOrNull<String?>(data: (user) => user?.displayName);
});

final isSignedInRepository = Provider((ref) {
  return ref.watch(userIdRepository) != null;
});
