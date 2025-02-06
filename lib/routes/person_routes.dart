import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../services/database_service.dart';
import '../services/cache_service.dart';
import '../services/queue_service.dart';

class PersonRoutes {
  final DatabaseService _dbService = DatabaseService();
  final CacheService _cacheService = CacheService();
  final QueueService _queueService = QueueService();

  Router get router {
    final router = Router();

    router.get('/persons', (Request request) async {
      final cachedData = await _cacheService.getPersonCache('persons');
      if (cachedData != null) {
        return Response.ok(cachedData);
      }

      final persons = await _dbService.getPersons();
      final responseData = persons.map((e) => e.toJson()).toList();
      await _cacheService.setPersonCache('persons', responseData.toString());

      return Response.ok(responseData.toString());
    });

    router.post('/persons', (Request request) async {
      final payload = await request.readAsString();
      _queueService.publishMessage(payload);
      return Response.ok('Pessoa adicionada à fila');
    });

    router.delete('/persons/<id>', (Request request, String id) async {
      await _dbService.deletePerson(id);
      return Response.ok('Pessoa removida');
    });

    return router;
  }
}