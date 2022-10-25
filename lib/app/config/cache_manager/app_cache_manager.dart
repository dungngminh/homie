import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;
import 'package:pbl6_mobile/di/di.dart';

class AppCacheManager {
  static const cacheKey = 'image_cached';
  static final appConfig = CacheManager(
    Config(
      cacheKey,
      stalePeriod: const Duration(days: 2),
      maxNrOfCacheObjects: 75,
      repo: JsonCacheInfoRepository(databaseName: cacheKey),
      fileService: HttpFileService(httpClient: injector<http.Client>()),
    ),
  );
}
