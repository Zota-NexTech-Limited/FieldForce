import 'package:fieldforce/bloc/lead_list_bloc/lead_list_bloc.dart';
import 'package:fieldforce/bloc/opportunity_list_bloc/opportunity_list_bloc.dart';
import 'package:fieldforce/components/text_component/normal_text.dart';
import 'package:fieldforce/helper/colors.dart';
import 'package:fieldforce/helper/config.dart';
import 'package:fieldforce/helper/size_config.dart';
import 'package:fieldforce/ui/crm/lead_screens/lead_filter_screen.dart';
import 'package:fieldforce/ui/crm/lead_screens/lead_screen.dart';
import 'package:fieldforce/ui/crm/opportunity_screens/add_opportunity_details_screen.dart';
import 'package:fieldforce/ui/crm/opportunity_screens/opportunity_screen.dart';
import 'package:fieldforce/ui/my_activity/my_activity_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class CRMScreen extends StatefulWidget {
  const CRMScreen({super.key});

  @override
  State<CRMScreen> createState() => _CRMScreenState();
}

class _CRMScreenState extends State<CRMScreen>  with SingleTickerProviderStateMixin{
  late TabController _tabController;
  final List<Widget> _tabs=[
     BlocProvider(create: (context)=>LeadListBloc()..add(const FetchLeadListEvent(fromDate: "", toDate: "", search: "")),child:const  LeadScreen(),),
    BlocProvider(create: (context)=>OpportunityListBloc()..add(const GetOpportunityListEvent()),child:const  OpportunityScreen(),),


  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    _tabController.addListener(() {
      setState(() {
      });
      print("Selected Index: " + _tabController.index.toString());
    });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar:PreferredSize(preferredSize: Size(SizeConfig.screenWidth, SizeConfig.blockHeight*20), child: Container(
            width: SizeConfig.screenWidth,
            color: COLORS.blue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(SizeConfig.blockHeight*2),
                  child: Row(
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back_rounded,color: COLORS.white,size: SizeConfig.blockHeight*4,)),
                      SizedBox(width: SizeConfig.blockWidth*5,),
                      const NormalText(fontWeight: FontWeight.w400, color: COLORS.white, fontSize: 3, text: "CRM"),
                      const Spacer(),
                     if( _tabController.index==0)...[
                       InkWell(
                           onTap: () {
                             Navigator.push(context, MaterialPageRoute(builder: (context)=>const LeadFilterScreen()));
                           },
                           child: const Icon(Icons.filter_alt_sharp,color: COLORS.white,)),
                     ]

                    ],
                  ),
                ),
                SizedBox(height: SizeConfig.blockHeight*3,),
                TabBar(
                  controller: _tabController,
                  labelColor: COLORS.white,
                  indicatorColor: COLORS.white,
                  dividerColor: COLORS.blue,
                  indicatorSize: TabBarIndicatorSize.tab,
                  padding: EdgeInsets.all(SizeConfig.blockWidth * 0),
                  labelPadding: EdgeInsets.all(SizeConfig.blockWidth * 0),
                  unselectedLabelColor: COLORS.white,
                  onTap: (value){
                    setState(() {

                    });
                  },
                  labelStyle: TextStyle(
                    color: COLORS.white,
                    fontSize: SizeConfig.blockWidth *4,
                    fontFamily: Config.fountFamilyPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                  tabs: const [
                    Tab(text: "LEAD"),
                    Tab(text: "OPPORTUNITY"),
                  ],
                ),
              ],
            ),
          )),
          body: DefaultTabController(
            length: 2,
            child: TabBarView(
              controller: _tabController,
              children: _tabs,
            ),
          ),
        ));
  }
}
