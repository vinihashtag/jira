import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jira_matic/app/shared/components/custom_drawer.dart';

import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: controller.scaffolKey,
        drawer: const CustomDrawer(),
        body: Container());
  }
}
