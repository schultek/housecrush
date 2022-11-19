import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:housecrush_app/features/auth/data/auth_repository.dart';
import 'package:housecrush_app/features/common/data/firebase_repository.dart';

final houseController = Provider(HouseController.new);

class HouseController {
  HouseController(this.ref);

  final Ref ref;

  Future<void> createNewHouse({required String location, required String building}) async {
    var firestore = await ref.read(firestoreRepository.future);

    await firestore.collection('houses').add({
      'owner': ref.read(userIdRepository)!,
      'location': location,
      'building': building,
    });

  }

  Future<void> deleteHouse(String id) async {
    var firestore = await ref.read(firestoreRepository.future);
    await firestore.collection('houses').doc(id).delete();
  }

}