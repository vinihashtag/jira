// import 'package:data_connection_checker_tv/data_connection_checker.dart';
// import 'package:jira_matic/app/shared/adapters/logger/logger_adapter.dart';

// abstract class NetworkInfoAdapter {
//   Future<bool> isConnected();
// }

// class NetworkCheckAdapterImpl implements NetworkInfoAdapter {
//   final DataConnectionChecker _dataConnectionChecker;
//   final LoggerAdapter _logger;

//   NetworkCheckAdapterImpl(this._dataConnectionChecker, this._logger);

//   @override
//   Future<bool> isConnected() async {
//     try {
//       return await _dataConnectionChecker.hasConnection;
//     } on Exception catch (e) {
//       _logger.warning('Erro ao verificar rede: $e');
//       return false;
//     }
//   }
// }
