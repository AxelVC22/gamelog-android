// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reviews_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$apiKeyHash() => r'f5586068bebebf38b00a0b73f4ea0a33261bd0d1';

/// See also [apiKey].
@ProviderFor(apiKey)
final apiKeyProvider = AutoDisposeProvider<String>.internal(
  apiKey,
  name: r'apiKeyProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$apiKeyHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ApiKeyRef = AutoDisposeProviderRef<String>;
String _$dioRawgHash() => r'b0e8fcddbb494ee1f31b2ab92a741a30412f47e8';

/// See also [dioRawg].
@ProviderFor(dioRawg)
final dioRawgProvider = AutoDisposeProvider<Dio>.internal(
  dioRawg,
  name: r'dioRawgProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dioRawgHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DioRawgRef = AutoDisposeProviderRef<Dio>;
String _$reviewManagementRepositoryHash() =>
    r'e98318e67f9536cb3c8c22477a76fab24f5cddbc';

/// See also [reviewManagementRepository].
@ProviderFor(reviewManagementRepository)
final reviewManagementRepositoryProvider =
    AutoDisposeProvider<ReviewsRepository>.internal(
      reviewManagementRepository,
      name: r'reviewManagementRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$reviewManagementRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ReviewManagementRepositoryRef =
    AutoDisposeProviderRef<ReviewsRepository>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
