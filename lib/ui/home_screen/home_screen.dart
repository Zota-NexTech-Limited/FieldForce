import 'dart:ui';

import 'package:fieldforce/bloc/get_activity_list/activity_list_bloc.dart';
import 'package:fieldforce/components/svg_image_component.dart';
import 'package:fieldforce/components/text_component/normal_text.dart';
import 'package:fieldforce/helper/colors.dart';
import 'package:fieldforce/helper/size_config.dart';
import 'package:fieldforce/ui/crm/crm_screen.dart';
import 'package:fieldforce/ui/expense/expence_screen.dart';
import 'package:fieldforce/ui/my_activity/my_activity_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
          backgroundColor: COLORS.white,
         appBar: PreferredSize(
             preferredSize: Size(SizeConfig.screenWidth, SizeConfig.blockHeight*30),
             child:
         Container(
           color: COLORS.blue,
           padding:EdgeInsets.all(SizeConfig.blockHeight*2),
           child: Column(
             children: [
                Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   SizedBox(width: SizeConfig.blockWidth*7,),
                   NormalText(fontWeight: FontWeight.w400, color: COLORS.white, fontSize: 3, text: "Dashboard"),
                   Icon(CupertinoIcons.power,color: COLORS.white,)
                 ],
               ),
               SizedBox(height: SizeConfig.blockHeight*2,),
               Container(
                 height: SizeConfig.blockHeight*8,
               width: SizeConfig.blockWidth*15,
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*2)),
                 border: Border.all(color: COLORS.white)
               ),
                 padding: EdgeInsets.all(SizeConfig.blockWidth*2),
                 child: SvgImageHelper(image: "assets/image/svg_icons/profile_icon.svg"),
               ),
               SizedBox(height: SizeConfig.blockHeight*2,),
               NormalText(fontWeight: FontWeight.w400, color: COLORS.white, fontSize: 3.3, text: "MAHESHKUMARA M P"),
               SizedBox(height: SizeConfig.blockHeight*1,),
               NormalText(fontWeight: FontWeight.w300, color: COLORS.white, fontSize: 2, text: "15-07-2001"),

             ],
           ),
         )),
          body: SingleChildScrollView(

            child: Container(
              width: SizeConfig.screenWidth,
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*3,vertical: SizeConfig.blockHeight*2),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      homeCard(icon: "assets/image/svg_icons/calender_icon.svg", title: "End Day", onTap: (){}),
                      homeCard(icon: "assets/image/svg_icons/calender_icon.svg", title: "Day Plan", onTap: (){}),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      homeCard(icon: "assets/image/svg_icons/calender_icon.svg", title: "Reports", onTap: (){}),
                      homeCard(icon: "assets/image/svg_icons/calender_icon.svg", title: "CRM", onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const CRMScreen()));
                      }),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      homeCard(icon: "assets/image/svg_icons/calender_icon.svg", title: "My Activity", onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>BlocProvider(create: (context)=>ActivityListBloc()..add(FetchActivityListEvent()),child: MyActivityScreen(),)));
                      }),
                      homeCard(icon: "assets/image/svg_icons/calender_icon.svg", title: "Expense", onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const ExpenceScreen()));
                      }),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      homeCard(icon: "assets/image/svg_icons/calender_icon.svg", title: "Ticket Status ", onTap: (){}),
                      homeCard(icon: "assets/image/svg_icons/calender_icon.svg", title: "Leave", onTap: (){}),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget homeCard({required String icon,required String title,required VoidCallback onTap})
  {
    return  InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: SizeConfig.blockHeight*3),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 0.1,
                blurRadius: 5,
                offset: Offset(0, 1),
              ),
            ],
            color: COLORS.white,
          borderRadius: BorderRadius.only(topLeft:Radius.circular(SizeConfig.blockWidth*2) ),

        ),
        child: ClipRRect(
          clipBehavior: Clip.hardEdge,
          borderRadius: BorderRadius.only(topLeft:Radius.circular(SizeConfig.blockWidth*2) ),
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.all(SizeConfig.blockHeight*1),
                height: SizeConfig.blockHeight*19,
                width: SizeConfig.blockHeight*25,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 0.1,
                        blurRadius: 10,
                        offset: Offset(0, 1),
                      ),
                    ],
                    color: COLORS.white,
                    border: Border.all(color: COLORS.blue),
                    borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*2))
                ),
                child: Align(
                    alignment: Alignment.bottomRight,
                    child: NormalText(fontWeight: FontWeight.w500, color: COLORS.black, fontSize: 2.2, text: title)),

              ),
              Positioned(
                bottom: SizeConfig.blockHeight*2.7,
                right: SizeConfig.blockWidth*6,
                child:CircleAvatar(
                  backgroundColor: COLORS.blue,
                  radius: SizeConfig.blockWidth*28,
                )  ,),
              Positioned(
                top: SizeConfig.blockHeight*4,
                left: SizeConfig.blockWidth*6,
                child: SizedBox(
                    height: SizeConfig.blockHeight*6,
                    width: SizeConfig.blockWidth*18,
                    child: SvgImageHelper(image:icon)),)
            ],
          ),
        ),
      ),
    );
  }
}
