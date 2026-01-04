// This is a generated file - do not edit.
//
// Generated from Fotos_De_Perfil.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class FotoRequest extends $pb.GeneratedMessage {
  factory FotoRequest() => create();

  FotoRequest._();

  factory FotoRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FotoRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FotoRequest',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'idJugador', protoName: 'idJugador')
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'datos', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FotoRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FotoRequest copyWith(void Function(FotoRequest) updates) =>
      super.copyWith((message) => updates(message as FotoRequest))
          as FotoRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FotoRequest create() => FotoRequest._();
  @$core.override
  FotoRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static FotoRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FotoRequest>(create);
  static FotoRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get idJugador => $_getSZ(0);
  @$pb.TagNumber(1)
  set idJugador($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasIdJugador() => $_has(0);
  @$pb.TagNumber(1)
  void clearIdJugador() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get datos => $_getN(1);
  @$pb.TagNumber(2)
  set datos($core.List<$core.int> value) => $_setBytes(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDatos() => $_has(1);
  @$pb.TagNumber(2)
  void clearDatos() => $_clearField(2);
}

class FotoResponse extends $pb.GeneratedMessage {
  factory FotoResponse() => create();

  FotoResponse._();

  factory FotoResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FotoResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FotoResponse',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'idJugador', protoName: 'idJugador')
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'datos', $pb.PbFieldType.OY)
    ..aOB(3, _omitFieldNames ? '' : 'success')
    ..aOS(4, _omitFieldNames ? '' : 'message')
    ..aOB(5, _omitFieldNames ? '' : 'esDefault', protoName: 'esDefault')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FotoResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FotoResponse copyWith(void Function(FotoResponse) updates) =>
      super.copyWith((message) => updates(message as FotoResponse))
          as FotoResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FotoResponse create() => FotoResponse._();
  @$core.override
  FotoResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static FotoResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FotoResponse>(create);
  static FotoResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get idJugador => $_getSZ(0);
  @$pb.TagNumber(1)
  set idJugador($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasIdJugador() => $_has(0);
  @$pb.TagNumber(1)
  void clearIdJugador() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get datos => $_getN(1);
  @$pb.TagNumber(2)
  set datos($core.List<$core.int> value) => $_setBytes(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDatos() => $_has(1);
  @$pb.TagNumber(2)
  void clearDatos() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get success => $_getBF(2);
  @$pb.TagNumber(3)
  set success($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSuccess() => $_has(2);
  @$pb.TagNumber(3)
  void clearSuccess() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get message => $_getSZ(3);
  @$pb.TagNumber(4)
  set message($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearMessage() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get esDefault => $_getBF(4);
  @$pb.TagNumber(5)
  set esDefault($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasEsDefault() => $_has(4);
  @$pb.TagNumber(5)
  void clearEsDefault() => $_clearField(5);
}

class MultipleFotosRequest extends $pb.GeneratedMessage {
  factory MultipleFotosRequest() => create();

  MultipleFotosRequest._();

  factory MultipleFotosRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MultipleFotosRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MultipleFotosRequest',
      createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'idsJugadores', protoName: 'idsJugadores')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MultipleFotosRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MultipleFotosRequest copyWith(void Function(MultipleFotosRequest) updates) =>
      super.copyWith((message) => updates(message as MultipleFotosRequest))
          as MultipleFotosRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MultipleFotosRequest create() => MultipleFotosRequest._();
  @$core.override
  MultipleFotosRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MultipleFotosRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MultipleFotosRequest>(create);
  static MultipleFotosRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get idsJugadores => $_getList(0);
}

class FotoInfo extends $pb.GeneratedMessage {
  factory FotoInfo() => create();

  FotoInfo._();

  factory FotoInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FotoInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FotoInfo',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'idJugador', protoName: 'idJugador')
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'datos', $pb.PbFieldType.OY)
    ..aOB(3, _omitFieldNames ? '' : 'tieneFoto', protoName: 'tieneFoto')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FotoInfo clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FotoInfo copyWith(void Function(FotoInfo) updates) =>
      super.copyWith((message) => updates(message as FotoInfo)) as FotoInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FotoInfo create() => FotoInfo._();
  @$core.override
  FotoInfo createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static FotoInfo getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FotoInfo>(create);
  static FotoInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get idJugador => $_getSZ(0);
  @$pb.TagNumber(1)
  set idJugador($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasIdJugador() => $_has(0);
  @$pb.TagNumber(1)
  void clearIdJugador() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get datos => $_getN(1);
  @$pb.TagNumber(2)
  set datos($core.List<$core.int> value) => $_setBytes(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDatos() => $_has(1);
  @$pb.TagNumber(2)
  void clearDatos() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get tieneFoto => $_getBF(2);
  @$pb.TagNumber(3)
  set tieneFoto($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTieneFoto() => $_has(2);
  @$pb.TagNumber(3)
  void clearTieneFoto() => $_clearField(3);
}

class MultipleFotosResponse extends $pb.GeneratedMessage {
  factory MultipleFotosResponse() => create();

  MultipleFotosResponse._();

  factory MultipleFotosResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MultipleFotosResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MultipleFotosResponse',
      createEmptyInstance: create)
    ..pPM<FotoInfo>(1, _omitFieldNames ? '' : 'fotos',
        subBuilder: FotoInfo.create)
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'fotoDefault', $pb.PbFieldType.OY,
        protoName: 'fotoDefault')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MultipleFotosResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MultipleFotosResponse copyWith(
          void Function(MultipleFotosResponse) updates) =>
      super.copyWith((message) => updates(message as MultipleFotosResponse))
          as MultipleFotosResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MultipleFotosResponse create() => MultipleFotosResponse._();
  @$core.override
  MultipleFotosResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MultipleFotosResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MultipleFotosResponse>(create);
  static MultipleFotosResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<FotoInfo> get fotos => $_getList(0);

  @$pb.TagNumber(2)
  $core.List<$core.int> get fotoDefault => $_getN(1);
  @$pb.TagNumber(2)
  set fotoDefault($core.List<$core.int> value) => $_setBytes(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFotoDefault() => $_has(1);
  @$pb.TagNumber(2)
  void clearFotoDefault() => $_clearField(2);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
