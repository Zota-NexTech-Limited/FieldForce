

 import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


   showSingleDatePickerHelper({required BuildContext context,required TextEditingController controller}) async {
    List<DateTime?> _singleDatePickerValueWithDefaultValue = [
      DateTime.now().add(const Duration(days: 1)),
    ];
    final DateTime? picked = await showDatePicker(
      context: context,
      // initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 0),
      lastDate: DateTime(DateTime.now().year + 100),
    );
    if (picked != null && picked != _singleDatePickerValueWithDefaultValue[0]) {
      _singleDatePickerValueWithDefaultValue[0] = picked;
      String formattedDate = '${picked.year}-${picked.month}-${picked.day}';
      controller.text= formattedDate;
    }
  }


 Future<void> showDateRangePickerHelper({
   required BuildContext context,
   required TextEditingController controller,
 }) async {
   // Open date range picker
   final DateTimeRange? picked = await showDateRangePicker(
     context: context,
     firstDate: DateTime(DateTime.now().year - 0),
     lastDate: DateTime(DateTime.now().year + 100),
     initialDateRange: DateTimeRange(
       start: DateTime.now(),
       end: DateTime.now().add(Duration(days: 1)),
     ),
   );

   // Check if the user picked a date range
   if (picked != null) {
     // Format the start and end date of the range
     String formattedStartDate = '${picked.start.year}-${picked.start.month}-${picked.start.day}';
     String formattedEndDate = '${picked.end.year}-${picked.end.month}-${picked.end.day}';

     // Update the text controller with the formatted date range
     controller.text = '$formattedStartDate to $formattedEndDate';
   }
 }


 Future<void> showSingleDatePickerHelper2({
   required BuildContext context,
   required Function(String) onDateSelected,
 }) async {
   List<DateTime?> _singleDatePickerValueWithDefaultValue = [
     DateTime.now().add(const Duration(days: 1)),
   ];
   final DateTime? picked = await showDatePicker(
     context: context,
     firstDate: DateTime(DateTime.now().year - 0),
     lastDate: DateTime(DateTime.now().year + 100),
   );
   if (picked != null && picked != _singleDatePickerValueWithDefaultValue[0]) {
     _singleDatePickerValueWithDefaultValue[0] = picked;
     String formattedDate = '${picked.year}-${picked.month}-${picked.day}';
     onDateSelected(formattedDate);
   }
 }



