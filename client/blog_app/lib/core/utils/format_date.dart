import 'package:intl/intl.dart';

String formatByDateDMMMYYYY(DateTime date) {
  final formatter = DateFormat('d MMM, yyyy');
  return formatter.format(date);
}