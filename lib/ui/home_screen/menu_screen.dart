import 'package:fieldsales/bloc/expense_list_bloc/expense_list_bloc.dart';
import 'package:fieldsales/bloc/get_activity_list/activity_list_bloc.dart';
import 'package:fieldsales/bloc/leave_list_bloc/leave_list_bloc.dart';
import 'package:fieldsales/components/svg_image_component.dart';
import 'package:fieldsales/components/text_component/normal_text.dart';
import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:fieldsales/ui/expense/expence_screen.dart';
import 'package:fieldsales/ui/leave/leave_screen.dart';
import 'package:fieldsales/ui/my_activity/my_activity_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  String selectedTab="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLORS.white,
      body:Container(
        width: SizeConfig.screenWidth,
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*3,vertical: SizeConfig.blockHeight*2),
        child: Column(
          children: [
            tabCard(onTap: (){
              setState(() {
                selectedTab="Home";
              });
            }, title: "Home", icon: "assets/image/svg_icons/home_icon2.svg"),
            tabCard(onTap: (){
              setState(() {
                selectedTab="My Activity";
                Navigator.push(context, MaterialPageRoute(builder: (context)=>BlocProvider(create: (context)=>ActivityListBloc()..add(const FetchActivityListEvent()),child: MyActivityScreen(),)));
              });
            }, title: "My Activity", icon: "assets/image/svg_icons/my_activity.svg"),
            tabCard(onTap: (){
              setState(() {
                selectedTab="Reports";
                 });
            }, title: "Reports", icon: "assets/image/svg_icons/contacts_reports.svg"),
            tabCard(onTap: (){
              setState(() {
                selectedTab="End Day";
              });
            }, title: "End Day", icon: "assets/image/svg_icons/end_day.svg"),
            tabCard(onTap: (){
              setState(() {
                selectedTab="Start Day";
              });
            }, title: "Start Day", icon: "assets/image/svg_icons/start_day.svg"),
            tabCard(onTap: (){
              setState(() {
                selectedTab="Expense";
                Navigator.push(context, MaterialPageRoute(builder: (context)=>BlocProvider(create: (context)=>ExpenseListBloc()..add(const FetchExpenseListEvent()),child: const ExpenceScreen(),)));
              });
            }, title: "Expense", icon: "assets/image/svg_icons/expense.svg"),
            tabCard(onTap: (){
              setState(() {
                selectedTab="Ticket Status";
              });
            }, title: "Ticket Status", icon: "assets/image/svg_icons/ticket_status.svg"),
            tabCard(onTap: (){
              setState(() {
                selectedTab="Leave";
                Navigator.push(context, MaterialPageRoute(builder: (context)=>BlocProvider(create: (context)=>LeaveListBloc()..add(const FetchLeaveListEvent()),child: LeaveScreen(),)));
              });
            }, title: "Leave", icon: "assets/image/svg_icons/call_black.svg"),
          ],
        ),

      ) ,
    );
  }

  Widget tabCard({required VoidCallback onTap,required String title,required String icon,})
  {
    return  InkWell(
      splashColor: COLORS.white,
      onTap:onTap ,
      child: Container(
        width: SizeConfig.screenWidth,
        margin: EdgeInsets.only(bottom: SizeConfig.blockHeight*2),
        padding:EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*2,vertical: SizeConfig.blockHeight*1.5) ,
        decoration: BoxDecoration(
            color:selectedTab==title?COLORS.blueLight2:COLORS.white,
            borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*2))

        ),
        child: Row(
          children: [
            SizedBox(
                height: SizeConfig.blockHeight*4,
                width: SizeConfig.blockWidth*6,
                child: SvgImageHelper(image:icon)),
            SizedBox(width: SizeConfig.blockWidth*2,),
            NormalText(fontWeight: FontWeight.w500, color: COLORS.grayDark, fontSize: 2.2, text: title)
          ],
        ),
      ),
    );
  }
}
