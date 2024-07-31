import 'package:fieldforce/bloc/edit_opportunity_bloc/edit_opportunity_bloc.dart';
import 'package:fieldforce/bloc/get_opportunity_by_id_bloc/get_opportunity_by_id_bloc.dart';
import 'package:fieldforce/components/app_bar_component/app_bar_component.dart';
import 'package:fieldforce/components/button_component/edit_button.dart';
import 'package:fieldforce/components/button_component/normal_button.dart';
import 'package:fieldforce/components/button_component/normal_button_with_icon.dart';
import 'package:fieldforce/components/dropdown_component/not_editable_dropdown.dart';
import 'package:fieldforce/components/dropdown_component/single_item_select_dropdown.dart';
import 'package:fieldforce/components/state_management_components/error_screen.dart';
import 'package:fieldforce/components/state_management_components/loading_screen.dart';
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
import 'package:flutter_bloc/flutter_bloc.dart';
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

  ///************************* view screen or edit screen or add opportunity screen condition variables//////////////////
 bool isView=false;
 bool isEdit=false;
 bool readOnly=false;
 bool isLoading=false;
 bool isError=false;
  late GetOpportunityByIdBloc getOpportunityByIdBloc;
  late EditOpportunityBloc editOpportunityBloc;
  OpportunityDetailsModel opportunityDetails=OpportunityDetailsModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOpportunityByIdBloc=BlocProvider.of<GetOpportunityByIdBloc>(context);
    editOpportunityBloc=BlocProvider.of<EditOpportunityBloc>(context);
  }

  updateOpportunityDetailsModel()
  {
    setState(() {
      opportunityDetails.opportunityName= opportunityNameController.text;
      opportunityDetails.opportunityValue= opportunityValueController.text;
      opportunityDetails.opportunityCloseDate= closeDateController.text;
      opportunityDetails.opportunityStage= selectedStage;
      opportunityDetails.opportunityProbabilityOfClose= probabilityOfClose.toString();
    });
  }

  updateInputFields({required OpportunityDetailsModel opportunityDetails})
  {
    setState(() {
      opportunityNameController.text=opportunityDetails.opportunityName.toString();
      opportunityValueController.text=opportunityDetails.opportunityValue.toString();
      closeDateController.text=opportunityDetails.opportunityCloseDate.toString();
      selectedStage=opportunityDetails.opportunityStage.toString();
      probabilityOfCloseController.text=opportunityDetails.opportunityProbabilityOfClose.toString();
      probabilityOfClose=double.parse(opportunityDetails.opportunityProbabilityOfClose.toString());

    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MultiBlocListener(listeners: [
        BlocListener<GetOpportunityByIdBloc,GetOpportunityByIdState>(listener: (context, state) {
          if(state is GetOpportunityByIdLoadingState){
            setState(() {
              isLoading=true;
              isError=false;
            });
          }
          else if(state is GetOpportunityByIdSuccessState)
          {
            setState(() {
              opportunityDetails=state.opportunityDetails;
              isView=true;
              readOnly=true;
              isLoading=false;
              isError=false;
              updateInputFields(opportunityDetails: state.opportunityDetails);
            });
          }
          else if (state is GetOpportunityByIdFailedState)
          {
            setState(() {
              isLoading=false;
              isError=false;
            });
          }
        },),
        BlocListener<EditOpportunityBloc,EditOpportunityState>(listener: (context, state) {
          if(state is EditOpportunityLoadingState){

          }
          else if(state is EditOpportunitySuccessState)
          {
            setState(() {
              isView=true;
              readOnly=true;
              isEdit=false;
              updateInputFields(opportunityDetails: state.opportunityDetails);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
            });
          }
          else if (state is GetOpportunityByIdFailedState)
          {

          }
        },)
      ],
        child: isLoading==true?LoadingScreen():isError==true?ErrorScreen(onPressed: (){}): Scaffold(
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
                      readOnly: readOnly
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
                      readOnly: readOnly
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
                      onTap:(){
                        if(readOnly==false)
                        {
                          setState(() {
                            showSingleDatePickerHelper(context: context,controller: closeDateController);
                          });
                          print("closeDateController----------------${closeDateController.text}");
                        }


                      },
                      suffixIcon: "assets/image/svg_icons/calendar.svg"),
                  const InputFieldTitleText(text: "Stage"),
                  if(readOnly==true)...[
                    NotEditableDropdownComponent(text: selectedStage.toString()),
                  ]else...[
                    SingleItemSelectDropdown(selectedValue: selectedStage, list: stageList, onChanged: (value){setState(() {
                      selectedStage=value!;
                    });}, hint: "Select stage", isError: false),
                  ],
                  /*  const InputFieldTitleText(text: "Probability of Close"),
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
                      readOnly: readOnly
                  ),*/
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
                              if(readOnly==false)
                              {
                                probabilityOfClose = value;
                              }
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
                  SizedBox(height: SizeConfig.blockHeight*9,),
                  if(isView==false)...[

                    NormalButtonWithIcon(title: "Next Step", onTap: (){
                      if(_formKey.currentState!.validate())
                      {
                        updateOpportunityDetailsModel();
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> OpportunityContactInformationScreen(opportunityDetails: opportunityDetails,pageRefreshFunction: widget.pageRefreshFunction,)));
                      }
                    }, height: SizeConfig.blockHeight*7, width: SizeConfig.screenWidth)
                  ]else...[
                    if(isEdit==false)...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          EditButtonComponent(onTap: (){
                            setState(() {
                              isEdit=true;
                              readOnly=false;
                            });
                          },),
                          NormalButtonWithIcon(title: "Next Step", onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> OpportunityContactInformationScreen(opportunityDetails: opportunityDetails,pageRefreshFunction: widget.pageRefreshFunction,)));
                          }, height: SizeConfig.blockHeight*7, width: SizeConfig.screenWidth*0.7)
                        ],
                      )
                    ]else...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          NormalButton(title: "Cancel", onTap: (){
                            setState(() {
                              isEdit=false;
                              readOnly=true;
                              updateInputFields(opportunityDetails:opportunityDetails);
                            });
                          }, height: SizeConfig.blockHeight*7, width: SizeConfig.screenWidth*0.4),
                          NormalButton(title: "Update", onTap: (){
                            setState(() {
                              updateOpportunityDetailsModel();
                              editOpportunityBloc.add(TriggerEditOpportunityEvent(opportunityDetails: opportunityDetails));

                            });
                          }, height: SizeConfig.blockHeight*7, width: SizeConfig.screenWidth*0.4)
                        ],
                      )
                    ]
                  ]
                ],
              ),
            ),
          ),
        ) ,
      ),)

    );
  }
}
