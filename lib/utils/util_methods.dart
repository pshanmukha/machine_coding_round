import 'package:intl/intl.dart';

String formatTimeRange(DateTime startDate, DateTime endDate) {
  final dateFormat = DateFormat('hh:mm a');
  return "${dateFormat.format(startDate)} - ${dateFormat.format(endDate)}";
}