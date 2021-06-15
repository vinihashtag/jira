import 'package:get/get.dart';

import '../../data/models/auth_model.dart';
import '../../data/repositories/authentication/authentication_repository.dart';
import '../adapters/toast/toast_facade_adapter.dart';

class AuthController extends GetxController {
  final IAuthenticationRepository _authenticationRepository;
  final ToastAdapter _toast;
  AuthController(this._authenticationRepository, this._toast);

  // * Controla os dados do usuário logado
  final _authUser = AuthModel().obs;
  AuthModel get user => _authUser.value;
  set user(AuthModel value) {
    _authUser
      ..value = value
      ..refresh();
  }

  bool get isLogged {
    try {
      // ? Caso perca a conexão, deve fazer o logout
      if (user.email.isNotEmpty) {
        _authenticationRepository.logout();
        user = AuthModel();
        _toast.info(text: 'Sessão expirada, faça o login novamente');
      }
      return user.email.isNotEmpty;
    } catch (e) {
      return false;
    }
  }
}
