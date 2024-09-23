import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/decoration_helpers/text_form_field_decoration-helpers/password_text_form_field_decoration.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:flutter/material.dart';


class PassWordTextFormField extends StatefulWidget {
  String hintText;
  TextEditingController controller;
  TextInputType inputType;
  ValueChanged onChanged;
  bool isReadOnly;
  //bool isHideInput;
  String? Function(String?)? validator;
  PassWordTextFormField({super.key,required this.onChanged,required this.controller,required this.hintText,required this.inputType,required this.validator,required this.isReadOnly});

  @override
  State<PassWordTextFormField> createState() => _PassWordTextFormFieldState();
}

class _PassWordTextFormFieldState extends State<PassWordTextFormField> {
  String hintText="";
  TextEditingController? controller;
  TextInputType? inputType;
  ValueChanged? onChanged;
  String? Function(String?)? validator;

  bool isHideInput=true;
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
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText:isHideInput,
      readOnly: widget.isReadOnly,
      controller: controller,
      style: TextStyle(
          color: COLORS.black,
          fontFamily: "Manrope",
          fontWeight: FontWeight.w500,
          letterSpacing: 0.3,
          fontSize: SizeConfig.blockWidth * 4),
      onChanged: onChanged,
      validator: validator,
      keyboardType: inputType,
      textCapitalization: TextCapitalization.words,
      textInputAction: TextInputAction.next,
      cursorColor: COLORS.gray,
      decoration: passwordTextFieldDecoration(hint: widget.hintText,isHideInputFunction: (value)
      {
        setState(() {
          isHideInput=value;
        });
      },isHideInput: isHideInput),
    );
  }
}







