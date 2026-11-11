import 'dart:convert';
import 'dart:io';

import 'package:directorio_dolores/datos/negocios_api.dart';
import 'package:directorio_dolores/dominio/excepciones%20.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

NegociosApi apiCon(MockClient c) => NegociosApi(c, 'http://prueba');

void main() {
  test('listar convierte el JSON en objetos Negocio', () async {
    final api = apiCon(
      MockClient((req) async {
        expect(req.method, 'GET');
        expect(req.url.path, '/negocios');
        return http.Response(
          jsonEncode([
            {'id': 1, 'nombre': 'A', 'categoria': 'X'},
            {'id': 2, 'nombre': 'B', 'categoria': 'Y'},
          ]),
          200,
        );
      }),
    );
    final lista = await api.listar();
    expect(lista.length, 2);
    expect(lista.first.nombre, 'A');
  });

  test('status 500 lanza ErrorServidorException con el código', () async {
    final api = apiCon(MockClient((_) async => http.Response('boom', 500)));
    expect(
      api.listar(),
      throwsA(
        isA<ErrorServidorException>().having((e) => e.codigo, 'codigo', 500),
      ),
    );
  });

  test('sin red lanza SinConexionException', () {
    final api = apiCon(
      MockClient((_) async => throw const SocketException('x')),
    );
    expect(api.listar(), throwsA(isA<SinConexionException>()));
  });

  test('timeout se trata como sin conexión', () {
    final api = NegociosApi(
      MockClient((_) async {
        await Future.delayed(const Duration(milliseconds: 200));
        return http.Response('[]', 200);
      }),
      'http://prueba',
      espera: const Duration(milliseconds: 20),
    );
    expect(api.listar(), throwsA(isA<SinConexionException>()));
  });

  test('JSON roto lanza RespuestaInvalidaException', () {
    final api = apiCon(MockClient((_) async => http.Response('<html>', 200)));
    expect(api.listar(), throwsA(isA<RespuestaInvalidaException>()));
  });
}
