import 'package:fieldforce/bloc/add_opportunity_bloc/add_opportunity_bloc.dart';
import 'package:fieldforce/bloc/opportunity_list_bloc/opportunity_list_bloc.dart';
import 'package:fieldforce/components/app_bar_component/app_bar_component.dart';
import 'package:fieldforce/components/button_component/submit_button_component.dart';
import 'package:fieldforce/components/dropdown_component/single_item_select_dropdown.dart';
import 'package:fieldforce/components/text_component/input_field_title_text.dart';
import 'package:fieldforce/components/text_form_field_component/multy_line_text_form_field.dart';
import 'package:fieldforce/components/text_form_field_component/normal_textform_field.dart';
import 'package:fieldforce/helper/colors.dart';
import 'package:fieldforce/helper/config.dart';
import 'package:fieldforce/helper/size_config.dart';
import 'package:fieldforce/models/crm_models/opportinuty_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:multiple_search_selection/multiple_search_selection.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
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
  List<String> competitorsList=["val1",'val2',"val3", "val4",];
  List<String> selectedCompetitorsList=[];
  bool isMultiDropdownOpen=false;
  late OpportunityDetailsModel opportunityDetails;
  late AddOpportunityBloc addOpportunityBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    opportunityDetails=widget.opportunityDetails;
    addOpportunityBloc=BlocProvider.of<AddOpportunityBloc>(context);
  }
  updateValues()
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocListener<AddOpportunityBloc,AddOpportunityState>(listener: (context, state) {
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

                }
        },child:  Scaffold(
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
                      isReadOnly: false,
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
                      readOnly: false),
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

                  MultiSelectDropDown<String>(
                    controller: _controller,
                    // clearIcon: const Icon(CupertinoIcons.multiply),
                    onOptionSelected: (options) {},
                    searchEnabled: true,
                    searchLabel: "search",
                    options: <ValueItem<String>>[
                      ValueItem(
                        label: 'Option 1',
                        value: 'User 1',),
                      ValueItem(
                        label: 'Option 2',
                        value: 'User 2',),
                      ValueItem(
                        label: 'Option 3',
                        value: 'User 3',),
                      ValueItem(
                        label: 'Option 4',
                        value: 'User 4',),
                      ValueItem(
                        label: 'Option 5',
                        value: 'User 5',),
                    ],
                    //maxItems: 4,
                    singleSelectItemStyle: TextStyle(fontSize: SizeConfig.blockHeight*2,color:COLORS.black,fontFamily: Config.fountFamilyPrimary,fontWeight:FontWeight.w400),
                    chipConfig: const ChipConfig(
                      radius:6 ,

                      wrapType: WrapType.scroll,
                      backgroundColor: COLORS.whiteExtraLight,
                      labelColor: COLORS.black,
                      deleteIcon: const Icon(CupertinoIcons.multiply,color: COLORS.black,),
                    ),
                    optionTextStyle: TextStyle(fontSize: SizeConfig.blockHeight*2,color:COLORS.black,fontFamily: Config.fountFamilyPrimary,fontWeight:FontWeight.w400),
                    // selectedOptionIcon: const Icon(
                    //   CupertinoIcons.multiply,
                    //   color: Colors.pink,
                    // ),
                    selectedOptionBackgroundColor: COLORS.gray,
                    selectedOptionTextColor: COLORS.blue,
                    dropdownMargin: 2,
                    onOptionRemoved: (index, option) {},
                    optionBuilder: (context, valueItem, isSelected) {
                      return ListTile(
                        title: Text(valueItem.label),
                        //subtitle: Text(valueItem.value.toString()),
                        trailing: isSelected
                            ? const Icon(Icons.check_circle)
                            : const Icon(Icons.radio_button_unchecked),
                      );
                    },
                    borderColor: COLORS.blue,
                    borderWidth: 1.5,
                    borderRadius:SizeConfig.blockWidth * 1.5,
                  ),
                  const InputFieldTitleText(text: "Next Steps "),
                  MultiLineTextFormField(onChanged: (value){}, controller: nextStepsController, inputType: TextInputType.text, validator: (value){
                    return null;
                  }, isReadOnly: false, labelText: "Enter Next Steps Here"),

                  const InputFieldTitleText(text: "Notes "),
                  MultiLineTextFormField(onChanged: (value){}, controller: notesController, inputType: TextInputType.text, validator: (value){
                    return null;
                  }, isReadOnly: false, labelText: "Enter Notes Here"),

                  SizedBox(height: SizeConfig.blockHeight*3,),
                  SubmitButtonComponent(onTap:(){
                    setState(() {
                      selectedCompetitorsList.clear();
                      for(ValueItem item in _controller.selectedOptions)
                      {
                        selectedCompetitorsList.add(item.value.toString());
                      }
                      updateValues();
                      addOpportunityBloc.add(AddNewOpportunityEvent(opportunityDetails: opportunityDetails));
                      print("selectedCompetitorsList----------------$selectedCompetitorsList");
                    });

                  },)

                ],
              ),
            ),

          ),
        ),)


    );
  }
}
