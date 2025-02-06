import 'package:redis/redis.dart';

class CacheService {
  final RedisConnection _connection = RedisConnection();
  late Command _command;

  Future<void> connect() async {
    _command = await _connection.connect('localhost', 6379);
  }

  Future<void> setPersonCache(String key, String value) async {
    await _command.send_object(['SET', key, value, 'EX', '3600']);
  }

  Future<String?> getPersonCache(String key) async {
    return await _command.send_object(['GET', key]);
  }
}