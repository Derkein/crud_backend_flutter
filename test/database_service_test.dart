import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'mocks.mocks.dart'; 

void main() {
  late MockDatabaseService mockDbService;

  setUp(() {
    mockDbService = MockDatabaseService();
  });

  group('DatabaseService', () {
    test('Deve adicionar pessoa no banco', () async {
      when(mockDbService.addPerson(any)).thenAnswer((_) async {});

      await mockDbService.addPerson('Teste Pessoa');

      verify(mockDbService.addPerson('Teste Pessoa')).called(1);
    });

    test('Deve deletar pessoa pelo ID', () async {
      when(mockDbService.deletePerson(any)).thenAnswer((_) async {});

      await mockDbService.deletePerson('123');

      verify(mockDbService.deletePerson('123')).called(1);
    });
  });
}