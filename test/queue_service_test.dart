import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'mocks.mocks.dart'; // Importa os mocks gerados

void main() {
  late MockQueueService mockQueueService;

  setUp(() {
    mockQueueService = MockQueueService();
  });

  group('QueueService', () {
    test('Deve publicar mensagem na fila', () async {
      when(mockQueueService.publishMessage(any)).thenAnswer((_) async {});

      await mockQueueService.publishMessage('Mensagem de teste');

      verify(mockQueueService.publishMessage('Mensagem de teste')).called(1);
    });
  });
}