import 'package:fieldsales/components/app_bar_component/app_bar_component.dart';
import 'package:fieldsales/components/svg_image_component.dart';
import 'package:fieldsales/components/text_component/normal_text.dart';
import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:flutter/material.dart';
class DayPlanReportScreen extends StatefulWidget {
  const DayPlanReportScreen({super.key});

  @override
  State<DayPlanReportScreen> createState() => _DayPlanReportScreenState();
}

class _DayPlanReportScreenState extends State<DayPlanReportScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
    Scaffold(
      appBar: appBarComponent(
          context: context,
          title: "Day Plan Report"
      ),
      body: Container(
        width: SizeConfig.screenWidth,
        color:COLORS.white,

        child:Column(
          children: [
            SizedBox(height: SizeConfig.blockHeight*2,),
          Row(
            children: [
              SizedBox(width: SizeConfig.blockWidth*3,),
              SizedBox(
                width: SizeConfig.blockWidth*55,
                child: Row(
                  children: [
                    NormalText(fontWeight: FontWeight.w500, color: COLORS.blueShining, fontSize: 1.8,  text:"Punch Date"),
                    SizedBox(width: SizeConfig.blockWidth*2,),
                    SvgImageHelper(image: "assets/image/svg_icons/arrow_up_down.svg")
                  ],
                ),
              ),
              Row(
                children: [
                  NormalText(fontWeight: FontWeight.w500, color: COLORS.blueShining, fontSize: 1.8,  text:"Punch Date"),
                  SizedBox(width: SizeConfig.blockWidth*2,),
                  SvgImageHelper(image: "assets/image/svg_icons/arrow_up_down.svg")
                ],
              ),

          ],
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (context, index) {
            return tableCard(onTap: (){},date: "September 10, 2023",workingHrs: "50:00");
          },)
          ],
        ),
      ),
    ));
  }

  Widget tableCard({required String date,required String workingHrs,required VoidCallback onTap}){
    return  InkWell(
      onTap:onTap,
      child: Container(
        padding:  EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*3,vertical: SizeConfig.blockHeight*2),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: COLORS.whiteExtraLight))
        ),
        child: Row(
         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: SizeConfig.blockWidth*55,
                child: NormalText(fontWeight: FontWeight.w400, color: COLORS.blueShining, fontSize: 1.7,  text:date)),
            NormalText(fontWeight: FontWeight.w400, color: COLORS.blueShining, fontSize: 1.7,  text:workingHrs),
            Spacer(),
            Icon(Icons.remove_red_eye,color: COLORS.blueShining,size: SizeConfig.blockHeight*2.5,)
          ],
        ),
      ),
    );
  }
}
