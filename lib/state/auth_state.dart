import 'package:temuin_app/models/user.dart';

class AuthState {
  const AuthState({this.user, this.isLoading = false, this.errorMessage});

  final User? user;
  final bool isLoading;
  final String? errorMessage;

  // getters
  bool get isAuthenticated => user != null;
  bool get isInfluencer => user?.isInfluencer ?? false;
  bool get isCompany => user?.isCompany ?? false;

  // copyWith
  AuthState copyWith({User? user, bool? isLoading, String? errorMessage}) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  // clear error
  AuthState clearError() {
    return AuthState(user: user, isLoading: isLoading, errorMessage: null);
  }
}
