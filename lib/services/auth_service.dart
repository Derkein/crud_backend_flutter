import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:bcrypt/bcrypt.dart';
import 'package:mongo_dart/mongo_dart.dart';
import '../models/user.dart';

class AuthService {
  final String _jwtSecret = "supersecretkey"; // 🔑 Substitua por um valor seguro
  final Db db = Db('mongodb://localhost:27017/crud_database');
  late DbCollection userCollection;

  Future<void> connect() async {
    await db.open();
    userCollection = db.collection('users');
  }

  /// Registra um novo usuário
  Future<void> registerUser(String username, String password) async {
    final passwordHash = BCrypt.hashpw(password, BCrypt.gensalt());
    await userCollection.insert({'username': username, 'passwordHash': passwordHash});
  }

  /// Autentica usuário e retorna um token JWT
  Future<String?> loginUser(String username, String password) async {
    final user = await userCollection.findOne({'username': username});
    if (user != null && BCrypt.checkpw(password, user['passwordHash'])) {
      final jwt = JWT({'id': user['_id'], 'username': username});
      return jwt.sign(SecretKey(_jwtSecret), expiresIn: Duration(hours: 2));
    }
    return null;
  }

  /// Valida um token JWT
  bool verifyToken(String token) {
    try {
      final jwt = JWT.verify(token, SecretKey(_jwtSecret));
      return true;
    } catch (e) {
      return false;
    }
  }
}