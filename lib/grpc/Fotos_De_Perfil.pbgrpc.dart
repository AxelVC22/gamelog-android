// This is a generated file - do not edit.
//
// Generated from Fotos_De_Perfil.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'Fotos_De_Perfil.pb.dart' as $0;

export 'Fotos_De_Perfil.pb.dart';

@$pb.GrpcServiceName('FotosDePerfil')
class FotosDePerfilClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  FotosDePerfilClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.FotoResponse> subirFoto(
    $0.FotoRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$subirFoto, request, options: options);
  }

  $grpc.ResponseFuture<$0.FotoResponse> obtenerFoto(
    $0.FotoRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$obtenerFoto, request, options: options);
  }

  $grpc.ResponseFuture<$0.FotoResponse> actualizarFoto(
    $0.FotoRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$actualizarFoto, request, options: options);
  }

  $grpc.ResponseFuture<$0.MultipleFotosResponse> obtenerMultiplesFotos(
    $0.MultipleFotosRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$obtenerMultiplesFotos, request, options: options);
  }

  // method descriptors

  static final _$subirFoto =
      $grpc.ClientMethod<$0.FotoRequest, $0.FotoResponse>(
          '/FotosDePerfil/SubirFoto',
          ($0.FotoRequest value) => value.writeToBuffer(),
          $0.FotoResponse.fromBuffer);
  static final _$obtenerFoto =
      $grpc.ClientMethod<$0.FotoRequest, $0.FotoResponse>(
          '/FotosDePerfil/ObtenerFoto',
          ($0.FotoRequest value) => value.writeToBuffer(),
          $0.FotoResponse.fromBuffer);
  static final _$actualizarFoto =
      $grpc.ClientMethod<$0.FotoRequest, $0.FotoResponse>(
          '/FotosDePerfil/ActualizarFoto',
          ($0.FotoRequest value) => value.writeToBuffer(),
          $0.FotoResponse.fromBuffer);
  static final _$obtenerMultiplesFotos =
      $grpc.ClientMethod<$0.MultipleFotosRequest, $0.MultipleFotosResponse>(
          '/FotosDePerfil/ObtenerMultiplesFotos',
          ($0.MultipleFotosRequest value) => value.writeToBuffer(),
          $0.MultipleFotosResponse.fromBuffer);
}

@$pb.GrpcServiceName('FotosDePerfil')
abstract class FotosDePerfilServiceBase extends $grpc.Service {
  $core.String get $name => 'FotosDePerfil';

  FotosDePerfilServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.FotoRequest, $0.FotoResponse>(
        'SubirFoto',
        subirFoto_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.FotoRequest.fromBuffer(value),
        ($0.FotoResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.FotoRequest, $0.FotoResponse>(
        'ObtenerFoto',
        obtenerFoto_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.FotoRequest.fromBuffer(value),
        ($0.FotoResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.FotoRequest, $0.FotoResponse>(
        'ActualizarFoto',
        actualizarFoto_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.FotoRequest.fromBuffer(value),
        ($0.FotoResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.MultipleFotosRequest, $0.MultipleFotosResponse>(
            'ObtenerMultiplesFotos',
            obtenerMultiplesFotos_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.MultipleFotosRequest.fromBuffer(value),
            ($0.MultipleFotosResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.FotoResponse> subirFoto_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.FotoRequest> $request) async {
    return subirFoto($call, await $request);
  }

  $async.Future<$0.FotoResponse> subirFoto(
      $grpc.ServiceCall call, $0.FotoRequest request);

  $async.Future<$0.FotoResponse> obtenerFoto_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.FotoRequest> $request) async {
    return obtenerFoto($call, await $request);
  }

  $async.Future<$0.FotoResponse> obtenerFoto(
      $grpc.ServiceCall call, $0.FotoRequest request);

  $async.Future<$0.FotoResponse> actualizarFoto_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.FotoRequest> $request) async {
    return actualizarFoto($call, await $request);
  }

  $async.Future<$0.FotoResponse> actualizarFoto(
      $grpc.ServiceCall call, $0.FotoRequest request);

  $async.Future<$0.MultipleFotosResponse> obtenerMultiplesFotos_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.MultipleFotosRequest> $request) async {
    return obtenerMultiplesFotos($call, await $request);
  }

  $async.Future<$0.MultipleFotosResponse> obtenerMultiplesFotos(
      $grpc.ServiceCall call, $0.MultipleFotosRequest request);
}
