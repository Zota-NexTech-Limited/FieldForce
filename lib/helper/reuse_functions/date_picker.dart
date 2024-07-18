

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


