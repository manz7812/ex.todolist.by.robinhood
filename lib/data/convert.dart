import 'package:intl/intl.dart';

String dateConverter(String myDate) {
  String? date;
  DateTime convertedDate = DateFormat("dd/MM/yyyy").parse(myDate.toString());
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = DateTime(now.year, now.month, now.day - 1);
  final tomorrow = DateTime(now.year, now.month, now.day + 1);

  final dateToCheck = convertedDate;
  final checkDate = DateTime(dateToCheck.year, dateToCheck.month, dateToCheck.day);
  if (checkDate == today) {
    date = "Today";
  } else if (checkDate == yesterday) {
    date = "Yesterday";
  } else if (checkDate == tomorrow) {
    date = "Tomorrow";
  } else {
    // print('myDate ---> $myDate');
    var strDate = DateFormat('dd/MM/yyyy').parse(myDate);
    var outputFormat = DateFormat('dd MMM yyyy');
    var outputDate = outputFormat.format(strDate).toUpperCase();
    // print('outputDate ---> $outputDate');
    date = outputDate;
  }
  return date;
}