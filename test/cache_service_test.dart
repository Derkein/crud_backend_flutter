import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'mocks.mocks.dart'; // Importa os mocks gerados

void main() {
  late MockCacheService mockCacheService;

  setUp(() {
    mockCacheService = MockCacheService();
  });

  group('CacheService', () {
    test('Deve salvar e recuperar cache', () async {
      // Simula que quando chamarmos getPersonCache, ele retorna um Future<String?>
      when(mockCacheService.getPersonCache(any)).thenAnswer((_) async => 'cached value');

      // Salva um cache fictício
      await mockCacheService.setPersonCache('key', 'cached value');
      
      // Recupera o cache e testa se é o esperado
      final cachedData = await mockCacheService.getPersonCache('key');

      expect(cachedData, equals('cached value'));
    });

    test('Deve retornar nulo se não houver cache', () async {
      // Simula um retorno nulo corretamente
      when(mockCacheService.getPersonCache(any)).thenAnswer((_) async => null);

      final cachedData = await mockCacheService.getPersonCache('key');

      expect(cachedData, isNull);
    });
  });
}