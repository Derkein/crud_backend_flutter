import 'package:crud_backend_flutter/models/person.dart';
import 'package:test/test.dart';

void main() {
  group('Person Model', () {
    test('Deve converter JSON para Person corretamente', () {
      final json = {'_id': '123', 'name': 'João'};
      final person = Person.fromJson(json);

      expect(person.id, '123');
      expect(person.name, 'João');
    });

    test('Deve converter Person para JSON corretamente', () {
      final person = Person(id: '456', name: 'Maria');
      final json = person.toJson();

      expect(json['id'], '456');
      expect(json['name'], 'Maria');
    });
  });
}