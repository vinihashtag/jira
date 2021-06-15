import 'package:jira_matic/app/shared/adapters/rest_client/rest_client_adapter.dart';

import '../../models/auth_model.dart';

abstract class IAuthenticationRepository {
  Future<AuthModel> login(String email, String password);
  Future<void> logout();
  Future<AuthModel> createAccount();
  AuthModel getAuthUser();
  Future<void> changePassword(String password);
  Future<void> forgotPassword(String email);
}

class AuthenticationRepository implements IAuthenticationRepository {
  final RestClientAdapter restClientAdapter;

  AuthenticationRepository(this.restClientAdapter);

  @override
  Future<void> changePassword(String password) {
    throw UnimplementedError();
  }

  @override
  Future<AuthModel> createAccount() {
    throw UnimplementedError();
  }

  @override
  Future<void> forgotPassword(String email) {
    throw UnimplementedError();
  }

  @override
  AuthModel getAuthUser() {
    throw UnimplementedError();
  }

  @override
  Future<AuthModel> login(String email, String password) {
    throw UnimplementedError();
  }

  @override
  Future<void> logout() {
    throw UnimplementedError();
  }
}
