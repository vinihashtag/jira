import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:jira_matic/app/shared/theme/app_theme.dart';

import 'app/routes/app_pages.dart';
import 'main_binding.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Default',
      debugShowCheckedModeBanner: false,
      enableLog: kDebugMode,
      getPages: AppPages.routes,
      theme: AppTheme.defaultTheme(context),
      initialRoute: Routes.home,
      initialBinding: MainBiniding(),
      builder: BotToastInit(),
      navigatorObservers: [
        BotToastNavigatorObserver(),
        // FirebaseAnalyticsObserver(analytics: analytics)
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt', 'BR')],
    );
  }
}
