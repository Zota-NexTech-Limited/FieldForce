import 'package:fieldsales/components/app_bar_component/app_bar_component.dart';
import 'package:fieldsales/components/svg_image_component.dart';
import 'package:fieldsales/components/text_component/normal_text.dart';
import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../components/text_form_field_component/search_form_field.dart';
class DayPlanReportScreen extends StatefulWidget {
  const DayPlanReportScreen({super.key});

  @override
  State<DayPlanReportScreen> createState() => _DayPlanReportScreenState();
}

class _DayPlanReportScreenState extends State<DayPlanReportScreen> {
  TextEditingController searchController=TextEditingController();
  FocusNode focusNode = FocusNode();
  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
    Scaffold(
      appBar: appBarComponent(
          context: context,
          title: "Day Plan Report"
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          width: SizeConfig.screenWidth,
          color:COLORS.white,

          child:Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*4,vertical: SizeConfig.blockHeight*2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Container(
                       padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*3,vertical: SizeConfig.blockHeight*1),
                       decoration:BoxDecoration(
                         border: Border.all(color: COLORS.cardBorder),
                         borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*2))
                       ),
                       child: Row(
                         children: [
                           SvgImageHelper(image: "assets/image/svg_icons/filter_icon2.svg"),
                           SizedBox(width: SizeConfig.blockWidth*2,),
                           NormalText(fontWeight: FontWeight.w400, color: COLORS.black.withOpacity(0.35), fontSize: 2, text: "Filter")
                         ],
                       ),
                     ),
                    SizedBox(
                      height: SizeConfig.blockHeight*5.5,
                      width: SizeConfig.blockWidth*60,
                      child: FilterTextFormField(
                        clearIconTap: (){},
                        onChanged: (value){},
                        controller: searchController,
                        hintText: "Search",
                        inputType: TextInputType.text,
                        validator: (value){},
                        isReadOnly: false,
                        onSubmit: (value){},
                        filterText: "",
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: SizeConfig.blockHeight*2,),
            Row(
              children: [
                SizedBox(width: SizeConfig.blockWidth*3,),
                SizedBox(
                  width: SizeConfig.blockWidth*55,
                  child: Row(
                    children: [
                      NormalText(fontWeight: FontWeight.w500, color: COLORS.black, fontSize: 1.8,  text:"Punch Date"),
                      SizedBox(width: SizeConfig.blockWidth*2,),
                      SvgImageHelper(image: "assets/image/svg_icons/arrow_up_down.svg")
                    ],
                  ),
                ),
                Row(
                  children: [
                    NormalText(fontWeight: FontWeight.w500, color: COLORS.black, fontSize: 1.8,  text:"Punch Date"),
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
              return tableCard(onTap: (){
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: SizeConfig.blockHeight*32,
                      decoration: BoxDecoration(
                        color:COLORS.white,
                        borderRadius: BorderRadius.only(topRight: Radius.circular(SizeConfig.blockWidth*7),topLeft: Radius.circular(SizeConfig.blockWidth*7))
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: COLORS.gray))
                            ),
                              padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*4,vertical: SizeConfig.blockHeight*2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                NormalText(fontWeight: FontWeight.w700, color: COLORS.black, fontSize: 2.3,  text:"Feb 30, 2023"),
                                InkWell(
                                  onTap: (){
                                    Navigator.pop(context);
                                  },
                                  child: CircleAvatar(
                                    radius: SizeConfig.blockWidth*3,
                                    backgroundColor: COLORS.backgroundColor,
                                    child: Icon(CupertinoIcons.multiply,size: SizeConfig.blockHeight*2
                                      ,),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(left: SizeConfig.blockWidth*7,top: SizeConfig.blockHeight*2),
                            child: Row(
                              children: [
                                textComponent(title: "Start time",subTitle: "09:08:58"),
                                textComponent(title: "End time",subTitle: "16:20:00"),

                              ],
                            ),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(left: SizeConfig.blockWidth*7,top: SizeConfig.blockHeight*2),
                            child: Row(
                              children: [
                                textComponent(title: "Working Hours",subTitle: "7:00"),
                                textComponent(title: "Store Hunt Count",subTitle: "0"),


                              ],
                            ),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(left: SizeConfig.blockWidth*7,top: SizeConfig.blockHeight*2),
                            child: Row(
                              children: [
                                textComponent(title: "Call Count",subTitle: "0"),
                                textComponent(title: "Total Task",subTitle: "0"),


                              ],
                            ),
                          ),

                        ],
                      ),
                    );
                  },
                );
              },date: "September 10, 2023",workingHrs: "50:00");
            },)
            ],
          ),
        ),
      ),
    )
    );
  }

  Widget tableCard({required String date,required String workingHrs,required VoidCallback onTap}){
    return  InkWell(
      onTap:onTap,
      child: Container(
        padding:  EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*3,vertical: SizeConfig.blockHeight*2),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: COLORS.gray.withOpacity(0.3)))
        ),
        child: Row(
         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: SizeConfig.blockWidth*55,
                child: NormalText(fontWeight: FontWeight.w400, color: COLORS.black, fontSize: 1.7,  text:date)),
            NormalText(fontWeight: FontWeight.w400, color: COLORS.black, fontSize: 1.7,  text:workingHrs),
            Spacer(),
            Icon(Icons.remove_red_eye,color: COLORS.black,size: SizeConfig.blockHeight*2.5,)
          ],
        ),
      ),
    );
  }

  Widget textComponent({required String title,required String subTitle,})
  {
    return  SizedBox(
      width: SizeConfig.blockWidth*45,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NormalText(fontWeight: FontWeight.w400, color: COLORS.black.withOpacity(0.48), fontSize: 1.7,  text:title),
          NormalText(fontWeight: FontWeight.w400, color: COLORS.black, fontSize: 2,  text:subTitle),
        ],
      ),
    );
  }
}
