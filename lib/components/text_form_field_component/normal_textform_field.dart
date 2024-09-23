import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/config.dart';
import 'package:fieldsales/helper/decoration_helpers/text_form_field_decoration-helpers/normal_text_form_field_decoration.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:flutter/material.dart';

class NormalTextFormField extends StatefulWidget {
   String hintText;
   bool readOnly;
   TextEditingController controller;
   TextInputType inputType;
   ValueChanged onChanged;
   String? Function(String?)? validator;
   NormalTextFormField({super.key,required this.onChanged,required this.controller,required this.hintText,required this.inputType,required this.validator,required this.readOnly});

  @override
  State<NormalTextFormField> createState() => _NormalTextFormFieldState();
}

class _NormalTextFormFieldState extends State<NormalTextFormField> {
  String hintText="";
  TextEditingController? controller;
  TextInputType? inputType;
  ValueChanged? onChanged;
  String? Function(String?)? validator;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     hintText=widget.hintText;
     controller=widget.controller;
     inputType=widget.inputType;
     onChanged=widget.onChanged;
      validator=widget.validator;

  }
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly:widget.readOnly ,
      controller: controller,
      style: TextStyle(
          color: COLORS.blackMedium,
          fontFamily: Config.fountFamilyPrimary,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.3,
          fontSize: SizeConfig.blockWidth * 4),
      onChanged: onChanged,
      validator: validator,
      keyboardType: inputType,
      textCapitalization: TextCapitalization.words,
      textInputAction: TextInputAction.next,
      cursorColor: COLORS.blue,
      decoration: textFieldDecoration(hint:hintText),
    );
  }
}







