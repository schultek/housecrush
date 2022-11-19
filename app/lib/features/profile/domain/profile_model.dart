import 'package:dart_mappable/dart_mappable.dart';

import '../../../main.mapper.g.dart';

@MappableClass()
class UserProfile with Mappable {
  final String name;
  final String? profileUrl;

  UserProfile(this.name, this.profileUrl);
}
