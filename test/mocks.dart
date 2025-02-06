import 'package:crud_backend_flutter/services/cache_service.dart';
import 'package:crud_backend_flutter/services/database_service.dart';
import 'package:crud_backend_flutter/services/queue_service.dart';
import 'package:mockito/annotations.dart';


@GenerateMocks([DatabaseService, CacheService, QueueService])
void main() {}