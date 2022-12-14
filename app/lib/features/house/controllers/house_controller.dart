import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:housecrush_app/features/auth/data/auth_repository.dart';
import 'package:housecrush_app/features/common/data/firebase_repository.dart';
import 'package:housecrush_app/features/house/domain/house.dart';

import '../../../main.mapper.g.dart';

final houseController = Provider(HouseController.new);

class HouseController {
  HouseController(this.ref);

  final Ref ref;

  Future<House> createNewHouse(HouseCreator creator) async {
    var firestore = await ref.read(firestoreRepository.future);

    var data = {
      'owner': ref.read(userIdRepository)!,
      'location': creator.location,
      'building': creator.building,
      'scale': creator.scale,
      'specials': creator.specials,
      'eco': creator.eco,
    };
    var doc = await firestore.collection('houses').add(data);

    return Mapper.fromMap<House>({...data, 'id': doc.id});
  }

  Future<void> deleteHouse(String id) async {
    var firestore = await ref.read(firestoreRepository.future);
    await firestore.collection('houses').doc(id).delete();
  }

  Future<House?> loadHouse(String id) async {
    var firestore = await ref.read(firestoreRepository.future);
    var doc = await firestore.collection('houses').doc(id).get();
    if (!doc.exists) {
      return null;
    }
    return Mapper.fromMap<House>({...?doc.data(), 'id': doc.id});
  }
}

final houseWithLoanController = StreamProvider.family((ref, String id) async* {
  var firestore = await ref.read(firestoreRepository.future);

  yield* firestore.collection('houses').doc(id).snapshots().map((doc) {
    return doc.exists ? Mapper.fromMap<House>({...doc.data()!, 'id': doc.id}) : null;
  }).where((house) => house != null && house.loan != null).map((d) {
    return d;
  });
});
