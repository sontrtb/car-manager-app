import 'package:intl/intl.dart';

class FormatDateIso {
  String formatToString(String dateString) {
    DateTime now = DateTime.parse(dateString).toLocal();
    var formatter = DateFormat('H:m - d/MM/y');
    var formatted = formatter.format(now);
    return formatted;
  }

  double hourBetween(String? fromString, String? toString) {
    if (fromString == null || toString == null) return 0;

    DateTime from = DateTime.parse(fromString).toLocal();
    DateTime to = DateTime.parse(toString).toLocal();

    return to.difference(from).inMinutes / 60;
  }
}
