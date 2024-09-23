import 'package:fieldsales/components/app_bar_component/app_bar_component.dart';
import 'package:fieldsales/components/text_component/normal_text.dart';
import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:flutter/material.dart';
class LeadHistoryScreen extends StatefulWidget {
  const LeadHistoryScreen({super.key});

  @override
  State<LeadHistoryScreen> createState() => _LeadHistoryScreenState();
}

class _LeadHistoryScreenState extends State<LeadHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: COLORS.white,
        appBar: appBarComponent(title: "History", context: context),
        body: Container(
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          margin: EdgeInsets.symmetric(vertical: SizeConfig.blockHeight*2),
          child: ListView.builder(

            physics:const BouncingScrollPhysics(),
            shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*3,vertical: SizeConfig.blockWidth*1),
                  margin: EdgeInsets.only(top: SizeConfig.blockHeight*2,left: SizeConfig.blockWidth*3,right: SizeConfig.blockWidth*3),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 0.1,
                          blurRadius: 4,
                          offset: Offset(0, 1),
                        ),
                      ],
                      color: COLORS.white,
                      borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*2.5))
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: SizeConfig.blockHeight*6,
                        width: SizeConfig.blockWidth*11,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*2)),
                            border: Border.all(color: COLORS.white)
                        ),
                        child: Image.asset("assets/image/common/profile_image.png",fit: BoxFit.fill,),
                      ),
                      SizedBox(width: SizeConfig.blockWidth*1,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                NormalText(fontWeight: FontWeight.w500, color: COLORS.black, fontSize: 2.2, text: "Mahesh Kumara M P"),
                                NormalText(fontWeight: FontWeight.w400, color: COLORS.black.withOpacity(0.7), fontSize: 1.8, text: "15-07-2024"),
                              ],
                            ),
                            subTextComponent(text: "Event Name Goes Here...."),
                            subTextComponent(text: "Other Information Goes Here..."),
                        
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },),
        ),
      ),
    );
  }
  Widget subTextComponent({required String text})
  {
    return NormalText(fontWeight: FontWeight.w500, color: COLORS.black, fontSize: 1.8, text:text );
  }
}
