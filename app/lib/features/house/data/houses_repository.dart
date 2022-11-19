


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:housecrush_app/features/auth/data/auth_repository.dart';
import 'package:housecrush_app/features/common/data/firebase_repository.dart';

import '../../../main.mapper.g.dart';
import '../domain/house.dart';

final housesRepository = StreamProvider((ref) async* {
  var userId = ref.watch(userIdRepository);
  if (userId == null) {
    yield null;
    return;
  }

  var firestore = await ref.watch(firestoreRepository.future);
  yield* firestore.collection('houses').where('owner', isEqualTo: userId).snapshots().map((query) {
    return query.docs.map((doc) {
      return Mapper.fromMap<House>({...doc.data(), 'id': doc.id});
    });
  });
});