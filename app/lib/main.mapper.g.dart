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
  UserProfile fromMap(Map<String, dynamic> map) => UserProfile(Mapper.i.$get(map, 'name'), Mapper.i.$getOpt(map, 'profileUrl'));

  @override Function get encoder => (UserProfile v) => encode(v);
  dynamic encode(UserProfile v) => toMap(v);
  Map<String, dynamic> toMap(UserProfile u) => {'name': Mapper.i.$enc(u.name, 'name'), 'profileUrl': Mapper.i.$enc(u.profileUrl, 'profileUrl')};

  @override String stringify(UserProfile self) => 'UserProfile(name: ${Mapper.asString(self.name)}, profileUrl: ${Mapper.asString(self.profileUrl)})';
  @override int hash(UserProfile self) => Mapper.hash(self.name) ^ Mapper.hash(self.profileUrl);
  @override bool equals(UserProfile self, UserProfile other) => Mapper.isEqual(self.name, other.name) && Mapper.isEqual(self.profileUrl, other.profileUrl);

  @override Function get typeFactory => (f) => f<UserProfile>();
}

extension UserProfileMapperExtension  on UserProfile {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  UserProfileCopyWith<UserProfile> get copyWith => UserProfileCopyWith(this, $identity);
}

abstract class UserProfileCopyWith<$R> {
  factory UserProfileCopyWith(UserProfile value, Then<UserProfile, $R> then) = _UserProfileCopyWithImpl<$R>;
  $R call({String? name, String? profileUrl});
  $R apply(UserProfile Function(UserProfile) transform);
}

class _UserProfileCopyWithImpl<$R> extends BaseCopyWith<UserProfile, $R> implements UserProfileCopyWith<$R> {
  _UserProfileCopyWithImpl(UserProfile value, Then<UserProfile, $R> then) : super(value, then);

  @override $R call({String? name, Object? profileUrl = $none}) => $then(UserProfile(name ?? $value.name, or(profileUrl, $value.profileUrl)));
}

class HouseMapper extends BaseMapper<House> {
  HouseMapper._();

  @override Function get decoder => decode;
  House decode(dynamic v) => checked(v, (Map<String, dynamic> map) => fromMap(map));
  House fromMap(Map<String, dynamic> map) => House(id: Mapper.i.$get(map, 'id'), owner: Mapper.i.$get(map, 'owner'), likes: Mapper.i.$getOpt(map, 'likes') ?? const []);

  @override Function get encoder => (House v) => encode(v);
  dynamic encode(House v) => toMap(v);
  Map<String, dynamic> toMap(House h) => {'id': Mapper.i.$enc(h.id, 'id'), 'owner': Mapper.i.$enc(h.owner, 'owner'), 'likes': Mapper.i.$enc(h.likes, 'likes')};

  @override String stringify(House self) => 'House(id: ${Mapper.asString(self.id)}, owner: ${Mapper.asString(self.owner)}, likes: ${Mapper.asString(self.likes)})';
  @override int hash(House self) => Mapper.hash(self.id) ^ Mapper.hash(self.owner) ^ Mapper.hash(self.likes);
  @override bool equals(House self, House other) => Mapper.isEqual(self.id, other.id) && Mapper.isEqual(self.owner, other.owner) && Mapper.isEqual(self.likes, other.likes);

  @override Function get typeFactory => (f) => f<House>();
}

extension HouseMapperExtension  on House {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  HouseCopyWith<House> get copyWith => HouseCopyWith(this, $identity);
}

abstract class HouseCopyWith<$R> {
  factory HouseCopyWith(House value, Then<House, $R> then) = _HouseCopyWithImpl<$R>;
  $R call({String? id, String? owner, List<String>? likes});
  $R apply(House Function(House) transform);
}

class _HouseCopyWithImpl<$R> extends BaseCopyWith<House, $R> implements HouseCopyWith<$R> {
  _HouseCopyWithImpl(House value, Then<House, $R> then) : super(value, then);

  @override $R call({String? id, String? owner, List<String>? likes}) => $then(House(id: id ?? $value.id, owner: owner ?? $value.owner, likes: likes ?? $value.likes));
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
