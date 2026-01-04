// This is a generated file - do not edit.
//
// Generated from Multimedia_De_Resenia.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// ========== FOTOS (COMPLETAS) ==========
class SubirFotoRequest extends $pb.GeneratedMessage {
  factory SubirFotoRequest() => create();

  SubirFotoRequest._();

  factory SubirFotoRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SubirFotoRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SubirFotoRequest',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'idReview', protoName: 'idReview')
    ..aI(2, _omitFieldNames ? '' : 'indice')
    ..aOS(3, _omitFieldNames ? '' : 'extension')
    ..a<$core.List<$core.int>>(
        4, _omitFieldNames ? '' : 'datos', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubirFotoRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubirFotoRequest copyWith(void Function(SubirFotoRequest) updates) =>
      super.copyWith((message) => updates(message as SubirFotoRequest))
          as SubirFotoRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SubirFotoRequest create() => SubirFotoRequest._();
  @$core.override
  SubirFotoRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SubirFotoRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SubirFotoRequest>(create);
  static SubirFotoRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get idReview => $_getSZ(0);
  @$pb.TagNumber(1)
  set idReview($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasIdReview() => $_has(0);
  @$pb.TagNumber(1)
  void clearIdReview() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get indice => $_getIZ(1);
  @$pb.TagNumber(2)
  set indice($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasIndice() => $_has(1);
  @$pb.TagNumber(2)
  void clearIndice() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get extension_3 => $_getSZ(2);
  @$pb.TagNumber(3)
  set extension_3($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasExtension_3() => $_has(2);
  @$pb.TagNumber(3)
  void clearExtension_3() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.List<$core.int> get datos => $_getN(3);
  @$pb.TagNumber(4)
  set datos($core.List<$core.int> value) => $_setBytes(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDatos() => $_has(3);
  @$pb.TagNumber(4)
  void clearDatos() => $_clearField(4);
}

class SubirFotoResponse extends $pb.GeneratedMessage {
  factory SubirFotoResponse() => create();

  SubirFotoResponse._();

  factory SubirFotoResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SubirFotoResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SubirFotoResponse',
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubirFotoResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubirFotoResponse copyWith(void Function(SubirFotoResponse) updates) =>
      super.copyWith((message) => updates(message as SubirFotoResponse))
          as SubirFotoResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SubirFotoResponse create() => SubirFotoResponse._();
  @$core.override
  SubirFotoResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SubirFotoResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SubirFotoResponse>(create);
  static SubirFotoResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

/// ========== VIDEOS (POR CHUNKS) ==========
class ChunkVideoRequest extends $pb.GeneratedMessage {
  factory ChunkVideoRequest() => create();

  ChunkVideoRequest._();

  factory ChunkVideoRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ChunkVideoRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChunkVideoRequest',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'idReview', protoName: 'idReview')
    ..aOS(2, _omitFieldNames ? '' : 'extension')
    ..a<$core.List<$core.int>>(
        3, _omitFieldNames ? '' : 'chunk', $pb.PbFieldType.OY)
    ..aI(4, _omitFieldNames ? '' : 'chunkIndex', protoName: 'chunkIndex')
    ..aI(5, _omitFieldNames ? '' : 'totalChunks', protoName: 'totalChunks')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChunkVideoRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChunkVideoRequest copyWith(void Function(ChunkVideoRequest) updates) =>
      super.copyWith((message) => updates(message as ChunkVideoRequest))
          as ChunkVideoRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChunkVideoRequest create() => ChunkVideoRequest._();
  @$core.override
  ChunkVideoRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ChunkVideoRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChunkVideoRequest>(create);
  static ChunkVideoRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get idReview => $_getSZ(0);
  @$pb.TagNumber(1)
  set idReview($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasIdReview() => $_has(0);
  @$pb.TagNumber(1)
  void clearIdReview() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get extension_2 => $_getSZ(1);
  @$pb.TagNumber(2)
  set extension_2($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasExtension_2() => $_has(1);
  @$pb.TagNumber(2)
  void clearExtension_2() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.int> get chunk => $_getN(2);
  @$pb.TagNumber(3)
  set chunk($core.List<$core.int> value) => $_setBytes(2, value);
  @$pb.TagNumber(3)
  $core.bool hasChunk() => $_has(2);
  @$pb.TagNumber(3)
  void clearChunk() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get chunkIndex => $_getIZ(3);
  @$pb.TagNumber(4)
  set chunkIndex($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasChunkIndex() => $_has(3);
  @$pb.TagNumber(4)
  void clearChunkIndex() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get totalChunks => $_getIZ(4);
  @$pb.TagNumber(5)
  set totalChunks($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTotalChunks() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalChunks() => $_clearField(5);
}

class SubirVideoResponse extends $pb.GeneratedMessage {
  factory SubirVideoResponse() => create();

  SubirVideoResponse._();

  factory SubirVideoResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SubirVideoResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SubirVideoResponse',
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubirVideoResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubirVideoResponse copyWith(void Function(SubirVideoResponse) updates) =>
      super.copyWith((message) => updates(message as SubirVideoResponse))
          as SubirVideoResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SubirVideoResponse create() => SubirVideoResponse._();
  @$core.override
  SubirVideoResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SubirVideoResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SubirVideoResponse>(create);
  static SubirVideoResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

/// ========== OBTENER ==========
class ObtenerFotosRequest extends $pb.GeneratedMessage {
  factory ObtenerFotosRequest() => create();

  ObtenerFotosRequest._();

  factory ObtenerFotosRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ObtenerFotosRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ObtenerFotosRequest',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'idReview', protoName: 'idReview')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ObtenerFotosRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ObtenerFotosRequest copyWith(void Function(ObtenerFotosRequest) updates) =>
      super.copyWith((message) => updates(message as ObtenerFotosRequest))
          as ObtenerFotosRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ObtenerFotosRequest create() => ObtenerFotosRequest._();
  @$core.override
  ObtenerFotosRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ObtenerFotosRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ObtenerFotosRequest>(create);
  static ObtenerFotosRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get idReview => $_getSZ(0);
  @$pb.TagNumber(1)
  set idReview($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasIdReview() => $_has(0);
  @$pb.TagNumber(1)
  void clearIdReview() => $_clearField(1);
}

class FotoReviewInfo extends $pb.GeneratedMessage {
  factory FotoReviewInfo() => create();

  FotoReviewInfo._();

  factory FotoReviewInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FotoReviewInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FotoReviewInfo',
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'indice')
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'datos', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FotoReviewInfo clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FotoReviewInfo copyWith(void Function(FotoReviewInfo) updates) =>
      super.copyWith((message) => updates(message as FotoReviewInfo))
          as FotoReviewInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FotoReviewInfo create() => FotoReviewInfo._();
  @$core.override
  FotoReviewInfo createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static FotoReviewInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FotoReviewInfo>(create);
  static FotoReviewInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get indice => $_getIZ(0);
  @$pb.TagNumber(1)
  set indice($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasIndice() => $_has(0);
  @$pb.TagNumber(1)
  void clearIndice() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get datos => $_getN(1);
  @$pb.TagNumber(2)
  set datos($core.List<$core.int> value) => $_setBytes(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDatos() => $_has(1);
  @$pb.TagNumber(2)
  void clearDatos() => $_clearField(2);
}

class ObtenerFotosResponse extends $pb.GeneratedMessage {
  factory ObtenerFotosResponse() => create();

  ObtenerFotosResponse._();

  factory ObtenerFotosResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ObtenerFotosResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ObtenerFotosResponse',
      createEmptyInstance: create)
    ..pPM<FotoReviewInfo>(1, _omitFieldNames ? '' : 'fotos',
        subBuilder: FotoReviewInfo.create)
    ..aOS(2, _omitFieldNames ? '' : 'idReview', protoName: 'idReview')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ObtenerFotosResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ObtenerFotosResponse copyWith(void Function(ObtenerFotosResponse) updates) =>
      super.copyWith((message) => updates(message as ObtenerFotosResponse))
          as ObtenerFotosResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ObtenerFotosResponse create() => ObtenerFotosResponse._();
  @$core.override
  ObtenerFotosResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ObtenerFotosResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ObtenerFotosResponse>(create);
  static ObtenerFotosResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<FotoReviewInfo> get fotos => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get idReview => $_getSZ(1);
  @$pb.TagNumber(2)
  set idReview($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasIdReview() => $_has(1);
  @$pb.TagNumber(2)
  void clearIdReview() => $_clearField(2);
}

class ObtenerVideoRequest extends $pb.GeneratedMessage {
  factory ObtenerVideoRequest() => create();

  ObtenerVideoRequest._();

  factory ObtenerVideoRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ObtenerVideoRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ObtenerVideoRequest',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'idReview', protoName: 'idReview')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ObtenerVideoRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ObtenerVideoRequest copyWith(void Function(ObtenerVideoRequest) updates) =>
      super.copyWith((message) => updates(message as ObtenerVideoRequest))
          as ObtenerVideoRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ObtenerVideoRequest create() => ObtenerVideoRequest._();
  @$core.override
  ObtenerVideoRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ObtenerVideoRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ObtenerVideoRequest>(create);
  static ObtenerVideoRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get idReview => $_getSZ(0);
  @$pb.TagNumber(1)
  set idReview($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasIdReview() => $_has(0);
  @$pb.TagNumber(1)
  void clearIdReview() => $_clearField(1);
}

class VideoChunk extends $pb.GeneratedMessage {
  factory VideoChunk() => create();

  VideoChunk._();

  factory VideoChunk.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VideoChunk.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VideoChunk',
      createEmptyInstance: create)
    ..a<$core.List<$core.int>>(
        1, _omitFieldNames ? '' : 'chunk', $pb.PbFieldType.OY)
    ..aI(2, _omitFieldNames ? '' : 'chunkIndex', protoName: 'chunkIndex')
    ..aI(3, _omitFieldNames ? '' : 'totalChunks', protoName: 'totalChunks')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VideoChunk clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VideoChunk copyWith(void Function(VideoChunk) updates) =>
      super.copyWith((message) => updates(message as VideoChunk)) as VideoChunk;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VideoChunk create() => VideoChunk._();
  @$core.override
  VideoChunk createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static VideoChunk getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VideoChunk>(create);
  static VideoChunk? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get chunk => $_getN(0);
  @$pb.TagNumber(1)
  set chunk($core.List<$core.int> value) => $_setBytes(0, value);
  @$pb.TagNumber(1)
  $core.bool hasChunk() => $_has(0);
  @$pb.TagNumber(1)
  void clearChunk() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get chunkIndex => $_getIZ(1);
  @$pb.TagNumber(2)
  set chunkIndex($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasChunkIndex() => $_has(1);
  @$pb.TagNumber(2)
  void clearChunkIndex() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get totalChunks => $_getIZ(2);
  @$pb.TagNumber(3)
  set totalChunks($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalChunks() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalChunks() => $_clearField(3);
}

/// ========== OTROS ==========
class ObtenerMetadataRequest extends $pb.GeneratedMessage {
  factory ObtenerMetadataRequest() => create();

  ObtenerMetadataRequest._();

  factory ObtenerMetadataRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ObtenerMetadataRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ObtenerMetadataRequest',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'idReview', protoName: 'idReview')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ObtenerMetadataRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ObtenerMetadataRequest copyWith(
          void Function(ObtenerMetadataRequest) updates) =>
      super.copyWith((message) => updates(message as ObtenerMetadataRequest))
          as ObtenerMetadataRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ObtenerMetadataRequest create() => ObtenerMetadataRequest._();
  @$core.override
  ObtenerMetadataRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ObtenerMetadataRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ObtenerMetadataRequest>(create);
  static ObtenerMetadataRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get idReview => $_getSZ(0);
  @$pb.TagNumber(1)
  set idReview($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasIdReview() => $_has(0);
  @$pb.TagNumber(1)
  void clearIdReview() => $_clearField(1);
}

class MetadataResponse extends $pb.GeneratedMessage {
  factory MetadataResponse() => create();

  MetadataResponse._();

  factory MetadataResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MetadataResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MetadataResponse',
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'numFotos', protoName: 'numFotos')
    ..aI(2, _omitFieldNames ? '' : 'numVideos', protoName: 'numVideos')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MetadataResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MetadataResponse copyWith(void Function(MetadataResponse) updates) =>
      super.copyWith((message) => updates(message as MetadataResponse))
          as MetadataResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MetadataResponse create() => MetadataResponse._();
  @$core.override
  MetadataResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MetadataResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MetadataResponse>(create);
  static MetadataResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get numFotos => $_getIZ(0);
  @$pb.TagNumber(1)
  set numFotos($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasNumFotos() => $_has(0);
  @$pb.TagNumber(1)
  void clearNumFotos() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get numVideos => $_getIZ(1);
  @$pb.TagNumber(2)
  set numVideos($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNumVideos() => $_has(1);
  @$pb.TagNumber(2)
  void clearNumVideos() => $_clearField(2);
}

class EliminarArchivosRequest extends $pb.GeneratedMessage {
  factory EliminarArchivosRequest() => create();

  EliminarArchivosRequest._();

  factory EliminarArchivosRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EliminarArchivosRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EliminarArchivosRequest',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'idReview', protoName: 'idReview')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EliminarArchivosRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EliminarArchivosRequest copyWith(
          void Function(EliminarArchivosRequest) updates) =>
      super.copyWith((message) => updates(message as EliminarArchivosRequest))
          as EliminarArchivosRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EliminarArchivosRequest create() => EliminarArchivosRequest._();
  @$core.override
  EliminarArchivosRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static EliminarArchivosRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EliminarArchivosRequest>(create);
  static EliminarArchivosRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get idReview => $_getSZ(0);
  @$pb.TagNumber(1)
  set idReview($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasIdReview() => $_has(0);
  @$pb.TagNumber(1)
  void clearIdReview() => $_clearField(1);
}

class EliminarArchivosResponse extends $pb.GeneratedMessage {
  factory EliminarArchivosResponse() => create();

  EliminarArchivosResponse._();

  factory EliminarArchivosResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EliminarArchivosResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EliminarArchivosResponse',
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EliminarArchivosResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EliminarArchivosResponse copyWith(
          void Function(EliminarArchivosResponse) updates) =>
      super.copyWith((message) => updates(message as EliminarArchivosResponse))
          as EliminarArchivosResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EliminarArchivosResponse create() => EliminarArchivosResponse._();
  @$core.override
  EliminarArchivosResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static EliminarArchivosResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EliminarArchivosResponse>(create);
  static EliminarArchivosResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
