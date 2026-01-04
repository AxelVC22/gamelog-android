// This is a generated file - do not edit.
//
// Generated from Fotos_De_Perfil.proto.

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

@$core.Deprecated('Use fotoRequestDescriptor instead')
const FotoRequest$json = {
  '1': 'FotoRequest',
  '2': [
    {'1': 'idJugador', '3': 1, '4': 1, '5': 9, '10': 'idJugador'},
    {'1': 'datos', '3': 2, '4': 1, '5': 12, '10': 'datos'},
  ],
};

/// Descriptor for `FotoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fotoRequestDescriptor = $convert.base64Decode(
    'CgtGb3RvUmVxdWVzdBIcCglpZEp1Z2Fkb3IYASABKAlSCWlkSnVnYWRvchIUCgVkYXRvcxgCIA'
    'EoDFIFZGF0b3M=');

@$core.Deprecated('Use fotoResponseDescriptor instead')
const FotoResponse$json = {
  '1': 'FotoResponse',
  '2': [
    {'1': 'idJugador', '3': 1, '4': 1, '5': 9, '10': 'idJugador'},
    {'1': 'datos', '3': 2, '4': 1, '5': 12, '10': 'datos'},
    {'1': 'success', '3': 3, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
    {'1': 'esDefault', '3': 5, '4': 1, '5': 8, '10': 'esDefault'},
  ],
};

/// Descriptor for `FotoResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fotoResponseDescriptor = $convert.base64Decode(
    'CgxGb3RvUmVzcG9uc2USHAoJaWRKdWdhZG9yGAEgASgJUglpZEp1Z2Fkb3ISFAoFZGF0b3MYAi'
    'ABKAxSBWRhdG9zEhgKB3N1Y2Nlc3MYAyABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgEIAEoCVIH'
    'bWVzc2FnZRIcCgllc0RlZmF1bHQYBSABKAhSCWVzRGVmYXVsdA==');

@$core.Deprecated('Use multipleFotosRequestDescriptor instead')
const MultipleFotosRequest$json = {
  '1': 'MultipleFotosRequest',
  '2': [
    {'1': 'idsJugadores', '3': 1, '4': 3, '5': 9, '10': 'idsJugadores'},
  ],
};

/// Descriptor for `MultipleFotosRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List multipleFotosRequestDescriptor = $convert.base64Decode(
    'ChRNdWx0aXBsZUZvdG9zUmVxdWVzdBIiCgxpZHNKdWdhZG9yZXMYASADKAlSDGlkc0p1Z2Fkb3'
    'Jlcw==');

@$core.Deprecated('Use fotoInfoDescriptor instead')
const FotoInfo$json = {
  '1': 'FotoInfo',
  '2': [
    {'1': 'idJugador', '3': 1, '4': 1, '5': 9, '10': 'idJugador'},
    {'1': 'datos', '3': 2, '4': 1, '5': 12, '10': 'datos'},
    {'1': 'tieneFoto', '3': 3, '4': 1, '5': 8, '10': 'tieneFoto'},
  ],
};

/// Descriptor for `FotoInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fotoInfoDescriptor = $convert.base64Decode(
    'CghGb3RvSW5mbxIcCglpZEp1Z2Fkb3IYASABKAlSCWlkSnVnYWRvchIUCgVkYXRvcxgCIAEoDF'
    'IFZGF0b3MSHAoJdGllbmVGb3RvGAMgASgIUgl0aWVuZUZvdG8=');

@$core.Deprecated('Use multipleFotosResponseDescriptor instead')
const MultipleFotosResponse$json = {
  '1': 'MultipleFotosResponse',
  '2': [
    {'1': 'fotos', '3': 1, '4': 3, '5': 11, '6': '.FotoInfo', '10': 'fotos'},
    {'1': 'fotoDefault', '3': 2, '4': 1, '5': 12, '10': 'fotoDefault'},
  ],
};

/// Descriptor for `MultipleFotosResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List multipleFotosResponseDescriptor = $convert.base64Decode(
    'ChVNdWx0aXBsZUZvdG9zUmVzcG9uc2USHwoFZm90b3MYASADKAsyCS5Gb3RvSW5mb1IFZm90b3'
    'MSIAoLZm90b0RlZmF1bHQYAiABKAxSC2ZvdG9EZWZhdWx0');
