// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$secureStorageHash() => r'1803ee54eebc4038de1cd19ff9f0850676721a7f';

/// See also [secureStorage].
@ProviderFor(secureStorage)
final secureStorageProvider = Provider<FlutterSecureStorage>.internal(
  secureStorage,
  name: r'secureStorageProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$secureStorageHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SecureStorageRef = ProviderRef<FlutterSecureStorage>;
String _$dioHash() => r'749cdeb129ae9a6661f9e3ec22f492ffc3a535dd';

/// See also [dio].
@ProviderFor(dio)
final dioProvider = Provider<Dio>.internal(
  dio,
  name: r'dioProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dioHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DioRef = ProviderRef<Dio>;
String _$authRepositoryHash() => r'382cbc427b0400ebecf17ba4f5f6588912a627e8';

/// See also [authRepository].
@ProviderFor(authRepository)
final authRepositoryProvider = Provider<AuthRepository>.internal(
  authRepository,
  name: r'authRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AuthRepositoryRef = ProviderRef<AuthRepository>;
String _$loginUseCaseHash() => r'c19591da812e8b7ab7dd1235ae74be1fb38cb6ae';

/// See also [loginUseCase].
@ProviderFor(loginUseCase)
final loginUseCaseProvider = Provider<LoginUseCase>.internal(
  loginUseCase,
  name: r'loginUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$loginUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LoginUseCaseRef = ProviderRef<LoginUseCase>;
String _$loginControllerHash() => r'81f509f238a89312a92c39b2fe333a35038d60fd';

/// See also [LoginController].
@ProviderFor(LoginController)
final loginControllerProvider =
    AutoDisposeAsyncNotifierProvider<LoginController, void>.internal(
      LoginController.new,
      name: r'loginControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$loginControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$LoginController = AutoDisposeAsyncNotifier<void>;
String _$recoverPasswordControllerHash() =>
    r'099b2b77be690beadceb248b44be66a77f9de33e';

/// See also [RecoverPasswordController].
@ProviderFor(RecoverPasswordController)
final recoverPasswordControllerProvider =
    AutoDisposeNotifierProvider<RecoverPasswordController, int>.internal(
      RecoverPasswordController.new,
      name: r'recoverPasswordControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$recoverPasswordControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$RecoverPasswordController = AutoDisposeNotifier<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
