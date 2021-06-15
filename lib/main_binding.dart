import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:jira_matic/app/shared/adapters/rest_client/rest_client_adapter.dart';
import 'package:logger/logger.dart';

import 'app/data/repositories/authentication/authentication_repository.dart';
import 'app/shared/adapters/logger/logger_adapter.dart';
import 'app/shared/adapters/toast/toast_facade_adapter.dart';
import 'app/shared/controllers/auth_controller.dart';

class MainBiniding extends Bindings {
  @override
  void dependencies() {
    // * Plugins
    Get.put<Dio>(Dio());

    // * Adapters
    Get.put<LoggerAdapter>(LoggerAdapterImpl(Logger()));
    Get.put<ToastAdapter>(ToastAdapterImpl());
    Get.put<RestClientAdapter>(RestClientAdapterImpl());
    // Get.put<NetworkInfoAdapter>(
    //     NetworkCheckAdapterImpl(DataConnectionChecker(), Get.find()));
    // Get.put<PushNotificationAdapter>(PushNotificationAdapterImpl(Get.find()));

    // * Repositories
    Get.put<IAuthenticationRepository>(AuthenticationRepository(Get.find()));

    // * Global Controllers
    Get.put<AuthController>(AuthController(Get.find(), Get.find()));
  }
}
