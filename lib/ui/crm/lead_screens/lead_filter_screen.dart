import 'package:fieldforce/components/app_bar_component/app_bar_component.dart';
import 'package:fieldforce/components/button_component/normal_button.dart';
import 'package:fieldforce/components/dropdown_component/single_item_select_dropdown.dart';
import 'package:fieldforce/components/text_component/input_field_title_text.dart';
import 'package:fieldforce/components/text_component/normal_text.dart';
import 'package:fieldforce/helper/colors.dart';
import 'package:fieldforce/helper/size_config.dart';
import 'package:flutter/material.dart';

class LeadFilterScreen extends StatefulWidget {
  const LeadFilterScreen({super.key});

  @override
  State<LeadFilterScreen> createState() => _LeadFilterScreenState();
}

class _LeadFilterScreenState extends State<LeadFilterScreen> {
  String ?selectedValue;
  String ?selectedStatus;
  String ?selectedProspectStatus;
  String ?selectedSubStatus;
  String ?selectedRMRemark;
  List<String> statusList=["Pending","Approve","Reject","Hold"];
  List<String> prospectStatusList=["Pending","Approve","Reject","Hold"];
  List<String> subStatusList=["Pending","Approve","Reject","Hold"];
  List<String> rmRemarkList=["Pending","Approve","Reject","Hold"];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: COLORS.white,
        appBar: appBarComponent(title: "Lead Filter", context: context),
        body: SingleChildScrollView(
          physics:const NeverScrollableScrollPhysics(),
          child: Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*4,vertical: SizeConfig.blockHeight*2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                radioListTile(title:"My Lead",value:"My Lead",),
                radioListTile(title:"Today's call",value:"Today's call",),
                radioListTile(title:"Newly(fresh) lead",value:"Newly(fresh) lead",),
                radioListTile(title:"Archive(Delete) Lead",value:"Archive(Delete) Lead",),
                SizedBox(height: SizeConfig.blockHeight*2,),
                const InputFieldTitleText(text: "Status"),
                SingleItemSelectDropdown(
                    selectedValue: selectedStatus,
                    list: statusList,
                    hint: "Select Status",
                    onChanged: (value){
                     setState(() {
                       selectedStatus=value;
                     });
                    }
                    ),
                const InputFieldTitleText(text: "Prospect Status"),
                SingleItemSelectDropdown(
                    selectedValue: selectedProspectStatus,
                    list: prospectStatusList,
                    hint: "Select Prospect Status",
                    onChanged: (value){
                      setState(() {
                        selectedProspectStatus=value;
                      });
                    }
                ),
                const InputFieldTitleText(text: "Sub Status"),
                SingleItemSelectDropdown(
                    selectedValue: selectedSubStatus,
                    list: subStatusList,
                    hint: "Select Sub Status",
                    onChanged: (value){
                      setState(() {
                        selectedSubStatus=value;
                      });
                    }
                ),
                const InputFieldTitleText(text: "RM Remarks"),
                SingleItemSelectDropdown(
                    selectedValue: selectedRMRemark,
                    list: rmRemarkList,
                    hint: "Select RM Remark",
                    onChanged: (value){
                      setState(() {
                        selectedRMRemark=value;
                      });
                    }
                ),
                SizedBox(height: SizeConfig.blockHeight*8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    NormalButton(
                        title: "Apply",
                        onTap: (){},
                        height: SizeConfig.blockHeight*6,
                        width: SizeConfig.blockWidth*40),
                    NormalButton(
                        title: "Clear",
                        onTap: (){},
                        height: SizeConfig.blockHeight*6,
                        width: SizeConfig.blockWidth*40),
                  ],
                )

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget radioListTile({required String value,required String title})
  {
    return  RadioListTile(
        value:value ,
        title: Transform.scale(
          scale: 1.15,
          child: NormalText(color: COLORS.black,fontSize:1.9,fontWeight: FontWeight.w500,text: title,),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*0),
        activeColor: COLORS.blue,
        groupValue: selectedValue,
        visualDensity: const VisualDensity(vertical:-4),
        dense: true,
        onChanged: (value){
          setState(() {
            selectedValue=value.toString();
          });
        }
    );
  }
}
