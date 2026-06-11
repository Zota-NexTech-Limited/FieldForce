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
         backgroundColor: COLORS.scaffoldBg,
         body:Container(
           width: SizeConfig.screenWidth,
           padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*4,vertical: SizeConfig.blockHeight*2),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
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
               SizedBox(height: SizeConfig.blockHeight*3,),
               Padding(
                 padding: EdgeInsets.only(left: SizeConfig.blockWidth*1,bottom: SizeConfig.blockHeight*1.2),
                 child: NormalText(
                   text: widget.screenName=="lead_screen" ? "Date Range" : "Filter By",
                   color: COLORS.textSecondary,
                   fontSize: 1.8,
                   fontWeight: FontWeight.w600,
                 ),
               ),
               Container(
                 width: SizeConfig.screenWidth,
                 padding: EdgeInsets.all(SizeConfig.blockWidth*3),
                 decoration: BoxDecoration(
                   color: COLORS.white,
                   borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*4.5)),
                   border: Border.all(color: COLORS.cardBorder,width: 1),
                   boxShadow: [
                     BoxShadow(
                       color: COLORS.shadow,
                       blurRadius: 14,
                       offset: const Offset(0, 6),
                     ),
                   ],
                 ),
                 child:widget.screenName=="lead_screen"?
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Expanded(child: filterDatePickerCard(text: "From Date :$fromDate", filterText: "from_date", width:SizeConfig.blockWidth*45)),
                     SizedBox(width: SizeConfig.blockWidth*3,),
                     Expanded(child: filterDatePickerCard(text: "To Date :$toDate", filterText: "to_date", width:SizeConfig.blockWidth*45)),
                   ],
                 ):
                 Row(
                   mainAxisAlignment: MainAxisAlignment.start,
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
     final bool isSelected = selectedFilterType==filterText;
     return  InkWell(
       borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*3)),
       onTap: (){
         setState(() {
           selectedFilterType=filterText;
         });
       },
       child: AnimatedContainer(
         duration: const Duration(milliseconds: 200),
         curve: Curves.easeOut,
         width: width,
         padding: EdgeInsets.symmetric(vertical: SizeConfig.blockHeight*1.4,horizontal: SizeConfig.blockWidth*3),
         decoration: BoxDecoration(
             color: isSelected?COLORS.primaryColor:COLORS.surfaceMuted,
             borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*3)),
             border: Border.all(color: isSelected?COLORS.primaryColor:COLORS.cardBorder,width: 1),
           boxShadow:isSelected? [
             BoxShadow(
               color: COLORS.shadow,
               blurRadius: 10,
               offset: const Offset(0, 4),
             ),
           ]:[],
         ),
         child: Center(child: NormalText(color:isSelected?COLORS.white:COLORS.textSecondary,text: text,fontSize:1.9,fontWeight: FontWeight.w600,)),
       ),
     );
   }

   Widget filterDatePickerCard({required String text,required String filterText,required double width})
   {
     return  InkWell(
       borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*3)),
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
         padding: EdgeInsets.symmetric(vertical: SizeConfig.blockHeight*1.4,horizontal: SizeConfig.blockWidth*3),
         decoration: BoxDecoration(
           color: COLORS.surfaceMuted,
           borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*3)),
           border: Border.all(color: COLORS.cardBorder,width: 1),
         ),
         child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Flexible(child: NormalText(color:COLORS.textPrimary,text: text,fontSize:1.7,fontWeight: FontWeight.w600,)),
             SizedBox(width: SizeConfig.blockWidth*1,),
             Icon(Icons.calendar_today_rounded,size: SizeConfig.blockWidth*4,color: COLORS.primaryColor,),
           ],
         ),
       ),
     );
   }


 }
