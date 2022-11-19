import '../../common/data/storage_repository.dart';

/// Provides the 'user-name' value from the storage repository.
final userNameRepository = storageObjectRepositoryFactory<String>('user-name');
