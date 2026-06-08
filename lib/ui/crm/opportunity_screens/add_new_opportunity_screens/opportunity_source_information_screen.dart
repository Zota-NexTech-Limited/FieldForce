import 'package:fieldsales/bloc/add_opportunity_bloc/add_opportunity_bloc.dart';
import 'package:fieldsales/bloc/edit_opportunity_bloc/edit_opportunity_bloc.dart';
import 'package:fieldsales/bloc/opportunity_list_bloc/opportunity_list_bloc.dart';
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
import 'package:fieldsales/helper/config.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:fieldsales/models/crm_models/opportinuty_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
class OpportunitySourceInformationScreen extends StatefulWidget {
  final OpportunityDetailsModel opportunityDetails;
  final VoidCallback pageRefreshFunction;
  const OpportunitySourceInformationScreen({super.key,required this.opportunityDetails,required this.pageRefreshFunction});

  @override
  State<OpportunitySourceInformationScreen> createState() => _OpportunitySourceInformationScreenState();
}

class _OpportunitySourceInformationScreenState extends State<OpportunitySourceInformationScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController sourceDetailsController=TextEditingController();
  TextEditingController productQuantityController=TextEditingController();
  TextEditingController nextStepsController=TextEditingController();
  TextEditingController notesController=TextEditingController();
  final MultiSelectController<String> _controller = MultiSelectController();
  String? selectedSource;
  List<String> sourceList=[];
  List<DropdownItem<String>> competitorsList=[
    DropdownItem(
      label: 'Option 1',
      value: 'User 1',),
    DropdownItem(
      label: 'Option 2',
      value: 'User 2',),
    DropdownItem(
      label: 'Option 3',
      value: 'User 3',),
    DropdownItem(
      label: 'Option 4',
      value: 'User 4',),
    DropdownItem(
      label: 'Option 5',
      value: 'User 5',),
  ];
  List<String> selectedCompetitorsList=[];
  bool isMultiDropdownOpen=false;


  ///************************* view screen or edit screen or add opportunity screen condition variables//////////////////
  bool isView=false;
  bool isEdit=false;
  bool readOnly=false;

  late OpportunityDetailsModel opportunityDetails;
  late AddOpportunityBloc addOpportunityBloc;
  late EditOpportunityBloc editOpportunityBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    opportunityDetails=widget.opportunityDetails;
    addOpportunityBloc=BlocProvider.of<AddOpportunityBloc>(context);
    editOpportunityBloc=BlocProvider.of<EditOpportunityBloc>(context);
    setState(() {
      if(widget.opportunityDetails.opportunityId!=null&&widget.opportunityDetails.opportunityId!.isNotEmpty)
      {
        isView=true;
        readOnly=true;
        updateInputFields(opportunityDetails: widget.opportunityDetails);
        final preselectedValues = widget.opportunityDetails.opportunityCompetitors ?? [];
        _controller.setItems(
          competitorsList
              .map((item) => item.copyWith(
                    selected: preselectedValues.contains(item.value),
                  ))
              .toList(),
        );
      }
    });
  }
  updateOpportunityDetailsModel()
  {
    setState(() {
      opportunityDetails.opportunitySource=selectedSource;
      opportunityDetails.opportunitySourceDetails=sourceDetailsController.text;
      opportunityDetails.opportunityProducts=productQuantityController.text;
      opportunityDetails.opportunityCompetitors=selectedCompetitorsList;
      opportunityDetails.opportunityNextStep=nextStepsController.text;
      opportunityDetails.opportunityNotes=notesController.text;
    });
  }

  updateInputFields({required OpportunityDetailsModel opportunityDetails})
  {
    setState(() {
      selectedSource= opportunityDetails.opportunitySource.toString();
      sourceDetailsController.text=opportunityDetails.opportunitySourceDetails.toString();
      productQuantityController.text=opportunityDetails.opportunityProducts.toString();
      selectedCompetitorsList=opportunityDetails.opportunityCompetitors!;
      nextStepsController.text=opportunityDetails.opportunityNextStep.toString();
      notesController.text=opportunityDetails.opportunityNotes.toString();

    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:MultiBlocListener(listeners: [
          BlocListener<AddOpportunityBloc,AddOpportunityState>(listener: (context, state) {
            if(state is AddOpportunityLoadingState)
            {

            }else if(state is AddOpportunitySuccessState)
            {
              setState(() {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
                widget.pageRefreshFunction();
                final snackBar = SnackBar(content: Text(state.message));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              });
            }else if(state is AddOpportunityFailedState)
            {
              final snackBar = SnackBar(content: Text(state.message));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          }),
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
          })

        ], child:  Scaffold(
          backgroundColor: COLORS.white,
          appBar: appBarComponent(title: "Source Information", context: context),
          body: Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*3),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const InputFieldTitleText(text: "Source *"),
                  if(readOnly==true)...[
                    NotEditableDropdownComponent(text: selectedSource.toString())
                   ]else...[
                    SingleItemSelectDropdown(
                        selectedValue: selectedSource,
                        list: sourceList,
                        onChanged: (value)
                        {
                          setState(() {
                            selectedSource=value!;
                          });
                        },
                        hint: "Select Source",
                        isError: false),
                  ],

                  const InputFieldTitleText(text: "Source Details"),
                  MultiLineTextFormField(
                      onChanged:  (value){},
                      controller: sourceDetailsController,
                      inputType: TextInputType.text,
                      validator:  (value){
                        if(value==null||value.isEmpty)
                        {
                          return "Contact Name is Empty";
                        }
                        return null;
                      },
                      isReadOnly: readOnly,
                      labelText: "Source Details Details Here"
                  ),
                  const InputFieldTitleText(text: "Products/Services Involved"),
                  NormalTextFormField(
                      onChanged:(value){
                      },
                      controller: productQuantityController,
                      hintText: "Desired quantity of the product (if applicable)",
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
                      readOnly: readOnly),
                  const InputFieldTitleText(text: "Competitors"),
                  /* MultipleSearchSelection<String>(
                    searchField: TextField(
                      decoration: InputDecoration(
                        hintText: 'Competitors',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                    onSearchChanged: (text) {
                      print('Text is $text');
                    },
                    items: competitorsList, // List<Country>
                    fieldToCheck: (value) {
                      return value.toString(); // String
                    },
                    itemBuilder: (value,index) {
                      return Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 20.0,
                              horizontal: 12,
                            ),
                            child: Text(value),
                          ),
                        ),
                      );
                    },
                    pickedItemBuilder: (selectedValue) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey[400]!),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(selectedValue),
                        ),
                      );
                    },
                    onTapShowedItem: () {},
                    onPickedChange: (items) {},
                    onItemAdded: (item) {},
                    onItemRemoved: (item) {},
                    sortShowedItems: true,
                    sortPickedItems: true,
                    fuzzySearch: FuzzySearch.jaro,
                    itemsVisibility: ShowedItemsVisibility.alwaysOn,
                    title:const Text(
                      '',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )
                    ),
                    showSelectAllButton: true,
                    maximumShowItemsHeight: 200,
                  ),*/

                  if(readOnly==true)...[
                   Container(
                     width: SizeConfig.screenWidth,
                     height: SizeConfig.blockHeight*7,
                     decoration: BoxDecoration(
                       border: Border.all(color: COLORS.gray,width: 1.5),
                       borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth * 1.5))
                     ),
                     child: ListView.builder(
                       scrollDirection: Axis.horizontal,
                       itemCount: _controller.selectedItems.length,
                       itemBuilder: (context, index) {
                       return Container(
                         margin: EdgeInsets.symmetric(
                             horizontal: SizeConfig.blockWidth*1,
                             vertical: SizeConfig.blockHeight*1
                         ),
                         padding: EdgeInsets.symmetric(
                             horizontal: SizeConfig.blockWidth*2,
                             vertical: SizeConfig.blockHeight*1
                         ),
                         decoration: BoxDecoration(
                             border: Border.all(color: COLORS.gray,width: 1.5),
                             borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth * 1.5))
                         ),
                         child: NormalText(fontWeight: FontWeight.w400, color: COLORS.textColor, fontSize: 1.5, text: _controller.selectedItems[index].label),
                       );
                     },),
                   )
                  ]else...[
                    MultiDropdown<String>(
                      controller: _controller,
                      onSelectionChange: (options) {

                      },
                      searchEnabled: true,
                      items: competitorsList,
                      chipDecoration: ChipDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(6)),
                        wrap: false,
                        backgroundColor: COLORS.black.withOpacity(0.1),
                        labelStyle: TextStyle(color: COLORS.textColor),
                        deleteIcon: const Icon(CupertinoIcons.multiply,color: COLORS.black,),
                      ),
                      dropdownItemDecoration: DropdownItemDecoration(
                        textColor: COLORS.textColor,
                        selectedBackgroundColor: COLORS.gray,
                        selectedTextColor: COLORS.primaryColor,
                      ),
                      fieldDecoration: FieldDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth * 1.5)),
                          borderSide: BorderSide(color: COLORS.gray, width: 1.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth * 1.5)),
                          borderSide: BorderSide(color: COLORS.gray, width: 1.5),
                        ),
                      ),
                      itemBuilder: (item, index, onTap) {
                        return ListTile(
                          title: Text(item.label),
                          trailing: item.selected
                              ? const Icon(Icons.check_circle)
                              : const Icon(Icons.radio_button_unchecked),
                          onTap: onTap,
                        );
                      },
                    ),
                  ],

                  const InputFieldTitleText(text: "Next Steps "),
                  MultiLineTextFormField(onChanged: (value){}, controller: nextStepsController, inputType: TextInputType.text, validator: (value){
                    return null;
                  }, isReadOnly: readOnly, labelText: "Enter Next Steps Here"),

                  const InputFieldTitleText(text: "Notes "),
                  MultiLineTextFormField(onChanged: (value){}, controller: notesController, inputType: TextInputType.text, validator: (value){
                    return null;
                  }, isReadOnly: readOnly, labelText: "Enter Notes Here"),

                 SizedBox(height: SizeConfig.blockHeight*2,)



                ],
              ),
            ),

          ),
          bottomNavigationBar: Container(
            height: SizeConfig.blockHeight*8,
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*3,),
            child: Column(
              children: [
                if(isView==false)...[
                  SubmitButtonComponent(onTap:(){
                    setState(() {
                      selectedCompetitorsList.clear();
                      for(DropdownItem item in _controller.selectedItems)
                      {
                        selectedCompetitorsList.add(item.value.toString());
                      }
                      updateOpportunityDetailsModel();
                      addOpportunityBloc.add(AddNewOpportunityEvent(opportunityDetails: opportunityDetails));
                      print("selectedCompetitorsList----------------$selectedCompetitorsList");
                    });

                  },)
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
                        NormalButton(title: "Close", onTap: (){
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
                            updateInputFields(opportunityDetails:opportunityDetails);
                          });
                        }, height: SizeConfig.blockHeight*7, width: SizeConfig.screenWidth*0.4),
                        NormalButton(title: "Update", onTap: (){
                          setState(() {
                            selectedCompetitorsList.clear();
                            for(DropdownItem item in _controller.selectedItems)
                            {
                              selectedCompetitorsList.add(item.value.toString());
                            }
                            updateOpportunityDetailsModel();
                            editOpportunityBloc.add(TriggerEditOpportunityEvent(opportunityDetails: opportunityDetails));

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
}
