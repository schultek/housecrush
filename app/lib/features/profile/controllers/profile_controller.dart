import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:housecrush_app/features/auth/data/auth_repository.dart';
import 'package:housecrush_app/features/auth/data/user_name_repository.dart';
import 'package:housecrush_app/features/common/data/firebase_repository.dart';
import 'package:housecrush_app/features/profile/data/profile_repository.dart';

final profileController = NotifierProvider(ProfileNotifier.new);

class ProfileNotifier extends Notifier<void> {
  @override
  void build() {
    // TODO: implement build
  }

  Future<void> createProfile(
      {required double currentIncome,
      required double currentSavings,
      required double expectedIncome}) async {
    var doc = await ref.read(profileDocRepository.future);
    await doc!.set({
      'name': ref.read(userNameRepository)!,
      'profileUrl': 'https://housecrush.schultek.de/images/spidy.jpeg',
      'currentIncome': currentIncome,
      'currentSavings': currentSavings,
      'expectedIncome': expectedIncome,
    });
  }

  Future<void> updateProfile(double? currentIncome, double? currentSavings,
      double? expectedIncome) async {
    var doc = await ref.read(profileDocRepository.future);
    await doc!.update({
      if (currentIncome != null) 'currentIncome': currentIncome,
      if (currentSavings != null) 'currentSavings': currentSavings,
      if (expectedIncome != null) 'expectedIncome': expectedIncome,
    });
  }
}
