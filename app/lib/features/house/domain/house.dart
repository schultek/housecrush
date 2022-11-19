


import 'package:dart_mappable/dart_mappable.dart';

import '../../../main.mapper.g.dart';

@MappableClass()
class House with Mappable {

  final String id;
  final String owner;
  final List<String> likes;

  House({required this.id, required this.owner, this.likes = const []});
}