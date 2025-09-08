// ignore_for_file: constant_identifier_names

import 'package:intl/intl.dart';

enum DateFormatPattern {
  EEEEddMMMMyyyy('EEEE, dd MMMM yyyy'),
  hhmm('hh.mm');

  const DateFormatPattern(this.data);

  final String data;
}

class DateUtil {
  static String format(DateTime dateTime, DateFormatPattern pattern) {
    return DateFormat(pattern.data, 'id_ID').format(dateTime);
  }
}
