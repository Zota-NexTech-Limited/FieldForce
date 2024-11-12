import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:flutter/material.dart';
class CircularButtonComponent extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  const CircularButtonComponent({super.key,required this.onTap,required this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor: COLORS.primaryColor,
        radius: SizeConfig.blockWidth*6,
        child: Icon(icon,color: COLORS.white,),
      ),
    );
  }
}
