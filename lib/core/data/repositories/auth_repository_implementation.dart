import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../domain/entities/user.dart';
import '../../domain/failures/failure.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final Dio dio; 
  final FlutterSecureStorage storage; 

  AuthRepositoryImpl(this.dio, this.storage);

  @override
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
    required String userType,
  }) async {
    try {
      final data = {
        'correo': email,
        'contrasenia': password,
        'tipoDeUsuario': userType,
      };

      final response = await dio.post('/gamelog/login', data: data);

      if (response.statusCode == 200) {
        
        final token = response.headers.value('access_token');
        if (token == null) {
          return Left(Failure('No se recibió token de acceso.'));
        }

        await storage.write(key: 'token', value: token);

        final user = User.fromJson(response.data['cuenta'][0]);
        
        return Right(user);
      } else {
        return Left(Failure('Respuesta inesperada del servidor'));
      }

    } on DioException catch (e) {
      if (e.response != null && e.response?.data['mensaje'] != null) {
        return Left(Failure(e.response!.data['mensaje']));
      } else {
        return Left(Failure('No se pudo conectar al servidor.'));
      }
    } catch (e) {
      return Left(Failure('Error inesperado: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> logout(String email) async {
    try {
      await dio.delete('/gamelog/login/$email');
      
      return Right(null);
    } on DioException catch (e) {
      return Left(Failure(e.response?.data['mensaje'] ?? 'Error al cerrar sesión'));
    } catch (e) {
      return Left(Failure('Error inesperado: $e'));
    } finally {
      await storage.delete(key: 'token');
    }
  }
}