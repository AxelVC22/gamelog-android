import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gamelog/core/network/dio_client.dart';

import '../../../core/domain/entities/account.dart';

enum AuthStatus { authenticated, unauthenticated, expired }

class AuthState {
  final AuthStatus status;

  const AuthState(this.status);

  const AuthState.authenticated() : status = AuthStatus.authenticated;

  const AuthState.unauthenticated() : status = AuthStatus.unauthenticated;

  const AuthState.expired() : status = AuthStatus.expired;
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier(this._storage) : super(const AuthState.unauthenticated());

  final FlutterSecureStorage _storage;

  Future<void> persistUser(Account account) async {
    final jsonString = jsonEncode(account.toJson());

    await _storage.write(key: 'current_user', value: jsonString);
  }

  Future<void> restoreUser(Ref ref) async {
    final rawUser = await _storage.read(key: 'current_user');

    if (rawUser == null) {
      return;
    }

    try {
      final account = Account.fromJson(jsonDecode(rawUser));
      ref.read(currentUserProvider.notifier).state = account;
    } catch (e) {
      await logout();
    }
  }

  Future<void> clearUser(Ref ref) async {
    await _storage.delete(key: 'current_user');
    ref.read(currentUserProvider.notifier).state = null;
  }

  Future<void> restoreSession() async {
    final accessToken = await _storage.read(key: 'access_token');
    final refreshToken = await _storage.read(key: 'refresh_token');

    if (accessToken != null && refreshToken != null) {
      state = const AuthState.authenticated();
    } else {
      state = const AuthState.unauthenticated();
    }
  }

  Future<void> logout() async {
    await _storage.delete(key: 'access_token');
    await _storage.delete(key: 'refresh_token');
    await _storage.delete(key: 'current_user');
    state = const AuthState.unauthenticated();
  }

  void expired() async {
    await logout();
  }

  void authenticated() {
    state = const AuthState.authenticated();
  }
}

final authStateProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final storage = ref.read(secureStorageProvider);
  return AuthNotifier(storage);
});

final authBootstrapProvider = FutureProvider<void>((ref) async {
  final auth = ref.read(authStateProvider.notifier);

  await auth.restoreSession();

  final authStatus = ref.read(authStateProvider).status;

  if (authStatus == AuthStatus.authenticated) {
    await auth.restoreUser(ref);
  }
});
