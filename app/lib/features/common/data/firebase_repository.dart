
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../firebase_options.dart';

final firebaseRepository = FutureProvider((ref) async {
  return Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
});