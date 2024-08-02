import 'dart:ui';

import 'package:fieldforce/bloc/edit_lead_bloc/edit_lead_bloc.dart';
import 'package:fieldforce/bloc/get_lead_by_id_bloc/get_lead_by_id_bloc.dart';
import 'package:fieldforce/bloc/lead_list_bloc/lead_list_bloc.dart';
import 'package:fieldforce/components/button_component/add_new_button.dart';
import 'package:fieldforce/components/button_component/circular_button.dart';
import 'package:fieldforce/components/state_management_components/empty_screen_component.dart';
import 'package:fieldforce/components/state_management_components/error_screen.dart';
import 'package:fieldforce/components/state_management_components/loading_screen.dart';
import 'package:fieldforce/components/svg_image_component.dart';
import 'package:fieldforce/components/text_component/normal_text.dart';
import 'package:fieldforce/components/text_form_field_component/filter_field.dart';
import 'package:fieldforce/helper/colors.dart';
import 'package:fieldforce/helper/config.dart';
import 'package:fieldforce/helper/reuse_functions/date_picker.dart';
import 'package:fieldforce/helper/size_config.dart';
import 'package:fieldforce/models/crm_models/new_lead_model.dart';
import 'package:fieldforce/ui/crm/lead_screens/add_lead_details_screen/add_lead_details_screen.dart';
import 'package:fieldforce/ui/crm/lead_screens/add_lead_details_screen/add_lead_screen.dart';
import 'package:fieldforce/ui/crm/lead_screens/add_lead_details_screen/customer_information_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';
class LeadScreen extends StatefulWidget {
  const LeadScreen({super.key});

  @override
  State<LeadScreen> createState() => _LeadScreenState();
}

class _LeadScreenState extends State<LeadScreen> {
  TextEditingController filterController=TextEditingController();
  List<NewLeadModel>leadList=[];
  late LeadListBloc leadListBloc;
  String fromDate="";
  String toDate="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    leadListBloc=BlocProvider.of<LeadListBloc>(context);
  }
  void _refreshPage() {
    setState(() {
      leadListBloc.add(FetchLeadListEvent(fromDate: "", toDate: "", search: "") );
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:BlocBuilder<LeadListBloc,LeadListState>(
          builder: (context, state) {
             if(state is LeadListLoadingState)
               {
                 return const LoadingScreen();
               }else if (state is LeadListSuccessState)
                 {
                   leadList=state.leadList;
                 }else if(state is LeadListFailedState){

               return ErrorScreen(onPressed: (){
                 leadListBloc.add(FetchLeadListEvent(fromDate: "", toDate: "", search: ""));
               });
             }
            return  Scaffold(
              backgroundColor: COLORS.white,
              body: Stack(
                children: [
                  SingleChildScrollView(
                    physics:const NeverScrollableScrollPhysics(),
                    child: SizedBox(
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.screenHeight,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: SizeConfig.blockHeight*2,horizontal: SizeConfig.blockWidth*4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                dateSelect(title: "From Date",date: fromDate.isEmpty?"":fromDate,onTap: (){
                                 setState(() {
                                   showSingleDatePickerHelper2(context: context,onDateSelected: (selectedDate){
                                    setState(() {
                                      fromDate=selectedDate;
                                      leadListBloc.add(FetchLeadListEvent(fromDate: fromDate, toDate: toDate, search:filterController.text));
                                    });
                                   });
                                 });
                                }),
                                SizedBox(height: SizeConfig.blockHeight*6,child: VerticalDivider(thickness: SizeConfig.blockWidth*0.5,color: COLORS.blue,),),
                                dateSelect(title: "To Date",date: toDate.isEmpty?"":toDate,onTap: (){
                                 setState(() {
                                   showSingleDatePickerHelper2(context: context,onDateSelected: (selectedDate){
                                     setState(() {
                                       toDate=selectedDate;
                                       leadListBloc.add(FetchLeadListEvent(fromDate: fromDate, toDate: toDate, search:filterController.text));
                                     });
                                   });
                                   print("from date---------------------$fromDate");
                                 });
                                }),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: SizeConfig.blockHeight*2,horizontal: SizeConfig.blockWidth*3),
                            child: FilterTextFormField(
                              onChanged: (value){},
                              controller: filterController,
                              hintText: "",
                              inputType: TextInputType.text,
                              validator: (value){
                                return null;
                              },
                              isReadOnly: false,
                              iconTap: (){
                                leadListBloc.add(FetchLeadListEvent(fromDate: fromDate, toDate: toDate, search:filterController.text));
                              },
                            ),
                          ),
                          Divider(
                            thickness: SizeConfig.blockWidth*0.5,color: COLORS.blue,
                          ),
                          SizedBox(
                            width: SizeConfig.screenWidth,
                            height: SizeConfig.screenHeight*0.6,
                            child: RefreshIndicator(
                              color: COLORS.blue,
                              onRefresh: (){
                                return Future.delayed(
                                    const Duration(milliseconds: 200),
                                        (){

                                      _refreshPage();
                                      setState(() {
                                        fromDate="";
                                        toDate="";
                                        filterController.clear();
                                      });

                                    }
                                );
                              },
                              child:leadList.isNotEmpty?ListView.builder(
                                itemCount: leadList.length,
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: (){
                                     // Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddLeadDetailsScreen()));
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> MultiBlocProvider(providers: [
                                        BlocProvider(create: (context)=>GetLeadByIdBloc()..add(TriggerGetLeadByIdEvent(id: leadList[index].leadId!))),
                                        BlocProvider(create: (context)=>EditLeadBloc()),
                                      ], child: CustomerInformationScreen(id:leadList[index].leadId!,))));
                                    },
                                    child: Container(
                                      width: SizeConfig.screenWidth,
                                      margin: EdgeInsets.only(bottom: SizeConfig.blockHeight*2,right: SizeConfig.blockWidth*3,left: SizeConfig.blockWidth*3),
                                      padding: EdgeInsets.symmetric(vertical: SizeConfig.blockHeight*1,horizontal: SizeConfig.blockWidth*2),
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.3),
                                              spreadRadius: 0.1,
                                              blurRadius: 4,
                                              offset: Offset(0, 1),
                                            ),
                                          ],
                                          color: COLORS.white,
                                          borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*2.5))
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                      width: SizeConfig.screenWidth*0.6,
                                                      child: NormalText(fontWeight: FontWeight.w500, color: COLORS.black, fontSize:2, text: "Contact Name : ${leadList[index].leadContactName}")),
                                                  cardSubText(title: "Enquiry",subTitle: "${leadList[index].leadInquiryMedium}",width: 0.6),
                                                  cardSubText(title: "Lead Name",subTitle: "${leadList[index].leadFullName}",width: 0.6),
                                                  cardSubText(title: "Status",subTitle: "--",width: 0.6),
                                                  cardSubText(title: "Prospect Status",subTitle: "--",width: 0.6),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  SizedBox(
                                                    height: SizeConfig.blockHeight*3.5,
                                                    child: ElevatedButton(
                                                        style: ButtonStyle(
                                                            elevation: WidgetStatePropertyAll(0),
                                                            backgroundColor: WidgetStatePropertyAll(COLORS.blue),
                                                            shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*4))))

                                                        ),
                                                        onPressed: (){},
                                                        child: NormalText(fontWeight: FontWeight.w400, color: COLORS.white, fontSize: 2, text: "New")),
                                                  ),
                                                  SizedBox(height: SizeConfig.blockHeight*1,),
                                                  Stack(
                                                    children: [
                                                      SizedBox(
                                                        width: SizeConfig.blockWidth*13,
                                                        child: CircularPercentIndicator(
                                                          radius: SizeConfig.blockWidth*5.5,
                                                          lineWidth: SizeConfig.blockWidth*0.3,
                                                          percent: 0.4,
                                                          progressColor: COLORS.blue,

                                                        ),
                                                      ),
                                                      Positioned(
                                                          top: SizeConfig.blockHeight*2,
                                                          left: SizeConfig.blockWidth*4,
                                                          child: NormalText(color:COLORS.black ,fontSize: 1.7,fontWeight: FontWeight.w500,text: "40%",))
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),

                                          cardSubText(title: "Last Updated By",subTitle: "Maheshkumara M P 03-07-2024 grgkb bhk ",width: 1),

                                        ],
                                      ),
                                    ),
                                  );
                                },):ListView(
                                physics:const BouncingScrollPhysics(),
                                children: [
                                SizedBox(
                                    width:SizeConfig.screenWidth,
                                    height: SizeConfig.screenHeight,
                                    child: EmptyScreen(text: "Lead Not Found!     ",distanceFromTop: 10))
                              ], ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: SizeConfig.blockHeight*2,
                      left: SizeConfig.screenWidth*0.3,
                      child:  Align(
                        alignment: Alignment.bottomCenter,
                        child: AddNewButton(title: "New Lead", onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> MultiBlocProvider(providers: [
                            BlocProvider(create: (context)=>GetLeadByIdBloc()),
                            BlocProvider(create: (context)=>EditLeadBloc()),
                          ], child: CustomerInformationScreen(id:"",))));
                        }),
                      ))
                ],
              ),
            );
        },)
    );
  }
  Widget dateSelect({required String title,required String date,required VoidCallback onTap})
  {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(Icons.date_range,color: COLORS.blue,size: SizeConfig.blockHeight*3.8,),
          SizedBox(width: SizeConfig.blockWidth*5,),
           Column(
            children: [
              NormalText(
                  fontWeight: FontWeight.w400,
                  color: COLORS.blue,
                  fontSize: 2,
                  text: title),
              NormalText(
                  fontWeight: FontWeight.w400,
                  color: COLORS.black,
                  fontSize: 2.5,
                  text: date),
            ],
          )
        ],
      ),
    );
  }
  Widget cardSubText({required String title,required String subTitle,required double width})
  {
    return SizedBox(
    width: SizeConfig.screenWidth*width,
        child: Text("${title} : ${subTitle}",
  style: TextStyle(fontSize: SizeConfig.blockHeight*1.8,color:COLORS.black,fontFamily: Config.fountFamilyPrimary,fontWeight:FontWeight.w500),
  overflow: TextOverflow.ellipsis,
  )
  );
  }
}
