import 'package:fieldsales/bloc/edit_lead_bloc/edit_lead_bloc.dart';
import 'package:fieldsales/bloc/new_lead_bloc/new_lead_bloc.dart';
import 'package:fieldsales/components/app_bar_component/app_bar_component.dart';
import 'package:fieldsales/components/button_component/edit_button.dart';
import 'package:fieldsales/components/button_component/normal_button.dart';
import 'package:fieldsales/components/button_component/normal_button_with_icon.dart';
import 'package:fieldsales/components/button_component/submit_button_component.dart';
import 'package:fieldsales/components/dropdown_component/not_editable_dropdown.dart';
import 'package:fieldsales/components/dropdown_component/single_item_select_dropdown.dart';
import 'package:fieldsales/components/text_component/input_field_title_text.dart';
import 'package:fieldsales/components/text_component/normal_text.dart';
import 'package:fieldsales/components/text_form_field_component/multy_line_text_form_field.dart';
import 'package:fieldsales/components/text_form_field_component/normal_textform_field.dart';
import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:fieldsales/models/crm_models/new_lead_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class InquiryDetailsScreen extends StatefulWidget {
  final NewLeadModel leadDetails;
  final VoidCallback onSuccessFunction;
  const InquiryDetailsScreen({super.key,required this.leadDetails,required this.onSuccessFunction});

  @override
  State<InquiryDetailsScreen> createState() => _InquiryDetailsScreenState();
}

class _InquiryDetailsScreenState extends State<InquiryDetailsScreen> {
  TextEditingController inquiryDescriptionController=TextEditingController();
  TextEditingController keywordsController=TextEditingController();
  TextEditingController customerRequirementsController=TextEditingController();
  TextEditingController competitorInformationController=TextEditingController();
  TextEditingController nextStepsController=TextEditingController();
  TextEditingController notesController=TextEditingController();

  String? selectedInquiryMedium;
  List<String> inquiryMediumList=["Web Form","Live Chat","SMS","Email","Phone Call","Other"];

  String? selectedInquirySource;
  List<String> inquirySourceList=["Website","Whats App","Store Hunt","Google","IVR","Phone Call","Email","Social Media","Events or Trade Show","Referral","Other"];

  bool isInquirySourceIsEmpty=false;
  bool isInquiryMediumEmpty=false;
  late NewLeadBloc newLeadBloc;
  late NewLeadModel leadDetails;
  ///************************* view screen or edit screen or add lead screen condition variables//////////////////
  bool isView=false;
  bool isEdit=false;
  bool readOnly=false;
  late EditLeadBloc editLeadBloc;
  updateLeadDetailsModel()
  {
    setState(() {
      leadDetails.leadInquiryMedium= selectedInquiryMedium;
      leadDetails.leadInquirySource= selectedInquirySource;
      leadDetails.leadDescription= inquiryDescriptionController.text;
      leadDetails.leadKeywords= keywordsController.text;
      leadDetails.leadRequirements=customerRequirementsController.text;
      leadDetails.leadCompInformation= competitorInformationController.text;
      leadDetails.leadNextSteps= nextStepsController.text;
      leadDetails.leadNotes= notesController.text;
    });
  }

  updateInputFields({required NewLeadModel leadDetails})
  {
    setState(() {
       selectedInquiryMedium=leadDetails.leadInquiryMedium!.isEmpty?null:leadDetails.leadInquiryMedium;
       selectedInquirySource=leadDetails.leadInquirySource!.isEmpty?null:leadDetails.leadInquirySource;
      inquiryDescriptionController.text=leadDetails.leadDescription.toString();
      keywordsController.text=leadDetails.leadKeywords.toString();
      customerRequirementsController.text=leadDetails.leadRequirements.toString();
       competitorInformationController.text=leadDetails.leadCompInformation.toString();
       nextStepsController.text=leadDetails.leadNextSteps.toString();
       notesController.text=leadDetails.leadNotes.toString();

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    leadDetails=widget.leadDetails;
    newLeadBloc=BlocProvider.of<NewLeadBloc>(context);
    editLeadBloc=BlocProvider.of<EditLeadBloc>(context);
    setState(() {
      if(widget.leadDetails.leadId!=null&&widget.leadDetails.leadId!.isNotEmpty)
      {
        isView=true;
        readOnly=true;
        updateInputFields(leadDetails: widget.leadDetails);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:MultiBlocListener(listeners: [
          BlocListener<NewLeadBloc,NewLeadState>(
              listener: (context, state) {
                if(state is NewLeadLoadingState)
                {

                }else if(state is NewLeadSuccessState)
                {
                  setState(() {
                    widget.onSuccessFunction();
                    final snackBar = SnackBar(content: Text(state.message));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);

                  });
                }else if(state is NewLeadFailedState)
                {
                  final snackBar = SnackBar(content: Text(state.message));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                setState(() {

                });
              }



          ),
          BlocListener<EditLeadBloc,EditLeadState>(listener: (context, state) {
            if(state is EditLeadLoadingState){

            }
            else if(state is EditLeadSuccessState)
            {
              setState(() {
                isView=true;
                readOnly=true;
                isEdit=false;
                widget.onSuccessFunction();
                // updateInputFields(opportunityDetails: state.opportunityDetails);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
              });
            }
            else if (state is EditLeadFailedState)
            {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },)

        ], child:  Scaffold(
          backgroundColor: COLORS.scaffoldBg,
          appBar: appBarComponent(title: "Inquiry Details",context: context),
          body: Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*3,),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: SizeConfig.blockHeight*2,),
                  _sectionCard(
                    icon: Icons.inbox_outlined,
                    title: "Inquiry Channel",
                    subtitle: "Where and how the inquiry came in",
                    children: [
                      const InputFieldTitleText(text: "Inquiry Medium *"),
                      if(readOnly==true)...[
                        NotEditableDropdownComponent(text: selectedInquiryMedium==null?"--":selectedInquiryMedium!)
                      ]else...[
                        SingleItemSelectDropdown(selectedValue: selectedInquiryMedium, list: inquiryMediumList, onChanged: (value){
                          setState(() {
                            selectedInquiryMedium=value;
                            isInquiryMediumEmpty=false;
                          });
                        },
                            isError: isInquiryMediumEmpty,
                            hint: "Channel inquiry came in"),
                      ],


                      const InputFieldTitleText(text: "Inquiry Source *"),
                      if(readOnly==true)...[
                        NotEditableDropdownComponent(text: selectedInquirySource==null?"--":selectedInquirySource!)
                      ]else...[
                        SingleItemSelectDropdown(selectedValue: selectedInquirySource, list: inquirySourceList, onChanged: (value){
                          setState(() {
                            selectedInquirySource=value;
                            isInquirySourceIsEmpty=false;
                          });
                        },
                            isError: isInquirySourceIsEmpty,
                            hint: "How the inquiry came in")
                      ],
                    ],
                  ),
                  SizedBox(height: SizeConfig.blockHeight*2,),
                  _sectionCard(
                    icon: Icons.notes_outlined,
                    title: "Inquiry Details",
                    subtitle: "Capture what the customer is looking for",
                    children: [
                      const InputFieldTitleText(text: "Inquiry Description"),
                      MultiLineTextFormField(onChanged: (value){}, controller: inquiryDescriptionController, inputType: TextInputType.text, validator: (value){
                        return null;
                      }, isReadOnly: readOnly, labelText: "Detailed description of the customer's needs or questions."),

                      const InputFieldTitleText(text: "Keywords "),
                      MultiLineTextFormField(onChanged: (value){}, controller: keywordsController, inputType: TextInputType.text, validator: (value){
                        return null;
                      }, isReadOnly: readOnly, labelText: "Relevant keywords or search terms used by the customer"),

                      const InputFieldTitleText(text: "Customer Requirements "),
                      MultiLineTextFormField(onChanged: (value){}, controller: customerRequirementsController, inputType: TextInputType.text, validator: (value){
                        return null;
                      }, isReadOnly: readOnly, labelText: "Specific requirements or preferences expressed by the customer"),
                    ],
                  ),
                  SizedBox(height: SizeConfig.blockHeight*2,),
                  _sectionCard(
                    icon: Icons.timeline_outlined,
                    title: "Insights & Follow-up",
                    subtitle: "Competitor notes and next actions",
                    children: [
                      const InputFieldTitleText(text: "Competitor Information  "),
                      MultiLineTextFormField(onChanged: (value){}, controller: competitorInformationController, inputType: TextInputType.text, validator: (value){
                        return null;
                      }, isReadOnly: readOnly, labelText: "Information about competitors mentioned by the customer"),

                      const InputFieldTitleText(text: "Next Steps "),
                      MultiLineTextFormField(onChanged: (value){}, controller: nextStepsController, inputType: TextInputType.text, validator: (value){
                        return null;
                      }, isReadOnly: readOnly, labelText: "Specific requirements or preferences expressed by the customer"),

                      const InputFieldTitleText(text: "Notes "),
                      MultiLineTextFormField(onChanged: (value){}, controller: notesController, inputType: TextInputType.text, validator: (value){
                        return null;
                      }, isReadOnly: readOnly, labelText: "Additional comments or observations"),
                    ],
                  ),






                  SizedBox(height: SizeConfig.blockHeight*3,),



                ],
              ),
            ),
          ),

          bottomNavigationBar: Container(
            height: SizeConfig.blockHeight*9,
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*3,vertical: SizeConfig.blockHeight*1),
            decoration: BoxDecoration(
              color: COLORS.white,
              border: Border(top: BorderSide(color: COLORS.divider, width: 1)),
              boxShadow: [
                BoxShadow(
                  color: COLORS.shadow,
                  blurRadius: 14,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Column(
              children: [
                if(isView==false)...[
                  SubmitButtonComponent(onTap:(){
                    setState(() {
                      if(selectedInquirySource==null||selectedInquirySource!.isEmpty)
                      {
                        isInquirySourceIsEmpty=true;
                      }
                      if(selectedInquiryMedium==null||selectedInquiryMedium!.isEmpty)
                      {
                        isInquiryMediumEmpty=true;
                      }
                      if(isInquirySourceIsEmpty==false&& isInquiryMediumEmpty==false)
                      {
                        setState(() {
                          updateLeadDetailsModel();

                          newLeadBloc.add(PostNewLeadEvent(leadDetails: leadDetails));
                        });
                      }

                    });
                  },)
                ]
                else...[
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
                        NormalButton(title: "Close", onTap: (){
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
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
                            updateInputFields(leadDetails:leadDetails);
                          });
                        }, height: SizeConfig.blockHeight*7, width: SizeConfig.screenWidth*0.4),
                        NormalButton(title: "Update", onTap: (){
                          setState(() {
                            if(selectedInquirySource==null||selectedInquirySource!.isEmpty)
                            {
                              isInquirySourceIsEmpty=true;
                            }
                            if(selectedInquiryMedium==null||selectedInquiryMedium!.isEmpty)
                            {
                              isInquiryMediumEmpty=true;
                            }
                            if(isInquirySourceIsEmpty==false&& isInquiryMediumEmpty==false)
                            {
                              setState(() {
                                updateLeadDetailsModel();

                                editLeadBloc.add(TriggerEditLeadEvent(leadDetails: leadDetails));
                              });
                            }
                          });
                        }, height: SizeConfig.blockHeight*7, width: SizeConfig.screenWidth*0.4)
                      ],
                    )
                  ]
                ],
              ],
            ),
          ),
        ),)



       );
  }

  Widget _sectionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required List<Widget> children,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.blockWidth*4,
        vertical: SizeConfig.blockHeight*1.5,
      ),
      decoration: BoxDecoration(
        color: COLORS.white,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: SizeConfig.blockWidth*10,
                height: SizeConfig.blockWidth*10,
                decoration: BoxDecoration(
                  color: COLORS.primarySoft,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: COLORS.primaryColor, size: SizeConfig.blockWidth*5),
              ),
              SizedBox(width: SizeConfig.blockWidth*3),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: SizeConfig.blockHeight*2.1,
                        fontWeight: FontWeight.w700,
                        color: COLORS.textPrimary,
                      ),
                    ),
                    SizedBox(height: SizeConfig.blockHeight*0.4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: SizeConfig.blockHeight*1.6,
                        fontWeight: FontWeight.w400,
                        color: COLORS.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: SizeConfig.blockHeight*1),
            child: Divider(color: COLORS.divider, height: 1),
          ),
          ...children,
          SizedBox(height: SizeConfig.blockHeight*1),
        ],
      ),
    );
  }
}
