import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:housecrush_app/features/auth/data/auth_repository.dart';
import 'package:housecrush_app/features/common/data/firebase_repository.dart';
import 'package:housecrush_app/features/house/domain/house.dart';

final houseController = Provider(HouseController.new);

class HouseController {
  HouseController(this.ref);

  final Ref ref;

  Future<void> createNewHouse(HouseCreator creator) async {
    var firestore = await ref.read(firestoreRepository.future);

    await firestore.collection('houses').add({
      'owner': ref.read(userIdRepository)!,
      'location': creator.location,
      'building': creator.building,
      'scale': creator.scale,
    });

  }

  Future<void> deleteHouse(String id) async {
    var firestore = await ref.read(firestoreRepository.future);
    await firestore.collection('houses').doc(id).delete();
  }

}