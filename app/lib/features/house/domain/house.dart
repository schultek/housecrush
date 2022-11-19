


import 'package:dart_mappable/dart_mappable.dart';

import '../../../main.mapper.g.dart';

@MappableClass()
class House with Mappable {

  final String id;
  final String owner;
  final List<String> likes;

  final String? location;
  final String? building;
  final double? scale;
  final List<String> specials;
  final int? eco;

  House({required this.id, required this.owner, this.likes = const [],
  this.location, this.building, this.scale, this.specials = const [], this.eco});
}

class HouseCreator {
  String? location;
  String? building;
  double? scale;
  List<String>? specials;
  int? eco;
}