import 'storage_repository.dart';

/// Provides the 'device-id' value from the storage repository.
final deviceIdRepository = storageObjectRepositoryFactory<String>('device-id');
