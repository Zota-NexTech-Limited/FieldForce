import 'package:fieldsales/bloc/edit_opportunity_bloc/edit_opportunity_bloc.dart';
import 'package:fieldsales/bloc/get_opportunity_by_id_bloc/get_opportunity_by_id_bloc.dart';
import 'package:fieldsales/components/app_bar_component/app_bar_component.dart';
import 'package:fieldsales/components/button_component/edit_button.dart';
import 'package:fieldsales/components/button_component/normal_button.dart';
import 'package:fieldsales/components/button_component/normal_button_with_icon.dart';
import 'package:fieldsales/components/dropdown_component/not_editable_dropdown.dart';
import 'package:fieldsales/components/dropdown_component/single_item_select_dropdown.dart';
import 'package:fieldsales/components/state_management_components/error_screen.dart';
import 'package:fieldsales/components/state_management_components/loading_screen.dart';
import 'package:fieldsales/components/text_component/input_field_title_text.dart';
import 'package:fieldsales/components/text_form_field_component/normal_textform_field.dart';
import 'package:fieldsales/components/text_form_field_component/textformfield_with_suffix_icon.dart';
import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/reuse_functions/date_picker.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:fieldsales/models/crm_models/opportinuty_model.dart';
import 'package:fieldsales/ui/crm/opportunity_screens/add_new_opportunity_screens/opportunity_contact_information_screen.dart';
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
  List<String> stageList=["Qualification","Proposal","Negotiation","Closed Won","Closed Lost"];
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
      selectedStage=opportunityDetails.opportunityStage!.isEmpty?null:opportunityDetails.opportunityStage;
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
             // updateInputFields(opportunityDetails: state.opportunityDetails);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
            });
          }
          else if (state is EditOpportunityFailedState)
          {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },)
      ],
        child: isLoading==true?LoadingScreen():isError==true?ErrorScreen(onPressed: (){}): Form(
          key: _formKey,
          child: Scaffold(
          backgroundColor: COLORS.scaffoldBg,
          appBar: appBarComponent(title: "Add Opportunity", context: context),
          body:Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*4),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: SizeConfig.blockHeight*2),
                  _buildSectionHeader(
                    icon: Icons.flag_outlined,
                    title: "Opportunity Details",
                    subtitle: "Tell us about this opportunity",
                  ),
                  SizedBox(height: SizeConfig.blockHeight*2),
                  _buildCard(
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
                          NotEditableDropdownComponent(text: selectedStage==null?"--":selectedStage!),
                        ]else...[
                          SingleItemSelectDropdown(selectedValue: selectedStage, list: stageList, onChanged: (value){setState(() {
                            selectedStage=value!;
                          });}, hint: "Select stage", isError: false),
                        ],
                      ],
                    ),
                  ),
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
                  SizedBox(height: SizeConfig.blockHeight*2.5),
                  _buildCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Probability of Close",
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: SizeConfig.blockHeight*2,
                                fontWeight: FontWeight.w600,
                                color: COLORS.textSecondary,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.blockWidth*3,
                                vertical: SizeConfig.blockHeight*0.7,
                              ),
                              decoration: BoxDecoration(
                                color: COLORS.primarySoft,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                "${(probabilityOfClose.toInt())} / 10",
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: SizeConfig.blockHeight*1.9,
                                  fontWeight: FontWeight.w700,
                                  color: COLORS.primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: SizeConfig.blockHeight*1),
                        SfSlider(
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
                          activeColor: COLORS.primaryColor,
                          inactiveColor: COLORS.divider,
                          onChanged: (dynamic value){
                            setState(() {
                              if(readOnly==false)
                              {
                                probabilityOfClose = value;
                              }
                            });
                          },

                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: SizeConfig.blockHeight*9,),

                ],
              ),
            ),
          ) ,
            bottomNavigationBar: Container(
              height: SizeConfig.blockHeight*9,
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*4,vertical: SizeConfig.blockHeight*1),
              decoration: BoxDecoration(
                color: COLORS.surface,
                border: Border(top: BorderSide(color: COLORS.divider, width: 1)),
                boxShadow: [
                  BoxShadow(
                    color: COLORS.shadow,
                    blurRadius: 12,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  if(isView==false)...[

                    NormalButtonWithIcon(title: "Next Step", onTap: (){
                      if(_formKey.currentState!.validate())
                      {
                        updateOpportunityDetailsModel();
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> BlocProvider(create: (context)=>EditOpportunityBloc(),child: OpportunityContactInformationScreen(opportunityDetails: opportunityDetails,pageRefreshFunction: widget.pageRefreshFunction,),)));
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
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> BlocProvider(create: (context)=>EditOpportunityBloc(),child: OpportunityContactInformationScreen(opportunityDetails: opportunityDetails,pageRefreshFunction: widget.pageRefreshFunction,),)));
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
        ),)

    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.blockWidth*4,
        vertical: SizeConfig.blockHeight*1.5,
      ),
      decoration: BoxDecoration(
        color: COLORS.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: COLORS.cardBorder, width: 1),
        boxShadow: [
          BoxShadow(
            color: COLORS.shadow,
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildSectionHeader({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(SizeConfig.blockWidth*2.5),
          decoration: BoxDecoration(
            color: COLORS.primarySoft,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: COLORS.primaryColor, size: SizeConfig.blockHeight*2.8),
        ),
        SizedBox(width: SizeConfig.blockWidth*3),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: SizeConfig.blockHeight*2.4,
                  fontWeight: FontWeight.w700,
                  color: COLORS.textPrimary,
                ),
              ),
              SizedBox(height: SizeConfig.blockHeight*0.4),
              Text(
                subtitle,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: SizeConfig.blockHeight*1.7,
                  fontWeight: FontWeight.w400,
                  color: COLORS.textTertiary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
