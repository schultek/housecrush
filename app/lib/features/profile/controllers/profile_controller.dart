
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:housecrush_app/features/auth/data/auth_repository.dart';
import 'package:housecrush_app/features/common/data/firebase_repository.dart';
import 'package:housecrush_app/features/profile/data/profile_repository.dart';

final profileController = NotifierProvider(ProfileNotifier.new);

class ProfileNotifier extends Notifier<void> {
  @override
  void build() {
    // TODO: implement build
  }

  Future<void> createProfile() async {
    var doc = await ref.read(profileDocRepository.future);
    await doc!.set({
      'name': ref.read(userRepository).valueOrNull!.displayName!,
      'profileUrl': 'https://i.stack.imgur.com/YQu5k.png'
    });
  }
}