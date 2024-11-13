
import 'package:fieldsales/components/text_component/normal_text.dart';
import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:flutter/material.dart';
class FileUploadButton extends StatelessWidget {
  final VoidCallback onTap;
  final String leadingText;
  final String actionText;
  const FileUploadButton({super.key,required this.onTap,required this.actionText,required this.leadingText});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*4),
        height: SizeConfig.blockHeight*7,
        width: SizeConfig.screenWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*2)),
          border: Border.all(color: COLORS.gray.withOpacity(0.3))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            NormalText(fontWeight: FontWeight.w500, color: COLORS.gray, fontSize: 2.2, text: leadingText),
            NormalText(fontWeight: FontWeight.w500, color: COLORS.iconColor, fontSize:2.3, text: actionText),
          ],
        ),
      ),
    );
  }
}
