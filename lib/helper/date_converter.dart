import 'package:intl/intl.dart';

 DateFormetConvertHelper({required String date}) {
  String dateTimeString = date;
  DateTime dateTime = DateTime.parse(dateTimeString);
  String formattedDate = DateFormat('dd MMM yyyy').format(dateTime);
 return formattedDate;
}