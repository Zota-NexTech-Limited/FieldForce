import 'package:fieldsales/components/text_component/normal_text.dart';
import 'package:fieldsales/components/text_form_field_component/filter_field_with_back_button.dart';
import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/reuse_functions/date_picker.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:flutter/material.dart';

 class FilterScreen extends StatefulWidget {
   final String filterText;
   final String filterType;
   final String screenName;
   final String? fromDate;
   final String? toDate;
   final Function(Map<String,dynamic>) onSearch;
   const FilterScreen({super.key,required this.onSearch,required this.filterText,required this.filterType,required this.screenName,this.fromDate,this.toDate});

   @override
   State<FilterScreen> createState() => _FilterScreenState();
 }

 class _FilterScreenState extends State<FilterScreen> {
   TextEditingController filterController=TextEditingController();
   String? selectedFilterType; //sot_invoice_number cmr_phone_number cmr_first_name
   String? fromDate;
   String? toDate;

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filterController.text=widget.filterText;
    selectedFilterType=widget.filterType;
    if(widget.screenName=="lead_screen")
      {
        fromDate=widget.fromDate??"";
        toDate=widget.toDate??"";
      }
  }
   @override
   Widget build(BuildContext context) {
     return SafeArea(
       child: Scaffold(
         backgroundColor: COLORS.backgroundColor,
         body:Container(
           width: SizeConfig.screenWidth,
           padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*3,vertical: SizeConfig.blockHeight*2),
           child: Column(
             children: [
               SizedBox(
                 height: SizeConfig.blockHeight*7,
                 child: FilterFieldWithBackButton(
                   hintText: "Search",
                   onSubmit: (value){
                     if(widget.screenName=="lead_screen")
                       {
                         Map<String,dynamic> filterMap={
                           "filter_text":value,
                           "from_date":fromDate,
                           "to_date":toDate
                         };
                         widget.onSearch(filterMap);
                         Navigator.pop(context);
                       }else{
                       Map<String,dynamic> filterMap={
                         "filter_type":selectedFilterType,
                         "filter_text":value,
                       };
                       widget.onSearch(filterMap);
                       Navigator.pop(context);
                     }



                   },
                   controller: filterController,
                   backButtonTap: (){
                     Navigator.pop(context);
                   },
                   clearButtonTap: (){
                     setState(() {
                       filterController.clear();
                     });
                   },
                   inputType: TextInputType.text,
                   isReadOnly: false,
                   onChanged: (value){},
                   validator: (value){},





                 ),
               ),
               SizedBox(height: SizeConfig.blockHeight*2,),
               Container(
                 padding: EdgeInsets.all(SizeConfig.blockWidth*1),
                 decoration: BoxDecoration(
                   color: COLORS.grayFilterBackColor,
                   borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*2))
                 ),
                 child:widget.screenName=="lead_screen"?
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     filterDatePickerCard(text: "From Date :$fromDate", filterText: "from_date", width:SizeConfig.blockWidth*45),
                     filterDatePickerCard(text: "To Date :$toDate", filterText: "to_date", width:SizeConfig.blockWidth*45),
                   ],
                 ):
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     filterCard(width:SizeConfig.blockWidth*40,text: "Lead",filterText: "" ),
                   ],
                 ),
               )
             ],
           ),
         ) ,
       ),
     );
   }

   Widget filterCard({required String text,required String filterText,required double width})
   {
     return  InkWell(
       onTap: (){
         setState(() {
           selectedFilterType=filterText;
         });
       },
       child: Container(

         width: width,
        padding: EdgeInsets.symmetric(vertical: SizeConfig.blockHeight*0.7),
         decoration: BoxDecoration(

             color: selectedFilterType==filterText?COLORS.white:COLORS.grayFilterBackColor,
             borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*1)),
           boxShadow:selectedFilterType==filterText? [
             BoxShadow(
               color: COLORS.black.withOpacity(0.3),
               spreadRadius: 0,
               blurRadius: 1,
               offset: Offset(0, 1),
             ),
           ]:[],
         ),
         child: Center(child: NormalText(color:selectedFilterType==filterText?COLORS.black:COLORS.grayFilterTextColor,text: text,fontSize:2,fontWeight: FontWeight.w500,)),
       ),
     );
   }

   Widget filterDatePickerCard({required String text,required String filterText,required double width})
   {
     return  InkWell(
       onTap: (){
         setState(() {
           showSingleDatePickerHelper2(context: context,onDateSelected: (selectedDate){
             setState(() {
               if(filterText=="from_date")
                 {
                   fromDate=selectedDate;
                 }else if(filterText=="to_date")
                   {
                     toDate=selectedDate;
                   }


             });
           });
         });
       },
       child: Container(

         width: width,
         padding: EdgeInsets.symmetric(vertical: SizeConfig.blockHeight*0.7),
         decoration: BoxDecoration(

           color: COLORS.white,
           borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*1)),
           boxShadow: [
             BoxShadow(
               color: COLORS.black.withOpacity(0.3),
               spreadRadius: 0,
               blurRadius: 1,
               offset: Offset(0, 1),
             ),
           ],
         ),
         child: Center(child: NormalText(color:COLORS.black,text: text,fontSize:2,fontWeight: FontWeight.w500,)),
       ),
     );
   }


 }
