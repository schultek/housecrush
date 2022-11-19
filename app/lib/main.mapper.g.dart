import 'package:dart_mappable/dart_mappable.dart';
import 'package:dart_mappable/internals.dart';

import 'features/house/domain/house.dart';
import 'features/profile/domain/profile_model.dart';


// === ALL STATICALLY REGISTERED MAPPERS ===

var _mappers = <BaseMapper>{
  // class mappers
  UserProfileMapper._(),
  HouseMapper._(),
  // enum mappers
  // custom mappers
};


// === GENERATED CLASS MAPPERS AND EXTENSIONS ===

class UserProfileMapper extends BaseMapper<UserProfile> {
  UserProfileMapper._();

  @override Function get decoder => decode;
  UserProfile decode(dynamic v) => checked(v, (Map<String, dynamic> map) => fromMap(map));
  UserProfile fromMap(Map<String, dynamic> map) => UserProfile(Mapper.i.$get(map, 'name'), Mapper.i.$getOpt(map, 'profileUrl'), Mapper.i.$getOpt(map, 'currentIncome'), Mapper.i.$getOpt(map, 'currentSavings'), Mapper.i.$getOpt(map, 'expectedIncome'));

  @override Function get encoder => (UserProfile v) => encode(v);
  dynamic encode(UserProfile v) => toMap(v);
  Map<String, dynamic> toMap(UserProfile u) => {'name': Mapper.i.$enc(u.name, 'name'), 'profileUrl': Mapper.i.$enc(u.profileUrl, 'profileUrl'), 'currentIncome': Mapper.i.$enc(u.currentIncome, 'currentIncome'), 'currentSavings': Mapper.i.$enc(u.currentSavings, 'currentSavings'), 'expectedIncome': Mapper.i.$enc(u.expectedIncome, 'expectedIncome')};

  @override String stringify(UserProfile self) => 'UserProfile(name: ${Mapper.asString(self.name)}, profileUrl: ${Mapper.asString(self.profileUrl)}, currentIncome: ${Mapper.asString(self.currentIncome)}, currentSavings: ${Mapper.asString(self.currentSavings)}, expectedIncome: ${Mapper.asString(self.expectedIncome)})';
  @override int hash(UserProfile self) => Mapper.hash(self.name) ^ Mapper.hash(self.profileUrl) ^ Mapper.hash(self.currentIncome) ^ Mapper.hash(self.currentSavings) ^ Mapper.hash(self.expectedIncome);
  @override bool equals(UserProfile self, UserProfile other) => Mapper.isEqual(self.name, other.name) && Mapper.isEqual(self.profileUrl, other.profileUrl) && Mapper.isEqual(self.currentIncome, other.currentIncome) && Mapper.isEqual(self.currentSavings, other.currentSavings) && Mapper.isEqual(self.expectedIncome, other.expectedIncome);

  @override Function get typeFactory => (f) => f<UserProfile>();
}

extension UserProfileMapperExtension  on UserProfile {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  UserProfileCopyWith<UserProfile> get copyWith => UserProfileCopyWith(this, $identity);
}

abstract class UserProfileCopyWith<$R> {
  factory UserProfileCopyWith(UserProfile value, Then<UserProfile, $R> then) = _UserProfileCopyWithImpl<$R>;
  $R call({String? name, String? profileUrl, double? currentIncome, double? currentSavings, double? expectedIncome});
  $R apply(UserProfile Function(UserProfile) transform);
}

class _UserProfileCopyWithImpl<$R> extends BaseCopyWith<UserProfile, $R> implements UserProfileCopyWith<$R> {
  _UserProfileCopyWithImpl(UserProfile value, Then<UserProfile, $R> then) : super(value, then);

  @override $R call({String? name, Object? profileUrl = $none, Object? currentIncome = $none, Object? currentSavings = $none, Object? expectedIncome = $none}) => $then(UserProfile(name ?? $value.name, or(profileUrl, $value.profileUrl), or(currentIncome, $value.currentIncome), or(currentSavings, $value.currentSavings), or(expectedIncome, $value.expectedIncome)));
}

class HouseMapper extends BaseMapper<House> {
  HouseMapper._();

  @override Function get decoder => decode;
  House decode(dynamic v) => checked(v, (Map<String, dynamic> map) => fromMap(map));
  House fromMap(Map<String, dynamic> map) => House(id: Mapper.i.$get(map, 'id'), owner: Mapper.i.$get(map, 'owner'), likes: Mapper.i.$getOpt(map, 'likes') ?? const [], location: Mapper.i.$getOpt(map, 'location'), building: Mapper.i.$getOpt(map, 'building'), scale: Mapper.i.$getOpt(map, 'scale'), specials: Mapper.i.$getOpt(map, 'specials') ?? const [], eco: Mapper.i.$getOpt(map, 'eco'), bank: Mapper.i.$getOpt(map, 'bank'), loan: Mapper.i.$getOpt(map, 'loan'), monthlyPayment: Mapper.i.$getOpt(map, 'monthlyPayment'), price: Mapper.i.$getOpt(map, 'price'), loanYears: Mapper.i.$getOpt(map, 'loanYears'), waitYears: Mapper.i.$getOpt(map, 'waitYears'));

  @override Function get encoder => (House v) => encode(v);
  dynamic encode(House v) => toMap(v);
  Map<String, dynamic> toMap(House h) => {'id': Mapper.i.$enc(h.id, 'id'), 'owner': Mapper.i.$enc(h.owner, 'owner'), 'likes': Mapper.i.$enc(h.likes, 'likes'), 'location': Mapper.i.$enc(h.location, 'location'), 'building': Mapper.i.$enc(h.building, 'building'), 'scale': Mapper.i.$enc(h.scale, 'scale'), 'specials': Mapper.i.$enc(h.specials, 'specials'), 'eco': Mapper.i.$enc(h.eco, 'eco'), 'bank': Mapper.i.$enc(h.bank, 'bank'), 'loan': Mapper.i.$enc(h.loan, 'loan'), 'monthlyPayment': Mapper.i.$enc(h.monthlyPayment, 'monthlyPayment'), 'price': Mapper.i.$enc(h.price, 'price'), 'loanYears': Mapper.i.$enc(h.loanYears, 'loanYears'), 'waitYears': Mapper.i.$enc(h.waitYears, 'waitYears')};

  @override String stringify(House self) => 'House(id: ${Mapper.asString(self.id)}, owner: ${Mapper.asString(self.owner)}, likes: ${Mapper.asString(self.likes)}, location: ${Mapper.asString(self.location)}, building: ${Mapper.asString(self.building)}, scale: ${Mapper.asString(self.scale)}, specials: ${Mapper.asString(self.specials)}, eco: ${Mapper.asString(self.eco)}, bank: ${Mapper.asString(self.bank)}, loan: ${Mapper.asString(self.loan)}, monthlyPayment: ${Mapper.asString(self.monthlyPayment)}, price: ${Mapper.asString(self.price)}, loanYears: ${Mapper.asString(self.loanYears)}, waitYears: ${Mapper.asString(self.waitYears)})';
  @override int hash(House self) => Mapper.hash(self.id) ^ Mapper.hash(self.owner) ^ Mapper.hash(self.likes) ^ Mapper.hash(self.location) ^ Mapper.hash(self.building) ^ Mapper.hash(self.scale) ^ Mapper.hash(self.specials) ^ Mapper.hash(self.eco) ^ Mapper.hash(self.bank) ^ Mapper.hash(self.loan) ^ Mapper.hash(self.monthlyPayment) ^ Mapper.hash(self.price) ^ Mapper.hash(self.loanYears) ^ Mapper.hash(self.waitYears);
  @override bool equals(House self, House other) => Mapper.isEqual(self.id, other.id) && Mapper.isEqual(self.owner, other.owner) && Mapper.isEqual(self.likes, other.likes) && Mapper.isEqual(self.location, other.location) && Mapper.isEqual(self.building, other.building) && Mapper.isEqual(self.scale, other.scale) && Mapper.isEqual(self.specials, other.specials) && Mapper.isEqual(self.eco, other.eco) && Mapper.isEqual(self.bank, other.bank) && Mapper.isEqual(self.loan, other.loan) && Mapper.isEqual(self.monthlyPayment, other.monthlyPayment) && Mapper.isEqual(self.price, other.price) && Mapper.isEqual(self.loanYears, other.loanYears) && Mapper.isEqual(self.waitYears, other.waitYears);

  @override Function get typeFactory => (f) => f<House>();
}

extension HouseMapperExtension  on House {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  HouseCopyWith<House> get copyWith => HouseCopyWith(this, $identity);
}

abstract class HouseCopyWith<$R> {
  factory HouseCopyWith(House value, Then<House, $R> then) = _HouseCopyWithImpl<$R>;
  $R call({String? id, String? owner, List<String>? likes, String? location, String? building, double? scale, List<String>? specials, int? eco, String? bank, double? loan, double? monthlyPayment, double? price, double? loanYears, double? waitYears});
  $R apply(House Function(House) transform);
}

class _HouseCopyWithImpl<$R> extends BaseCopyWith<House, $R> implements HouseCopyWith<$R> {
  _HouseCopyWithImpl(House value, Then<House, $R> then) : super(value, then);

  @override $R call({String? id, String? owner, List<String>? likes, Object? location = $none, Object? building = $none, Object? scale = $none, List<String>? specials, Object? eco = $none, Object? bank = $none, Object? loan = $none, Object? monthlyPayment = $none, Object? price = $none, Object? loanYears = $none, Object? waitYears = $none}) => $then(House(id: id ?? $value.id, owner: owner ?? $value.owner, likes: likes ?? $value.likes, location: or(location, $value.location), building: or(building, $value.building), scale: or(scale, $value.scale), specials: specials ?? $value.specials, eco: or(eco, $value.eco), bank: or(bank, $value.bank), loan: or(loan, $value.loan), monthlyPayment: or(monthlyPayment, $value.monthlyPayment), price: or(price, $value.price), loanYears: or(loanYears, $value.loanYears), waitYears: or(waitYears, $value.waitYears)));
}


// === GENERATED ENUM MAPPERS AND EXTENSIONS ===




// === GENERATED UTILITY CODE ===

class Mapper {
  Mapper._();

  static MapperContainer i = MapperContainer(_mappers);

  static T fromValue<T>(dynamic value) => i.fromValue<T>(value);
  static T fromMap<T>(Map<String, dynamic> map) => i.fromMap<T>(map);
  static T fromIterable<T>(Iterable<dynamic> iterable) => i.fromIterable<T>(iterable);
  static T fromJson<T>(String json) => i.fromJson<T>(json);

  static dynamic toValue(dynamic value) => i.toValue(value);
  static Map<String, dynamic> toMap(dynamic object) => i.toMap(object);
  static Iterable<dynamic> toIterable(dynamic object) => i.toIterable(object);
  static String toJson(dynamic object) => i.toJson(object);

  static bool isEqual(dynamic value, Object? other) => i.isEqual(value, other);
  static int hash(dynamic value) => i.hash(value);
  static String asString(dynamic value) => i.asString(value);

  static void use<T>(BaseMapper<T> mapper) => i.use<T>(mapper);
  static BaseMapper<T>? unuse<T>() => i.unuse<T>();
  static void useAll(List<BaseMapper> mappers) => i.useAll(mappers);

  static BaseMapper<T>? get<T>([Type? type]) => i.get<T>(type);
  static List<BaseMapper> getAll() => i.getAll();
}

mixin Mappable implements MappableMixin {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);

  @override
  String toString() {
    return _guard(() => Mapper.asString(this), super.toString);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            _guard(() => Mapper.isEqual(this, other), () => super == other));
  }

  @override
  int get hashCode {
    return _guard(() => Mapper.hash(this), () => super.hashCode);
  }

  T _guard<T>(T Function() fn, T Function() fallback) {
    try {
      return fn();
    } on MapperException catch (e) {
      if (e.isUnsupportedOrUnallowed()) {
        return fallback();
      } else {
        rethrow;
      }
    }
  }
}
