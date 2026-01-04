// This is a generated file - do not edit.
//
// Generated from Multimedia_De_Resenia.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports
// ignore_for_file: unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use subirFotoRequestDescriptor instead')
const SubirFotoRequest$json = {
  '1': 'SubirFotoRequest',
  '2': [
    {'1': 'idReview', '3': 1, '4': 1, '5': 9, '10': 'idReview'},
    {'1': 'indice', '3': 2, '4': 1, '5': 5, '10': 'indice'},
    {'1': 'extension', '3': 3, '4': 1, '5': 9, '10': 'extension'},
    {'1': 'datos', '3': 4, '4': 1, '5': 12, '10': 'datos'},
  ],
};

/// Descriptor for `SubirFotoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List subirFotoRequestDescriptor = $convert.base64Decode(
    'ChBTdWJpckZvdG9SZXF1ZXN0EhoKCGlkUmV2aWV3GAEgASgJUghpZFJldmlldxIWCgZpbmRpY2'
    'UYAiABKAVSBmluZGljZRIcCglleHRlbnNpb24YAyABKAlSCWV4dGVuc2lvbhIUCgVkYXRvcxgE'
    'IAEoDFIFZGF0b3M=');

@$core.Deprecated('Use subirFotoResponseDescriptor instead')
const SubirFotoResponse$json = {
  '1': 'SubirFotoResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `SubirFotoResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List subirFotoResponseDescriptor = $convert.base64Decode(
    'ChFTdWJpckZvdG9SZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB21lc3NhZ2'
    'UYAiABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use chunkVideoRequestDescriptor instead')
const ChunkVideoRequest$json = {
  '1': 'ChunkVideoRequest',
  '2': [
    {'1': 'idReview', '3': 1, '4': 1, '5': 9, '10': 'idReview'},
    {'1': 'extension', '3': 2, '4': 1, '5': 9, '10': 'extension'},
    {'1': 'chunk', '3': 3, '4': 1, '5': 12, '10': 'chunk'},
    {'1': 'chunkIndex', '3': 4, '4': 1, '5': 5, '10': 'chunkIndex'},
    {'1': 'totalChunks', '3': 5, '4': 1, '5': 5, '10': 'totalChunks'},
  ],
};

/// Descriptor for `ChunkVideoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chunkVideoRequestDescriptor = $convert.base64Decode(
    'ChFDaHVua1ZpZGVvUmVxdWVzdBIaCghpZFJldmlldxgBIAEoCVIIaWRSZXZpZXcSHAoJZXh0ZW'
    '5zaW9uGAIgASgJUglleHRlbnNpb24SFAoFY2h1bmsYAyABKAxSBWNodW5rEh4KCmNodW5rSW5k'
    'ZXgYBCABKAVSCmNodW5rSW5kZXgSIAoLdG90YWxDaHVua3MYBSABKAVSC3RvdGFsQ2h1bmtz');

@$core.Deprecated('Use subirVideoResponseDescriptor instead')
const SubirVideoResponse$json = {
  '1': 'SubirVideoResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `SubirVideoResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List subirVideoResponseDescriptor = $convert.base64Decode(
    'ChJTdWJpclZpZGVvUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZXNzYW'
    'dlGAIgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use obtenerFotosRequestDescriptor instead')
const ObtenerFotosRequest$json = {
  '1': 'ObtenerFotosRequest',
  '2': [
    {'1': 'idReview', '3': 1, '4': 1, '5': 9, '10': 'idReview'},
  ],
};

/// Descriptor for `ObtenerFotosRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List obtenerFotosRequestDescriptor =
    $convert.base64Decode(
        'ChNPYnRlbmVyRm90b3NSZXF1ZXN0EhoKCGlkUmV2aWV3GAEgASgJUghpZFJldmlldw==');

@$core.Deprecated('Use fotoReviewInfoDescriptor instead')
const FotoReviewInfo$json = {
  '1': 'FotoReviewInfo',
  '2': [
    {'1': 'indice', '3': 1, '4': 1, '5': 5, '10': 'indice'},
    {'1': 'datos', '3': 2, '4': 1, '5': 12, '10': 'datos'},
  ],
};

/// Descriptor for `FotoReviewInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fotoReviewInfoDescriptor = $convert.base64Decode(
    'Cg5Gb3RvUmV2aWV3SW5mbxIWCgZpbmRpY2UYASABKAVSBmluZGljZRIUCgVkYXRvcxgCIAEoDF'
    'IFZGF0b3M=');

@$core.Deprecated('Use obtenerFotosResponseDescriptor instead')
const ObtenerFotosResponse$json = {
  '1': 'ObtenerFotosResponse',
  '2': [
    {
      '1': 'fotos',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.FotoReviewInfo',
      '10': 'fotos'
    },
    {'1': 'idReview', '3': 2, '4': 1, '5': 9, '10': 'idReview'},
  ],
};

/// Descriptor for `ObtenerFotosResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List obtenerFotosResponseDescriptor = $convert.base64Decode(
    'ChRPYnRlbmVyRm90b3NSZXNwb25zZRIlCgVmb3RvcxgBIAMoCzIPLkZvdG9SZXZpZXdJbmZvUg'
    'Vmb3RvcxIaCghpZFJldmlldxgCIAEoCVIIaWRSZXZpZXc=');

@$core.Deprecated('Use obtenerVideoRequestDescriptor instead')
const ObtenerVideoRequest$json = {
  '1': 'ObtenerVideoRequest',
  '2': [
    {'1': 'idReview', '3': 1, '4': 1, '5': 9, '10': 'idReview'},
  ],
};

/// Descriptor for `ObtenerVideoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List obtenerVideoRequestDescriptor =
    $convert.base64Decode(
        'ChNPYnRlbmVyVmlkZW9SZXF1ZXN0EhoKCGlkUmV2aWV3GAEgASgJUghpZFJldmlldw==');

@$core.Deprecated('Use videoChunkDescriptor instead')
const VideoChunk$json = {
  '1': 'VideoChunk',
  '2': [
    {'1': 'chunk', '3': 1, '4': 1, '5': 12, '10': 'chunk'},
    {'1': 'chunkIndex', '3': 2, '4': 1, '5': 5, '10': 'chunkIndex'},
    {'1': 'totalChunks', '3': 3, '4': 1, '5': 5, '10': 'totalChunks'},
  ],
};

/// Descriptor for `VideoChunk`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List videoChunkDescriptor = $convert.base64Decode(
    'CgpWaWRlb0NodW5rEhQKBWNodW5rGAEgASgMUgVjaHVuaxIeCgpjaHVua0luZGV4GAIgASgFUg'
    'pjaHVua0luZGV4EiAKC3RvdGFsQ2h1bmtzGAMgASgFUgt0b3RhbENodW5rcw==');

@$core.Deprecated('Use obtenerMetadataRequestDescriptor instead')
const ObtenerMetadataRequest$json = {
  '1': 'ObtenerMetadataRequest',
  '2': [
    {'1': 'idReview', '3': 1, '4': 1, '5': 9, '10': 'idReview'},
  ],
};

/// Descriptor for `ObtenerMetadataRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List obtenerMetadataRequestDescriptor =
    $convert.base64Decode(
        'ChZPYnRlbmVyTWV0YWRhdGFSZXF1ZXN0EhoKCGlkUmV2aWV3GAEgASgJUghpZFJldmlldw==');

@$core.Deprecated('Use metadataResponseDescriptor instead')
const MetadataResponse$json = {
  '1': 'MetadataResponse',
  '2': [
    {'1': 'numFotos', '3': 1, '4': 1, '5': 5, '10': 'numFotos'},
    {'1': 'numVideos', '3': 2, '4': 1, '5': 5, '10': 'numVideos'},
  ],
};

/// Descriptor for `MetadataResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List metadataResponseDescriptor = $convert.base64Decode(
    'ChBNZXRhZGF0YVJlc3BvbnNlEhoKCG51bUZvdG9zGAEgASgFUghudW1Gb3RvcxIcCgludW1WaW'
    'Rlb3MYAiABKAVSCW51bVZpZGVvcw==');

@$core.Deprecated('Use eliminarArchivosRequestDescriptor instead')
const EliminarArchivosRequest$json = {
  '1': 'EliminarArchivosRequest',
  '2': [
    {'1': 'idReview', '3': 1, '4': 1, '5': 9, '10': 'idReview'},
  ],
};

/// Descriptor for `EliminarArchivosRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List eliminarArchivosRequestDescriptor =
    $convert.base64Decode(
        'ChdFbGltaW5hckFyY2hpdm9zUmVxdWVzdBIaCghpZFJldmlldxgBIAEoCVIIaWRSZXZpZXc=');

@$core.Deprecated('Use eliminarArchivosResponseDescriptor instead')
const EliminarArchivosResponse$json = {
  '1': 'EliminarArchivosResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `EliminarArchivosResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List eliminarArchivosResponseDescriptor =
    $convert.base64Decode(
        'ChhFbGltaW5hckFyY2hpdm9zUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCg'
        'dtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
