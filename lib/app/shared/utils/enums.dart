import 'package:intl/intl.dart';

enum StatusScreen { initial, loading, empty, generic, sucess, error }

extension StatusScreenExtension on StatusScreen {
  static dynamic _data;
  dynamic get data => _data;
  set data(value) => _data = value;
}

// * Extension data e horário
extension FormattedDate on DateTime {
  String get onlyDate {
    return DateFormat('dd/MM/yyyy').format(this);
  }

  String get onlyTime {
    return DateFormat('HH:mm').format(this);
  }

  String get dateAndHour {
    return DateFormat('dd/MM/yyyy HH:mm').format(this);
  }
}

// * Extension dinheiro
extension FormattedNum on num {
  String get formattedMoneyBR {
    return NumberFormat.simpleCurrency(locale: 'pt_BR', decimalDigits: 2)
        .format(this);
  }
}
