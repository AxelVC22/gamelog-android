import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// RUTAS CORREGIDAS
import 'package:gamelog/core/data/repositories/sockets/notifications/socket_repository_implementation.dart';
import 'package:gamelog/core/data/data_sources/notifications/socket_io_data_source.dart';

class MockSocketIODataSource extends Mock implements SocketIODataSource {}

void main() {
  late SocketRepositoryImpl repository;
  late MockSocketIODataSource mockDataSource;

  setUp(() {
    mockDataSource = MockSocketIODataSource();
    repository = SocketRepositoryImpl(mockDataSource);
  });

  group('connect', () {
    const tUsuario = 'user';
    const tContrasenia = 'pass';
    const tIdJugador = '123';

    test('should call connect on data source with correct parameters', () {
      when(() => mockDataSource.connect(
        usuario: any(named: 'usuario'),
        contrasenia: any(named: 'contrasenia'),
        idJugador: any(named: 'idJugador'),
      )).thenAnswer((_) async {});

      repository.connect(
        usuario: tUsuario,
        contrasenia: tContrasenia,
        idJugador: tIdJugador,
      );

      verify(() => mockDataSource.connect(
        usuario: tUsuario,
        contrasenia: tContrasenia,
        idJugador: tIdJugador,
      )).called(1);
    });

    test('should propagate exception when data source fails', () {
      when(() => mockDataSource.connect(
        usuario: any(named: 'usuario'),
        contrasenia: any(named: 'contrasenia'),
        idJugador: any(named: 'idJugador'),
      )).thenThrow(Exception('Connection error'));

      expect(
            () => repository.connect(
          usuario: tUsuario,
          contrasenia: tContrasenia,
          idJugador: tIdJugador,
        ),
        throwsException,
      );
    });
  });

  group('suscribirResenasJuego', () {
    const tIdJuego = 'game1';

    test('should call suscribirResenasJuego on data source', () {
      when(() => mockDataSource.suscribirResenasJuego(any()))
          .thenAnswer((_) async {});

      repository.suscribirResenasJuego(tIdJuego);

      verify(() => mockDataSource.suscribirResenasJuego(tIdJuego)).called(1);
    });

    test('should propagate exception when data source fails', () {
      when(() => mockDataSource.suscribirResenasJuego(any()))
          .thenThrow(Exception('Error subscribing'));

      expect(
            () => repository.suscribirResenasJuego(tIdJuego),
        throwsException,
      );
    });
  });

  group('desuscribirResenasJuego', () {
    const tIdJuego = 'game1';

    test('should call desuscribirResenasJuego on data source', () {
      when(() => mockDataSource.desuscribirResenasJuego(any()))
          .thenAnswer((_) async {});

      repository.desuscribirResenasJuego(tIdJuego);

      verify(() => mockDataSource.desuscribirResenasJuego(tIdJuego)).called(1);
    });

    test('should propagate exception when data source fails', () {
      when(() => mockDataSource.desuscribirResenasJuego(any()))
          .thenThrow(Exception('Error unsubscribing'));

      expect(
            () => repository.desuscribirResenasJuego(tIdJuego),
        throwsException,
      );
    });
  });

  group('suscribirBroadcast', () {
    test('should call suscribirBroadcast on data source', () {
      when(() => mockDataSource.suscribirBroadcast()).thenAnswer((_) async {});

      repository.suscribirBroadcast();

      verify(() => mockDataSource.suscribirBroadcast()).called(1);
    });

    test('should propagate exception when data source fails', () {
      when(() => mockDataSource.suscribirBroadcast())
          .thenThrow(Exception('Broadcast error'));

      expect(
            () => repository.suscribirBroadcast(),
        throwsException,
      );
    });
  });

  group('disconnect', () {
    test('should call disconnect on data source', () {
      when(() => mockDataSource.disconnect()).thenAnswer((_) async {});

      repository.disconnect();

      verify(() => mockDataSource.disconnect()).called(1);
    });

    test('should propagate exception when data source fails', () {
      when(() => mockDataSource.disconnect())
          .thenThrow(Exception('Disconnect error'));

      expect(
            () => repository.disconnect(),
        throwsException,
      );
    });
  });

  group('isConnected', () {
    test('should return true when data source is connected', () {
      when(() => mockDataSource.isConnected).thenReturn(true);
      expect(repository.isConnected, true);
    });

    test('should return false when data source is not connected', () {
      when(() => mockDataSource.isConnected).thenReturn(false);
      expect(repository.isConnected, false);
    });
  });

  group('Callbacks setters', () {
    test('setOnNotificacionJugador should set callback on data source', () {
      void testCallback(String msg) {}
      repository.setOnNotificacionJugador(testCallback);
      verify(() => mockDataSource.onNotificacionJugador = testCallback).called(1);
    });

    test('setOnActualizacionResenas should set callback on data source', () {
      void testCallback(String msg) {}
      repository.setOnActualizacionResenas(testCallback);
      verify(() => mockDataSource.onActualizacionResenas = testCallback).called(1);
    });

    test('setOnMensajeBroadcast should set callback on data source', () {
      void testCallback(String msg) {}
      repository.setOnMensajeBroadcast(testCallback);
      verify(() => mockDataSource.onMensajeBroadcast = testCallback).called(1);
    });
  });
}