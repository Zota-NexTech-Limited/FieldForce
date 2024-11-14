import 'package:fieldsales/bloc/get_activity_list/activity_list_bloc.dart';
import 'package:fieldsales/components/svg_image_component.dart';
import 'package:fieldsales/components/text_component/normal_text.dart';
import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/config.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:fieldsales/ui/crm/crm_screen.dart';
import 'package:fieldsales/ui/home_screen/menu_screen.dart';
import 'package:fieldsales/ui/menu/report/reports_screen.dart';
import 'package:fieldsales/ui/my_activity/my_activity_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';


class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
   List<Widget> _widgetOptions = <Widget>[
     CRMScreen(),
     BlocProvider(create: (context)=>ActivityListBloc()..add(const FetchActivityListEvent()),child: MyActivityScreen(),),
     ReportsScreen(),
     MenuScreen(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
       _selectedIndex = 0;
    });
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        //drawer:const DrawerScreen(),
        backgroundColor: COLORS.backgroundColor,
        appBar:PreferredSize(preferredSize: Size(SizeConfig.screenWidth, SizeConfig.blockHeight*13), child: Container(
          width: SizeConfig.screenWidth,
          color: COLORS.backgroundColor,
          child: Container(
            //margin: EdgeInsets.only(bottom:SizeConfig.blockHeight*3),
            color: COLORS.appBarColor,
            padding: EdgeInsets.all(SizeConfig.blockHeight*3),
            child: Row(
              children: [
                 NormalText(fontWeight: FontWeight.w700, color: COLORS.black, fontSize: 2.7, text:_selectedIndex==0? "Leads":_selectedIndex==1?"My Activity":_selectedIndex==2?"Reports":"Menu"),
                const Spacer(),
                SvgImageHelper(image: "assets/image/svg_icons/notification.svg"),
                SizedBox(width: SizeConfig.blockWidth*6,),
                SvgImageHelper(image: "assets/image/svg_icons/settings_icon.svg"),
                /*if( _tabController.index==0)...[
                       InkWell(
                           onTap: () {
                             Navigator.push(context, MaterialPageRoute(builder: (context)=>const LeadFilterScreen()));
                           },
                           child: const Icon(Icons.filter_alt_sharp,color: COLORS.white,)),
                     ]*/

              ],
            ),
          ),
        )),
        body:SizedBox(
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          child:  _widgetOptions[_selectedIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(

          backgroundColor: COLORS.white,
          elevation: 0,
          selectedItemColor: COLORS.primaryColor,
          unselectedItemColor:COLORS.black ,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.w500, color: Colors.blue, fontSize: SizeConfig.blockHeight*0, fontFamily: Config.fountFamilyPrimary),
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w500, color: Colors.black, fontSize: SizeConfig.blockHeight*0, fontFamily: Config.fountFamilyPrimary),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon:bottomNavigationIcons(icon:'assets/image/svg_icons/home_icon2.svg',index: 0,label: "HOME"),
              label: '',

            ),
            BottomNavigationBarItem(

              icon:bottomNavigationIcons(icon: 'assets/image/svg_icons/dashboard_icon.svg',index: 1,label: "My  Activity"),
              label: '',
            ),
            BottomNavigationBarItem(
              icon:bottomNavigationIcons(icon: 'assets/image/svg_icons/reports_icon.svg',index: 2,label: "REPORTS"),
              label: '',
            ),
            BottomNavigationBarItem(
              icon:bottomNavigationIcons(icon: 'assets/image/svg_icons/menu_icon.svg',index: 3,label: "MENU"),
              label: '',


            ),
          ],
          currentIndex: _selectedIndex,
          onTap: (index){
            setState(() {
              _selectedIndex = index;
            });
          },
        ),

      ),
    );
  }
  Widget bottomNavigationIcons({required String icon,required int index,required String label})
  {
    return Container(
      height: SizeConfig.blockHeight*7.9,
      width: SizeConfig.blockWidth*34,
      color:_selectedIndex==index?COLORS.appBarColor:COLORS.white,
      padding: EdgeInsets.symmetric(vertical: SizeConfig.blockWidth*1.5),
      child: Column(
        children: [
          SvgPicture.asset(
            icon,
            color: _selectedIndex==index?COLORS.primaryColor:COLORS.black,// Replace with your SVG file path
            width: SizeConfig.blockWidth*5,
            height: SizeConfig.blockHeight*3,

          ),
         SizedBox(height: SizeConfig.blockHeight*1,),
          NormalText(fontWeight: FontWeight.w500, color: _selectedIndex==index?COLORS.primaryColor:COLORS.black, fontSize: 1.5, text: label)
        ],
      ),
    );
  }
}
