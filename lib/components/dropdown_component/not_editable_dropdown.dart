
import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/config.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:flutter/material.dart';

class NotEditableDropdownComponent extends StatelessWidget {
  final String text;
  const NotEditableDropdownComponent({super.key,required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.blockWidth * 100,
      height:SizeConfig.blockHeight * 7.3,
      padding: EdgeInsets.only(
        // top: SizeConfig.blockHeight*2,
          left: SizeConfig.blockWidth * 3.5,
          right: SizeConfig.blockWidth * 2.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 1.5),
        border: Border.all(color: COLORS.blue, width: 1.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
              color:  COLORS.blackMedium,
              fontWeight: FontWeight.w400,
              fontSize: SizeConfig.blockWidth * 4,
              fontFamily: Config.fountFamilyPrimary,
            ),
          ),
          Icon(
            Icons.keyboard_arrow_down,
            color: COLORS.blue,
            size: SizeConfig.blockWidth * 8,
          ),
        ],
      ),
    );
  }
}
