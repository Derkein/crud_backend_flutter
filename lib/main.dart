import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'routes/person_routes.dart';
import 'routes/auth_routes.dart';
import 'services/auth_service.dart';

final AuthService _authService = AuthService();

/// Middleware que valida tokens JWT
Middleware verifyJWT() {
  return (Handler innerHandler) {
    return (Request request) async {
      final authHeader = request.headers['Authorization'];
      if (authHeader == null || !authHeader.startsWith('Bearer ')) {
        return Response.unauthorized('Token JWT ausente');
      }

      final token = authHeader.substring(7);
      if (!_authService.verifyToken(token)) {
        return Response.unauthorized('Token JWT inválido');
      }

      return innerHandler(request);
    };
  };
}

void main() async {
  final authRoutes = AuthRoutes();
  final personRoutes = PersonRoutes();

  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addHandler(Cascade()
          .add(authRoutes.router)
          .add(verifyJWT().addHandler(personRoutes.router)) // 🔒 Protegendo rotas de pessoas
          .handler);

  final server = await io.serve(handler, 'localhost', 3000);
  print('Servidor rodando em http://${server.address.host}:${server.port}');
}