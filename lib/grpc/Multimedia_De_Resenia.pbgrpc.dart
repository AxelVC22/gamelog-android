// This is a generated file - do not edit.
//
// Generated from Multimedia_De_Resenia.proto.

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

import 'Multimedia_De_Resenia.pb.dart' as $0;

export 'Multimedia_De_Resenia.pb.dart';

/// ========== SERVICIO ==========
@$pb.GrpcServiceName('ReviewMultimedia')
class ReviewMultimediaClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  ReviewMultimediaClient(super.channel, {super.options, super.interceptors});

  /// Fotos: unary (normal)
  $grpc.ResponseFuture<$0.SubirFotoResponse> subirFoto(
    $0.SubirFotoRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$subirFoto, request, options: options);
  }

  $grpc.ResponseFuture<$0.ObtenerFotosResponse> obtenerFotos(
    $0.ObtenerFotosRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$obtenerFotos, request, options: options);
  }

  /// Videos: streaming
  $grpc.ResponseFuture<$0.SubirVideoResponse> subirVideo(
    $async.Stream<$0.ChunkVideoRequest> request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(_$subirVideo, request, options: options).single;
  }

  $grpc.ResponseStream<$0.VideoChunk> obtenerVideo(
    $0.ObtenerVideoRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(
        _$obtenerVideo, $async.Stream.fromIterable([request]),
        options: options);
  }

  /// Otros
  $grpc.ResponseFuture<$0.MetadataResponse> obtenerMetadata(
    $0.ObtenerMetadataRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$obtenerMetadata, request, options: options);
  }

  $grpc.ResponseFuture<$0.EliminarArchivosResponse> eliminarArchivos(
    $0.EliminarArchivosRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$eliminarArchivos, request, options: options);
  }

  // method descriptors

  static final _$subirFoto =
      $grpc.ClientMethod<$0.SubirFotoRequest, $0.SubirFotoResponse>(
          '/ReviewMultimedia/SubirFoto',
          ($0.SubirFotoRequest value) => value.writeToBuffer(),
          $0.SubirFotoResponse.fromBuffer);
  static final _$obtenerFotos =
      $grpc.ClientMethod<$0.ObtenerFotosRequest, $0.ObtenerFotosResponse>(
          '/ReviewMultimedia/ObtenerFotos',
          ($0.ObtenerFotosRequest value) => value.writeToBuffer(),
          $0.ObtenerFotosResponse.fromBuffer);
  static final _$subirVideo =
      $grpc.ClientMethod<$0.ChunkVideoRequest, $0.SubirVideoResponse>(
          '/ReviewMultimedia/SubirVideo',
          ($0.ChunkVideoRequest value) => value.writeToBuffer(),
          $0.SubirVideoResponse.fromBuffer);
  static final _$obtenerVideo =
      $grpc.ClientMethod<$0.ObtenerVideoRequest, $0.VideoChunk>(
          '/ReviewMultimedia/ObtenerVideo',
          ($0.ObtenerVideoRequest value) => value.writeToBuffer(),
          $0.VideoChunk.fromBuffer);
  static final _$obtenerMetadata =
      $grpc.ClientMethod<$0.ObtenerMetadataRequest, $0.MetadataResponse>(
          '/ReviewMultimedia/ObtenerMetadata',
          ($0.ObtenerMetadataRequest value) => value.writeToBuffer(),
          $0.MetadataResponse.fromBuffer);
  static final _$eliminarArchivos = $grpc.ClientMethod<
          $0.EliminarArchivosRequest, $0.EliminarArchivosResponse>(
      '/ReviewMultimedia/EliminarArchivos',
      ($0.EliminarArchivosRequest value) => value.writeToBuffer(),
      $0.EliminarArchivosResponse.fromBuffer);
}

@$pb.GrpcServiceName('ReviewMultimedia')
abstract class ReviewMultimediaServiceBase extends $grpc.Service {
  $core.String get $name => 'ReviewMultimedia';

  ReviewMultimediaServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.SubirFotoRequest, $0.SubirFotoResponse>(
        'SubirFoto',
        subirFoto_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SubirFotoRequest.fromBuffer(value),
        ($0.SubirFotoResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.ObtenerFotosRequest, $0.ObtenerFotosResponse>(
            'ObtenerFotos',
            obtenerFotos_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.ObtenerFotosRequest.fromBuffer(value),
            ($0.ObtenerFotosResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ChunkVideoRequest, $0.SubirVideoResponse>(
        'SubirVideo',
        subirVideo,
        true,
        false,
        ($core.List<$core.int> value) => $0.ChunkVideoRequest.fromBuffer(value),
        ($0.SubirVideoResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ObtenerVideoRequest, $0.VideoChunk>(
        'ObtenerVideo',
        obtenerVideo_Pre,
        false,
        true,
        ($core.List<$core.int> value) =>
            $0.ObtenerVideoRequest.fromBuffer(value),
        ($0.VideoChunk value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.ObtenerMetadataRequest, $0.MetadataResponse>(
            'ObtenerMetadata',
            obtenerMetadata_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.ObtenerMetadataRequest.fromBuffer(value),
            ($0.MetadataResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.EliminarArchivosRequest,
            $0.EliminarArchivosResponse>(
        'EliminarArchivos',
        eliminarArchivos_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.EliminarArchivosRequest.fromBuffer(value),
        ($0.EliminarArchivosResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.SubirFotoResponse> subirFoto_Pre($grpc.ServiceCall $call,
      $async.Future<$0.SubirFotoRequest> $request) async {
    return subirFoto($call, await $request);
  }

  $async.Future<$0.SubirFotoResponse> subirFoto(
      $grpc.ServiceCall call, $0.SubirFotoRequest request);

  $async.Future<$0.ObtenerFotosResponse> obtenerFotos_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ObtenerFotosRequest> $request) async {
    return obtenerFotos($call, await $request);
  }

  $async.Future<$0.ObtenerFotosResponse> obtenerFotos(
      $grpc.ServiceCall call, $0.ObtenerFotosRequest request);

  $async.Future<$0.SubirVideoResponse> subirVideo(
      $grpc.ServiceCall call, $async.Stream<$0.ChunkVideoRequest> request);

  $async.Stream<$0.VideoChunk> obtenerVideo_Pre($grpc.ServiceCall $call,
      $async.Future<$0.ObtenerVideoRequest> $request) async* {
    yield* obtenerVideo($call, await $request);
  }

  $async.Stream<$0.VideoChunk> obtenerVideo(
      $grpc.ServiceCall call, $0.ObtenerVideoRequest request);

  $async.Future<$0.MetadataResponse> obtenerMetadata_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ObtenerMetadataRequest> $request) async {
    return obtenerMetadata($call, await $request);
  }

  $async.Future<$0.MetadataResponse> obtenerMetadata(
      $grpc.ServiceCall call, $0.ObtenerMetadataRequest request);

  $async.Future<$0.EliminarArchivosResponse> eliminarArchivos_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.EliminarArchivosRequest> $request) async {
    return eliminarArchivos($call, await $request);
  }

  $async.Future<$0.EliminarArchivosResponse> eliminarArchivos(
      $grpc.ServiceCall call, $0.EliminarArchivosRequest request);
}
