class ServerException implements Exception {
}

class CacheException extends Exception {
  factory CacheException.none() => throw '';
}