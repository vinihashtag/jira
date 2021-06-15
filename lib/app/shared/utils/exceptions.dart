class CustomException implements Exception {
  final String message;

  CustomException({required this.message});
}

class ConnectionException implements Exception {
  final String message;

  ConnectionException(
      {this.message = 'Sem conexão com a internet, verifique.'});
}
