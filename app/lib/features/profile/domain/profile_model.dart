import 'package:dart_mappable/dart_mappable.dart';

import '../../../main.mapper.g.dart';

@MappableClass()
class UserProfile with Mappable {
  final String name;
  final String? profileUrl;

  final double? currentIncome;
  final double? currentSavings;
  final double? expectedIncome;

  UserProfile(this.name, this.profileUrl, this.currentIncome, this.currentSavings, this.expectedIncome);
}
