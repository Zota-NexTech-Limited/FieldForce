import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/config.dart';
import 'package:fieldsales/helper/decoration_helpers/text_form_field_decoration-helpers/normal_text_form_field_decoration.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:flutter/material.dart';

class MultiLineTextFormField extends StatefulWidget {
  String labelText;
  TextEditingController controller;
  TextInputType inputType;
  ValueChanged onChanged;
  bool isReadOnly;
  String? Function(String?)? validator;
  MultiLineTextFormField({super.key,required this.onChanged,required this.controller,required this.inputType,required this.validator,required this.isReadOnly,required this.labelText});

  @override
  State<MultiLineTextFormField> createState() => _MultiLineTextFormFieldState();
}

class _MultiLineTextFormFieldState extends State<MultiLineTextFormField> {
  TextEditingController? controller;
  TextInputType? inputType;
  String? Function(String?)? validator;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller=widget.controller;
    inputType=widget.inputType;
    validator=widget.validator;

  }
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 3,
      readOnly: widget.isReadOnly,
      controller: controller,
      style: TextStyle(
          color: COLORS.textColor,
          fontFamily: Config.fountFamilyPrimary,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.3,
          fontSize: SizeConfig.blockWidth * 4),
      onChanged: widget.onChanged,
      validator: validator,
      keyboardType: inputType,
      textCapitalization: TextCapitalization.words,
      textInputAction: TextInputAction.next,
      cursorColor: COLORS.primaryColor,
      decoration: textFieldDecoration(hint: widget.labelText),
    );
  }
}







