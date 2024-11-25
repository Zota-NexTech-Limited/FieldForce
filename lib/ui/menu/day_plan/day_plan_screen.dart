import 'package:fieldsales/components/app_bar_component/app_bar_component.dart';
import 'package:fieldsales/components/button_component/normal_button.dart';
import 'package:fieldsales/components/text_component/normal_text.dart';
import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:flutter/material.dart';
class DayPlanScreen extends StatefulWidget {
  const DayPlanScreen({super.key});

  @override
  State<DayPlanScreen> createState() => _DayPlanScreenState();
}

class _DayPlanScreenState extends State<DayPlanScreen> {
  List<int> selectedIndexList=[];
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
    Scaffold(
      appBar: appBarComponent(
        context: context,
        title: "Day Plan"
      ),
      body: Container(
        width: SizeConfig.screenWidth,
        color:COLORS.white,
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*4,vertical: SizeConfig.blockHeight*2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            NormalText(fontWeight: FontWeight.w700, color: COLORS.textColor, fontSize: 2.2,  text: "Work With"),
           SizedBox(height: SizeConfig.blockHeight*2,),
           SizedBox(
             height: SizeConfig.screenHeight*0.73,
             child: ListView.builder(
               physics: BouncingScrollPhysics(),
               itemCount: 10,
               shrinkWrap: true,
               itemBuilder: (context, index) {
               return  InkWell(
                 onTap: (){
                   setState(() {
                     if(selectedIndexList.contains(index))
                     {
                       int removeIndex=selectedIndexList.indexWhere((number)=>number==index);
                       selectedIndexList.removeAt(removeIndex);
                     }else{
                       selectedIndexList.add(index);
                     }
                   });
                 },
                 child: Container(
                   margin: EdgeInsets.only(bottom: SizeConfig.blockHeight*1),
                   padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*3,vertical: SizeConfig.blockHeight*2),
                   decoration: BoxDecoration(
                       color: selectedIndexList.contains(index)?COLORS.backgroundColor:COLORS.white,
                       borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*2)),
                       border: Border.all(color: selectedIndexList.contains(index)?COLORS.primaryColor: COLORS.cardBorder)
                   ),
                   child: Row(
                     children: [
                       Container(

                         height: SizeConfig.blockHeight*6,
                         width: SizeConfig.blockWidth*11,
                         decoration: BoxDecoration(
                             color: COLORS.cardBorder,
                             borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*10))
                         ),

                       ),
                       SizedBox(
                         width: SizeConfig.blockWidth*5,
                       ),
                       Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           NormalText(fontWeight: FontWeight.w700, color: COLORS.textColor, fontSize: 2,  text: "Alice Johnson"),
                           NormalText(fontWeight: FontWeight.w400, color: COLORS.gray, fontSize: 1.6,  text: "Assistant Manager"),

                         ],
                       ),
                       Spacer(),
                       Checkbox(

                           side: BorderSide(color:COLORS.gray,width: SizeConfig.blockWidth*0.5) ,
                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*1.5))),
                           value: selectedIndexList.contains(index),
                           activeColor: COLORS.primaryColor,
                           onChanged: (value){
                             setState(() {


                             });
                           }),
                     ],
                   ),
                 ),
               );
             },),
           ),

          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: SizeConfig.blockHeight*9,
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*4,vertical: SizeConfig.blockHeight*1),
        child:  NormalButton(title: "Start Day", onTap: (){

        }, height: SizeConfig.blockHeight*7, width: SizeConfig.screenWidth*0.7),
      ),
    ));
  }
}
