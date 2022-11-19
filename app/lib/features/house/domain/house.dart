


import 'dart:math';

import 'package:dart_mappable/dart_mappable.dart';

import '../../../main.mapper.g.dart';
import 'locations.dart';

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

  final String? bank;
  final double? loan;
  final double? monthlyPayment;
  final double? price;
  final double? loanYears;
  final double? waitYears;

  House({required this.id, required this.owner, this.likes = const [],
  this.location, this.building, this.scale, this.specials = const [], this.eco,
  this.bank, this.loan, this.monthlyPayment, this.price, this.loanYears, this.waitYears});

  String get description {

    var s = 'A ';

    if (scale != null) {
      if (scale! < 0.3) {
        s = 'A tiny ';
      } else if (scale! < 0.5) {
        s = 'A small ';
      } else if (scale! > 2.5) {
        s = 'An abnormally large ';
      } else if (scale! > 1.5) {
        s = 'A large ';
      }
    }

    if (eco != null) {
      if (eco! > 1) {
        if (s == 'A ') {
          s = 'An ';
        }
        s += 'eco-friendly ';
      }
    }

    if (building != null) {
      s += buildings[building]![2];
    } else {
      s += 'House';
    }

    if (location != null) {
      s += ' ${locations[location]![2]}';
    }

    if (specials.isNotEmpty) {
      s += ' with ';
      var sp = specials.map((s) => allSpecials[s]![2]);
      if (sp.length > 1) {
        s += sp.take(sp.length-1).join(', ');
        s += ' and ${sp.last}';
      } else {
        s += sp.first;
      }
      var r = Random(((scale ?? 1) * specials.length).round()).nextInt(4);
      if (r == 0) {
        s += ' in the front';
      } else if (r == 1) {
        s += ' decorating the entrance';
      } else if (r == 2) {
        s += ' welcoming guests';
      } else if (r == 3) {
        s += ' hanging around';
      }
    }

    return s;


  }

  int get score {
    if (waitYears == null) {
      return 0;
    }

    if (waitYears! >= 60) {
      return 3;
    } else if (waitYears! >= 30) {
      return 2;
    } else if (waitYears! >= 10) {
      return 1;
    }

    return 0;
  }
}

class HouseCreator {
  String? location;
  String? building;
  double? scale;
  List<String>? specials;
  int? eco;
}