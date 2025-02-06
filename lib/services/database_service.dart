import 'package:mongo_dart/mongo_dart.dart';
import '../models/person.dart';

class DatabaseService {
  final Db db = Db('mongodb://localhost:27017/crud_database');
  late DbCollection personCollection;

  Future<void> connect() async {
    await db.open();
    personCollection = db.collection('persons');
  }

  Future<List<Person>> getPersons() async {
    final persons = await personCollection.find().toList();
    return persons.map((e) => Person.fromJson(e)).toList();
  }

  Future<void> addPerson(String name) async {
    await personCollection.insert({'name': name});
  }

  Future<void> deletePerson(String id) async {
    await personCollection.remove(where.id(ObjectId.parse(id)));
  }
}