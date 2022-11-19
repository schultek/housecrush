

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:housecrush_app/features/auth/data/auth_repository.dart';
import 'package:housecrush_app/features/common/data/firebase_repository.dart';

import '../../../main.mapper.g.dart';
import '../../house/domain/house.dart';

final discoverController = AsyncNotifierProvider<DiscoverController, List<House>>(DiscoverController.new);


class DiscoverController extends AsyncNotifier<List<House>> {

  @override
  FutureOr<List<House>> build() async {
    var userId = ref.watch(userIdRepository);
    if (userId == null) {
      return <House>[];
    }

    var firestore = await ref.watch(firestoreRepository.future);
    var query = await firestore
        .collection('houses')
        .where('owner', isNotEqualTo: userId)
        .get();

    return query.docs.map((doc) {
      return Mapper.fromMap<House>({...doc.data(), 'id': doc.id});
    }).sortedBy<num>((house) => house.likes.length).reversed.toList();
  }

  Future<void> likeHouse(House house, [bool like = true]) async {
    var firestore = await ref.read(firestoreRepository.future);

    var houses = state.valueOrNull;
    if (houses == null) return;

    var userId = ref.read(userIdRepository)!;

    if (like) {
      house.likes.add(userId);
    } else {
      house.likes.remove(userId);
    }

    state = state;

    await firestore.collection('houses').doc(house.id).update({
      'likes': like ? FieldValue.arrayUnion([userId]) : FieldValue.arrayRemove([userId]),
    });
  }


}