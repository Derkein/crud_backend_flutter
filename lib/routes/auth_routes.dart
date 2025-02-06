import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../services/auth_service.dart';

class AuthRoutes {
  final AuthService _authService = AuthService();

  Router get router {
    final router = Router();

    // Rota de Registro
    router.post('/register', (Request request) async {
      final payload = await request.readAsString();
      final data = Uri.splitQueryString(payload);
      if (data.containsKey('username') && data.containsKey('password')) {
        await _authService.registerUser(data['username']!, data['password']!);
        return Response.ok('Usuário registrado com sucesso');
      }
      return Response.badRequest(body: 'Dados inválidos');
    });

    // Rota de Login
    router.post('/login', (Request request) async {
      final payload = await request.readAsString();
      final data = Uri.splitQueryString(payload);
      if (data.containsKey('username') && data.containsKey('password')) {
        final token = await _authService.loginUser(data['username']!, data['password']!);
        if (token != null) {
          return Response.ok(token);
        }
      }
      return Response.unauthorized('Usuário ou senha inválidos');
    });

    return router;
  }
}