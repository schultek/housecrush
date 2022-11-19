import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:housecrush_app/features/auth/data/auth_repository.dart';
import 'package:housecrush_app/features/common/data/firebase_repository.dart';

final newHouseController = Provider(NewHouseController.new);


class NewHouseController {

  NewHouseController(this.ref);

  final Ref ref;

  Future<void> createNewHouse({required String location}) async {

    var firestore = await ref.read(firestoreRepository.future);

    await firestore.collection('houses').add({
      'owner': ref.read(userIdRepository)!,
      'location': location,
    });

  }

  Future<void> deleteHouse(String id) async {
    var firestore = await ref.read(firestoreRepository.future);
    await firestore.collection('houses').doc(id).delete();
  }

}