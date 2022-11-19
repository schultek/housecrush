import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:housecrush_app/features/auth/data/auth_repository.dart';
import 'package:housecrush_app/features/common/data/firebase_repository.dart';

final newHouseController = Provider(NewHouseController.new);


class NewHouseController {

  NewHouseController(this.ref);

  final Ref ref;

  Future<void> createNewHouse() async {

    var firestore = await ref.read(firestoreRepository.future);

    await firestore.collection('houses').add({
      'owner': ref.read(userIdRepository)!,
    });

  }

}