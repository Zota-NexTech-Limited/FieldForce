import 'package:fieldforce/components/app_bar_component/app_bar_component.dart';
import 'package:fieldforce/components/button_component/normal_button_with_icon.dart';
import 'package:fieldforce/components/dropdown_component/single_item_select_dropdown.dart';
import 'package:fieldforce/components/text_component/input_field_title_text.dart';
import 'package:fieldforce/components/text_component/normal_text.dart';
import 'package:fieldforce/components/text_form_field_component/normal_textform_field.dart';
import 'package:fieldforce/components/text_form_field_component/textformfield_with_suffix_icon.dart';
import 'package:fieldforce/helper/colors.dart';
import 'package:fieldforce/helper/reuse_functions/date_picker.dart';
import 'package:fieldforce/helper/size_config.dart';
import 'package:fieldforce/models/crm_models/opportinuty_model.dart';
import 'package:fieldforce/ui/crm/opportunity_screens/add_new_opportunity_screens/opportunity_contact_information_screen.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
class AddOpportunityScreen extends StatefulWidget {
  final VoidCallback pageRefreshFunction;
  const AddOpportunityScreen({super.key,required this.pageRefreshFunction});

  @override
  State<AddOpportunityScreen> createState() => _AddOpportunityScreenState();
}

class _AddOpportunityScreenState extends State<AddOpportunityScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController opportunityNameController=TextEditingController();
  TextEditingController opportunityValueController=TextEditingController();
  TextEditingController closeDateController=TextEditingController();
  TextEditingController probabilityOfCloseController=TextEditingController();
  String ? selectedStage;
  List<String> stageList=[];
  double probabilityOfClose = 0.0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBarComponent(title: "Add Opportunity", context: context),
        body:Form(
          key: _formKey,
          child: Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*3),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 const InputFieldTitleText(text: "Opportunity Name *"),
                  NormalTextFormField(
                      onChanged: (value){},
                      controller: opportunityNameController,
                      hintText: "Enter Name Here",
                      inputType: TextInputType.text,
                      validator: (value){
                        if(value==null||value.isEmpty)
                        {
                          return "Opportunity Name is Empty";
                        }
                        return null;
                      },
                      readOnly: false
                  ),
                  const InputFieldTitleText(text: "Opportunity Value *"),
                  NormalTextFormField(
                      onChanged: (value){},
                      controller: opportunityValueController,
                      hintText: "Enter Opportunity Value Here",
                      inputType: TextInputType.text,
                      validator: (value){
                        if(value==null||value.isEmpty)
                        {
                          return "Opportunity Value is Empty";
                        }
                        return null;
                      },
                      readOnly: false
                  ),
                  const InputFieldTitleText(text: "Close Date *"),
                  TextFormFieldWithSuffixIcon(
                      onChanged:  (value){},
                      controller: closeDateController,
                      hintText: "Close Date",
                      readOnly: true,
                      inputType: TextInputType.text,
                      validator: (value){
                        if(value==null||value.isEmpty)
                        {
                          return "Opportunity Value is Empty";
                        }
                        return null;
                      },
                      onTap: (){
                        setState(() {
                          showSingleDatePickerHelper(context: context,controller: closeDateController);
                        });
                        print("closeDateController----------------${closeDateController.text}");
                        
                      },
                      suffixIcon: "assets/image/svg_icons/calendar.svg"),
                  const InputFieldTitleText(text: "Stage"),
                  SingleItemSelectDropdown(selectedValue: selectedStage, list: stageList, onChanged: (value){setState(() {
                    selectedStage=value!;
                  });}, hint: "Select stage", isError: false),
                  const InputFieldTitleText(text: "Probability of Close"),
                  NormalTextFormField(
                      onChanged: (value){
                        
                      },
                      controller: probabilityOfCloseController,
                      hintText: "Size of the company (if applicable)",
                      inputType: TextInputType.number,
                      validator: (value){
                        if(value==null||value.isEmpty)
                        {
                          return null;
                        }
                        else{
                          RegExp regex = RegExp(r"^[0-9]+$");
                          if (!regex.hasMatch(value)) {
                            return 'Numbers are allowed';
                          }
                        }
                      },
                      readOnly: false
                  ),
                  const InputFieldTitleText(text: "Probability of Close"),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: SizeConfig.screenWidth*0.8,
                        child: SfSlider(
                          min: 0,
                          max: 10,
                          value: probabilityOfClose,
                          interval: 1,
                          showTicks: false,
                          showLabels: true,
                          enableTooltip: false,
                          shouldAlwaysShowTooltip: false,
                          stepSize: 1,
                          minorTicksPerInterval: 1,
                          activeColor: COLORS.blue,
                          onChanged: (dynamic value){
                            setState(() {
                              probabilityOfClose = value;
                            });
                          },

                        ),
                      ),
                      Container(
                        height: SizeConfig.blockHeight*3.5,
                        width: SizeConfig.blockWidth*10,
                        color: COLORS.grayLight,
                        child: Center(child: NormalText(fontWeight: FontWeight.w400, color: COLORS.black, fontSize: 2, text: "${(probabilityOfClose.toInt())}")),
                      )

                    ],
                  ),
                        
                 SizedBox(height: SizeConfig.blockHeight*5,),
                  NormalButtonWithIcon(title: "Next Step", onTap: (){

                    if(_formKey.currentState!.validate())
                    {
                      OpportunityDetailsModel opportunityDetails=OpportunityDetailsModel(
                      opportunityName: opportunityNameController.text,
                          opportunityValue: opportunityValueController.text,
                          opportunityCloseDate: closeDateController.text,
                          opportunityStage: selectedStage,
                          opportunityProbabilityOfClose:probabilityOfClose.toString(),

                      );
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> OpportunityContactInformationScreen(opportunityDetails: opportunityDetails,pageRefreshFunction: widget.pageRefreshFunction,)));
                    }
                        
                  }, height: SizeConfig.blockHeight*7, width: SizeConfig.screenWidth)
                ],
              ),
            ),
          ),
        ) ,
      ),
    );
  }
}
