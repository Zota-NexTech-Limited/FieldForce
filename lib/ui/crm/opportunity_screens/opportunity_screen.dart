import 'package:fieldforce/bloc/edit_opportunity_bloc/edit_opportunity_bloc.dart';
import 'package:fieldforce/bloc/get_opportunity_by_id_bloc/get_opportunity_by_id_bloc.dart';
import 'package:fieldforce/bloc/opportunity_list_bloc/opportunity_list_bloc.dart';
import 'package:fieldforce/components/state_management_components/empty_screen_component.dart';
import 'package:fieldforce/components/state_management_components/error_screen.dart';
import 'package:fieldforce/components/state_management_components/loading_screen.dart';
import 'package:fieldforce/helper/config.dart';
import 'package:fieldforce/ui/crm/opportunity_screens/add_new_opportunity_screens/add-oppertunity_screen.dart';
import 'package:fieldforce/ui/crm/opportunity_screens/add_opportunity_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:fieldforce/components/button_component/add_new_button.dart';
import 'package:fieldforce/components/text_component/normal_text.dart';
import 'package:fieldforce/components/text_form_field_component/filter_field.dart';
import 'package:fieldforce/helper/colors.dart';
import 'package:fieldforce/helper/size_config.dart';
import 'package:fieldforce/ui/crm/lead_screens/add_lead_details_screen/add_lead_details_screen.dart';
import 'package:fieldforce/ui/crm/lead_screens/add_lead_details_screen/add_lead_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';
class OpportunityScreen extends StatefulWidget {
  const OpportunityScreen({super.key});

  @override
  State<OpportunityScreen> createState() => _OpportunityScreenState();
}

class _OpportunityScreenState extends State<OpportunityScreen> {
  late OpportunityListBloc opportunityListBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    opportunityListBloc=BlocProvider.of<OpportunityListBloc>(context);
  }

  void _refreshPage() {
    setState(() {
      opportunityListBloc.add(const GetOpportunityListEvent());
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:BlocBuilder<OpportunityListBloc,OpportunityListState>(builder:
            (context, state) {
          if(state is OpportunityListLoadingState)
            {
              return const LoadingScreen();
            }
          else if(state is OpportunityListSuccessState)
            {
              return RefreshIndicator(
                color: COLORS.blue,
                onRefresh: (){
                  return Future.delayed(
                      const Duration(milliseconds: 200),
                          (){
                            _refreshPage();

                      }
                  );
                },
                child: Scaffold(
                  backgroundColor: COLORS.white,
                  body: Stack(
                    children: [
                      SingleChildScrollView(
                        //physics:const NeverScrollableScrollPhysics(),
                        child: Container(
                          margin: EdgeInsets.only(top: SizeConfig.blockHeight*3),
                          width: SizeConfig.screenWidth,
                          height: SizeConfig.screenHeight,
                          child:state.opportunityList.isNotEmpty? ListView.builder(
                            itemCount: state.opportunityList.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: (){
                                  //Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddOpportunityDetailsScreen()));
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> MultiBlocProvider(providers: [
                                    BlocProvider(create: (context)=>GetOpportunityByIdBloc()..add(TriggerGetOpportunityByIdEvent(id: state.opportunityList[index].opportunityId.toString()))),
                                    BlocProvider(create: (context)=>EditOpportunityBloc()),
                                  ], child: AddOpportunityScreen(pageRefreshFunction: _refreshPage,),)
                                  ));

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

                                          Expanded(
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                             /*   Container(
                                                  height: SizeConfig.blockHeight*6,
                                                  width: SizeConfig.blockWidth*10,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*2)),
                                                      border: Border.all(color: COLORS.white)
                                                  ),
                                                  child: Image.asset("assets/image/common/profile_image.png",fit: BoxFit.fill,),
                                                ),
                                                SizedBox(width: SizeConfig.blockWidth*2,),*/
                                                SizedBox(
                                                    width: SizeConfig.screenWidth*0.5,
                                                    child: Text("${state.opportunityList[index].opportunityEmail}",
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: SizeConfig.blockHeight*2,
                                                          color:COLORS.black,
                                                          fontFamily:
                                                          Config.fountFamilyPrimary,
                                                          fontWeight:FontWeight.w500),)
                                                )
                                              ],
                                            ),
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



                                    ],
                                  ),
                                ),
                              );
                            },):EmptyScreen(text: "Opportunity Not Found!"),
                        ),
                      ),
                      Positioned(
                          bottom: SizeConfig.blockHeight*2,
                          left: SizeConfig.screenWidth*0.3,
                          child:  Align(
                            alignment: Alignment.bottomCenter,
                            child: AddNewButton(title: "New Opportunity", onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> MultiBlocProvider(providers: [
                                BlocProvider(create: (context)=>GetOpportunityByIdBloc()),
                                BlocProvider(create: (context)=>EditOpportunityBloc()),
                              ], child: AddOpportunityScreen(pageRefreshFunction: _refreshPage,),)
                                  ));
                            }),
                          )
                      )
                    ],
                  ),
                ),
              );
            }
          else if(state is OpportunityListFailedState)
            {
              return ErrorScreen(onPressed: (){
                opportunityListBloc.add(const GetOpportunityListEvent());
              });
            }
          return Container();
        },)


    );
  }
}
