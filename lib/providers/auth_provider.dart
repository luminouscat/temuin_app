import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:temuin_app/state/auth_state.dart';
import 'package:temuin_app/models/user.dart';
import 'package:temuin_app/providers/dio_provider.dart';
import 'package:temuin_app/repository/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.watch(baseDioProvider);
  return AuthRepository(dio);
});

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier(this._repository) : super(const AuthState()) {
    _initializeAuth();
  }

  final AuthRepository _repository;

  // load saved user on app start with shared pref
  Future<void> _initializeAuth() async {
    state = state.copyWith(isLoading: true);
    try {
      final user = await _repository.loadSavedUser();
      state = AuthState(user: user, isLoading: false);
    } catch (e) {
      state = AuthState(isLoading: false, errorMessage: e.toString());
    }
  }

  // login
  Future<void> login(String email, String password) async {
    state = state
        .copyWith(isLoading: true)
        .clearError(); // so that when the login fails, the error state is cleared for new error
    try {
      final user = await _repository.login(email, password);
      state = AuthState(user: user, isLoading: false);
    } catch (e) {
      state = AuthState(
        isLoading: false,
        errorMessage: e.toString().replaceAll('Exception: ', ''),
      );
    }
  }

  Future<void> logout() async {
    await _repository.logout();
    state = const AuthState();
  }
}

// main auth provider
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return AuthNotifier(repository);
});

// Convenience providers
final currentUserProvider = Provider<User?>((ref) {
  return ref.watch(authProvider).user;
});

// check if the user is logged in or not
final isAuthenticatedProvider = Provider<bool>((ref) {
  return ref.watch(authProvider).isAuthenticated;
});

// check influencer or company
final isInfluencerProvider = Provider<bool>((ref) {
  return ref.watch(authProvider).isInfluencer;
});

final isCompanyProvider = Provider<bool>((ref) {
  return ref.watch(authProvider).isCompany;
});
