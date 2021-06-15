// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';
// import 'package:get/get_utils/src/platform/platform.dart';
// import 'package:pedantic/pedantic.dart';

// import '../../components/custom_dialog.dart';
// import '../logger/logger_adapter.dart';

// abstract class PushNotificationAdapter {
//   Future<String> getToken();
//   Future<void> fcmSubscribe(String topic);
//   Future<void> fcmUnSubscribe(String topic);
//   void initPushNotification();
// }

// enum typePushNotification { closed, background, foreground }

// class PushNotificationAdapterImpl implements PushNotificationAdapter {
//   final LoggerAdapter _logger;

//   PushNotificationAdapterImpl(this._logger);

//   static final FirebaseMessaging _firebaseMessaging =
//       FirebaseMessaging.instance;

//   // * Retorna o token FCM do usuário
//   @override
//   Future<String> getToken() async {
//     try {
//       if (GetPlatform.isIOS) {
//         await _firebaseMessaging.requestPermission();
//         await _firebaseMessaging.setForegroundNotificationPresentationOptions(
//             badge: true, sound: true);
//       }

//       unawaited(fcmSubscribe('clients'));
//       return (await _firebaseMessaging.getToken()) ?? '';
//     } catch (e) {
//       _logger.error('Recuperar o token: $e');
//       return '';
//     }
//   }

//   // * Inscreve o usuário no tópico 'clients'
//   @override
//   Future<void> fcmSubscribe(String topic) async {
//     try {
//       await _firebaseMessaging.subscribeToTopic(topic);
//     } catch (e) {
//       _logger.error('Erro inserir do tópico: $e');
//     }
//   }

//   // * Remove inscrição do usuário no tópico 'clients'
//   @override
//   Future<void> fcmUnSubscribe(String topic) async {
//     try {
//       await _firebaseMessaging.unsubscribeFromTopic(topic);
//     } catch (e) {
//       _logger.error('Erro remover inscrição do tópico: $e');
//     }
//   }

//   //* Habilita o recebimento de notificações
//   @override
//   void initPushNotification() {
//     FirebaseMessaging.instance
//         .getInitialMessage()
//         .then((RemoteMessage? message) {
//       if (message != null && kDebugMode) {
//         _logger.debug('getInitialMessage: ${message.notification.toString()}');
//       }
//     });

//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       if (kDebugMode) {
//         _logger.debug('Mensagem com app minimizado: ');
//       }

//       _redirectsPush(message, typePushNotification.background);
//     });

//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       if (kDebugMode) {
//         _logger.debug('Mensagem com app em uso: ');
//       }

//       _redirectsPush(message, typePushNotification.foreground);
//     });
//   }

//   void _redirectsPush(
//       RemoteMessage? message, typePushNotification typeNotification) {
//     final titleNotification = message?.notification?.title ?? '';
//     final textNotification = message?.notification?.body ?? '';

//     CustomDialog.alert(
//       title: titleNotification,
//       text: textNotification,
//     );
//   }
// }
