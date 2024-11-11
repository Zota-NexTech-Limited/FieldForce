import 'dart:ui';

import 'package:fieldsales/components/app_bar_component/app_bar_component.dart';
import 'package:fieldsales/components/text_component/normal_text.dart';
import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:fieldsales/ui/menu/report/day_plan_report_screen.dart';
import 'package:flutter/material.dart';
class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: appBarComponent(
              context: context,
              title: "Reports"
          ),
          body: Container(
            width: SizeConfig.screenWidth,
            color:COLORS.white,
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*4,vertical: SizeConfig.blockHeight*2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NormalText(fontWeight: FontWeight.w600, color: COLORS.black, fontSize: 2,  text: "Sales / Purchase Reports"),
                SizedBox(height: SizeConfig.blockHeight*2,),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*2)),
                    border: Border.all(color: COLORS.grayMedium2),

                  ),
                  child: Column(
                    children: [
                      buttonText(title:  "Retails Sales v/s Purchase Report",dividerColor:COLORS.grayMedium2,onTap: (){}),
                      buttonText(title:  "Stocklist Sales v/s Purchase Report",dividerColor:COLORS.grayMedium2 ,onTap: (){}),
                      buttonText(title:  "Day Plan Report",dividerColor:COLORS.white ,onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>DayPlanReportScreen()));
                      }),

                    ],
                  ),
                ),
                SizedBox(height: SizeConfig.blockHeight*2,),
                NormalText(fontWeight: FontWeight.w600, color: COLORS.black, fontSize: 2,  text: "ABC Reports"),
                SizedBox(height: SizeConfig.blockHeight*2,),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*2)),
                    border: Border.all(color: COLORS.grayMedium2),

                  ),
                  child: Column(
                    children: [
                      buttonText(title:  "Retails Sales v/s Purchase Report",dividerColor:COLORS.grayMedium2 ,onTap: (){}),
                      buttonText(title:  "Stocklist Sales v/s Purchase Report",dividerColor:COLORS.grayMedium2 ,onTap: (){}),
                      buttonText(title:  "Day Plan Report",dividerColor:COLORS.white,onTap: (){} ),

                    ],
                  ),
                )

              ],
            ),
          ),
        )
    );
  }

  Widget buttonText({required String title,required Color dividerColor,required VoidCallback onTap}){
    return  InkWell(
      onTap:onTap,
      child: Container(
        padding:  EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*3,vertical: SizeConfig.blockHeight*2),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: dividerColor))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NormalText(fontWeight: FontWeight.w400, color: COLORS.blueShining, fontSize: 1.7,  text:title),
            Icon(Icons.arrow_forward_ios_sharp,color: COLORS.blueShining,size: SizeConfig.blockHeight*2.5,)
          ],
        ),
      ),
    );
  }
}
