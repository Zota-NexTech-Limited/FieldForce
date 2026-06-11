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
      backgroundColor: COLORS.scaffoldBg,
      appBar: appBarComponent(
        context: context,
        title: "Day Plan"
      ),
      body: Container(
        width: SizeConfig.screenWidth,
        color: COLORS.scaffoldBg,
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*4,vertical: SizeConfig.blockHeight*2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NormalText(fontWeight: FontWeight.w700, color: COLORS.textPrimary, fontSize: 2.4,  text: "Work With"),
            SizedBox(height: SizeConfig.blockHeight*0.6,),
            NormalText(fontWeight: FontWeight.w400, color: COLORS.textTertiary, fontSize: 1.6,  text: "Select team members to plan your day"),
            SizedBox(height: SizeConfig.blockHeight*2,),
            Expanded(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: 10,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final bool isSelected = selectedIndexList.contains(index);
                  return InkWell(
                    borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*4)),
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
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      curve: Curves.easeOut,
                      margin: EdgeInsets.only(bottom: SizeConfig.blockHeight*1.4),
                      padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*3.5,vertical: SizeConfig.blockHeight*1.8),
                      decoration: BoxDecoration(
                          color: isSelected ? COLORS.primarySoft : COLORS.surface,
                          borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*4)),
                          border: Border.all(
                            color: isSelected ? COLORS.primaryColor : COLORS.cardBorder,
                            width: isSelected ? 1.4 : 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: COLORS.shadow,
                              blurRadius: 14,
                              offset: const Offset(0, 6),
                            ),
                          ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: SizeConfig.blockHeight*6,
                            width: SizeConfig.blockWidth*12,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: isSelected ? COLORS.primaryColor : COLORS.surfaceMuted,
                                borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*10))
                            ),
                            child: Icon(
                              Icons.person_rounded,
                              color: isSelected ? COLORS.white : COLORS.iconColor,
                              size: SizeConfig.blockHeight*3,
                            ),
                          ),
                          SizedBox(
                            width: SizeConfig.blockWidth*4,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                NormalText(fontWeight: FontWeight.w700, color: COLORS.textPrimary, fontSize: 1.9,  text: "Alice Johnson"),
                                SizedBox(height: SizeConfig.blockHeight*0.4,),
                                NormalText(fontWeight: FontWeight.w400, color: COLORS.textSecondary, fontSize: 1.55,  text: "Assistant Manager"),
                              ],
                            ),
                          ),
                          SizedBox(width: SizeConfig.blockWidth*2,),
                          Checkbox(
                              side: BorderSide(color:COLORS.outline,width: SizeConfig.blockWidth*0.4) ,
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
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*4,vertical: SizeConfig.blockHeight*1.6),
        decoration: BoxDecoration(
          color: COLORS.surface,
          border: Border(top: BorderSide(color: COLORS.divider)),
        ),
        child: Center(
          child: NormalButton(title: "Start Day", onTap: (){

          }, height: SizeConfig.blockHeight*7, width: SizeConfig.screenWidth*0.92),
        ),
      ),
    ));
  }
}
