import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Provides the repository to access the persistent key-value storage.
final storageRepository = ChangeNotifierProvider<StorageRepository>((ref) => StorageRepository(ref));

/// Provides the native storage interface used by [storageRepository].
///
/// Should be overridden when creating the root provider scope.
final storageSource =
    Provider<StorageSource>((ref) => throw UnimplementedError('Must be overridden when creating the provider scope.'));

/// Interface for a key-value store.
abstract class StorageSource {
  T? get<T>(String key);
  void set<T>(String key, T? value);
}

/// Repository that accesses the storage source and notifies when values are changed.
class StorageRepository with ChangeNotifier implements StorageSource {
  StorageRepository(Ref ref) : source = ref.read(storageSource);

  final StorageSource source;

  @override
  T? get<T>(String key) => source.get<T>(key);

  @override
  void set<T>(String key, T? value) {
    source.set<T>(key, value);
    notifyListeners();
  }
}

/// Implementation of [StorageSource] that uses the shared preferences of the target platform.
class SharedPreferencesStorageSource implements StorageSource {
  SharedPreferencesStorageSource(this.storage);

  final SharedPreferences storage;

  @override
  T? get<T>(String key) {
    if (storage.containsKey(key)) {
      if (T == String) {
        return storage.getString(key) as T?;
      } else if (T == bool) {
        return storage.getBool(key) as T?;
      } else if (T == int) {
        return storage.getOrParseInt(key) as T?;
      } else if (T == double) {
        return storage.getDouble(key) as T?;
      } else {
        throw UnsupportedError('Cannot call StorageSource.get with type parameter "$T". '
            'Supported values are (String, bool, int, double).');
      }
    }
    return null;
  }

  @override
  void set<T>(String key, T? value) {
    if (value != null) {
      if (value is String) {
        storage.setString(key, value);
      } else if (value is bool) {
        storage.setBool(key, value);
      } else if (value is int) {
        storage.setInt(key, value);
      } else if (value is double) {
        storage.setDouble(key, value);
      } else {
        throw UnsupportedError('Cannot call StorageSource.set with type parameter "$T". '
            'Supported values are (String, bool, int, double).');
      }
    } else {
      storage.remove(key);
    }
  }
}

/// Extension for parsing a string where an int is expected.
///
/// This was mainly introduced to keep backwards compatibility for
/// 'default-page' which was stored as a string in previous versions.
extension ParsedGet on SharedPreferences {
  int? getOrParseInt(String key) {
    var value = get(key);
    if (value is String) {
      return int.parse(value);
    }
    return getInt(key);
  }
}

/// Creates a provider that proxies the value for a given key of the storage repository.
///
/// Must only be used to initialize a top-level provider.
StateNotifierProvider<StorageObjectRepository<T>, T?> storageObjectRepositoryFactory<T>(String key) {
  return StateNotifierProvider((ref) => StorageObjectRepository(ref, key));
}

/// A repository that proxies a value of the storage repository for a given key.
class StorageObjectRepository<T> extends StateNotifier<T?> {
  StorageObjectRepository(this.ref, this.key) : super(ref.read(storageRepository).get(key)) {
    ref.listen<T?>(storageRepository.select((s) => s.get(key)), (_, next) {
      if (state != next) {
        super.state = next;
      }
    });
  }

  final Ref ref;
  final String key;

  @override
  set state(T? value) {
    if (value == state) {
      return;
    }
    super.state = value;
    ref.read(storageRepository).set(key, value);
  }
}
