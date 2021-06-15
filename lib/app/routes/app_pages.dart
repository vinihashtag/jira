import 'package:get/get.dart';

import 'package:jira_matic/app/modules/home/home_binding.dart';
import 'package:jira_matic/app/modules/home/home_view.dart';
import 'package:jira_matic/app/modules/login/login_binding.dart';
import 'package:jira_matic/app/modules/login/login_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.home;

  static final routes = [
    GetPage(
      name: _Paths.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
  ];
}
