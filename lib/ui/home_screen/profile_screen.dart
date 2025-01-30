import 'package:fieldsales/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:fieldsales/bloc/reset_password/reset_password_bloc.dart';
import 'package:fieldsales/components/svg_image_component.dart';
import 'package:fieldsales/components/text_component/normal_text.dart';
import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/config.dart';
import 'package:fieldsales/helper/global_handler.dart';
import 'package:fieldsales/helper/reuse_functions/upper_camel_case.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ResetPasswordBloc resetPasswordBloc;
  @override
  void initState() {
    super.initState();
    resetPasswordBloc=BlocProvider.of<ResetPasswordBloc>(context);
  }
  @override
  Widget build(BuildContext context) {
    return
      BlocListener<ResetPasswordBloc, ResetPasswordState>(listener: (context, state) {
        if(state is ResetPasswordLoadingState)
        {

        }else if(state is ResetPasswordSuccessState)
        {
          final snackBar = SnackBar(content: Text(state.message));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }else if(state is ResetPasswordFailedState)
        {
          final snackBar = SnackBar(content: Text(state.message));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        setState(() {

        });
      },child:
      SafeArea(child: Scaffold(
        backgroundColor: COLORS.backgroundColor,
        appBar:AppBar(
          backgroundColor: COLORS.secondaryColor,
          titleSpacing: SizeConfig.blockWidth*1,
          leading: InkWell(
              onTap: (){

                Navigator.pop(context);
                FocusScope.of(context).unfocus();
              },
              child:  Icon(Icons.arrow_back_sharp,size: SizeConfig.blockHeight*3.6,color: COLORS.black,)),
          centerTitle: false,
          leadingWidth: SizeConfig.blockWidth*11,
          title: NormalText(fontWeight: FontWeight.w600, color: COLORS.black, fontSize: 2.5, text: "Profile") ,
        ) ,
        body: Container(
          width: SizeConfig.screenWidth,
          //padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*3,vertical: SizeConfig.blockHeight*2),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: SizeConfig.blockHeight*30,
                width: SizeConfig.screenWidth,
                decoration: BoxDecoration(
                  color: COLORS.white,
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(SizeConfig.blockWidth*4),bottomLeft:Radius.circular(SizeConfig.blockWidth*4) ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 0.1,
                      blurRadius: 5,
                      offset: Offset(0, 0),
                    ),
                  ],

                ),
                child: Column(

                  children: [
                    SizedBox(height: SizeConfig.blockHeight*3,),
                    Container(
                        height: SizeConfig.blockHeight*8,
                        width: SizeConfig.blockWidth*14.5,
                        decoration: BoxDecoration(

                            border: Border.all(color: COLORS.primaryColor,width: SizeConfig.blockWidth*0.4),
                            borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*7))
                        ),
                        child:  Center(child: NormalText(color: COLORS.black,fontWeight: FontWeight.w800,fontSize: 3,text: Config.userName[0].toUpperCase(),))
                    ),
                    NormalText(fontWeight: FontWeight.w700, color: COLORS.black, fontSize: 2.5, text: toUpperCamelCase(Config.userName)),
                    SizedBox(height: SizeConfig.blockHeight*1,),
                    NormalText(fontWeight: FontWeight.w500, color: COLORS.black, fontSize: 2, text: toUpperCamelCase(Config.userRole)),
                    NormalText(fontWeight: FontWeight.w500, color: COLORS.black, fontSize: 2, text: toUpperCamelCase(Config.userDepartment)),

                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: SizeConfig.blockHeight*24),
                width: SizeConfig.screenWidth,
                padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*4.5),
                child: Column(
                  children: [
                    Container(
                      width: SizeConfig.screenWidth,
                      padding: EdgeInsets.all(SizeConfig.blockWidth*3),
                      decoration: BoxDecoration(
                          color: COLORS.white,
                          borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*2),),
                          border: Border.all(color:COLORS.billingCardBorder )
                      ),
                      child: Column(
                        children: [
                          cardHelper(icon: "assets/svg_image_icons/profile_email.svg", title: "Email", subTitle: Config.userEmail),
                          const Divider(color: COLORS.billingCardBorder,),
                          cardHelper(icon: "assets/svg_image_icons/profile_call.svg", title: "Phone", subTitle: Config.userPhoneNumber),
                          const Divider(color: COLORS.billingCardBorder,),
                          cardHelper(icon: "assets/svg_image_icons/profile_department.svg", title: "Department", subTitle: Config.userDepartment),
                          const Divider(color: COLORS.billingCardBorder,),
                          cardHelper(icon: "assets/svg_image_icons/profile_position.svg", title: "Position", subTitle: Config.userRole),
                        ],
                      ),
                    ),
                    SizedBox(height: SizeConfig.blockHeight*2,),
                    Container(
                      width: SizeConfig.screenWidth,
                      padding: EdgeInsets.all(SizeConfig.blockWidth*3),
                      decoration: BoxDecoration(
                          color: COLORS.white,
                          borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*2),),
                          border: Border.all(color:COLORS.billingCardBorder )
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          NormalText(fontWeight: FontWeight.w700, color: COLORS.black, fontSize: 2, text: "Quick Actions "),
                          SizedBox(height: SizeConfig.blockHeight*2,),
                          InkWell(
                            onTap: (){
                              print("onTap triggered");
                              resetPasswordBloc.add(TriggerResetPasswordEvent(email: Config.userEmail.toLowerCase()));
                            },
                            child: SizedBox(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgImageHelper(image: "assets/svg_image_icons/profile_reset_password.svg"),
                                  SizedBox(width: SizeConfig.blockWidth*3,),
                                  NormalText(fontWeight: FontWeight.w500, color: COLORS.black, fontSize: 2, text: "Change Password"),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: SizeConfig.blockHeight*1,),
                          const Divider(color: COLORS.billingCardBorder,),
                          SizedBox(height: SizeConfig.blockHeight*1,),
                          InkWell(
                            onTap: (){
                              GlobalBlocClass.authenticationBloc!.add(AuthenticationLogoutEvent());
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgImageHelper(image: "assets/svg_image_icons/logout.svg"),
                                SizedBox(width: SizeConfig.blockWidth*3,),
                                NormalText(fontWeight: FontWeight.w500, color: COLORS.red, fontSize: 2.2, text: "Logout"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),

        ),
      )),
      );
  }

  Widget cardHelper({required String icon,required String title,required String subTitle,})
  {
    return  Row(
      children: [
        SvgImageHelper(image: icon),
        SizedBox(width: SizeConfig.blockWidth*4,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NormalText(fontWeight: FontWeight.w500, color: COLORS.profileGrayColor, fontSize: 1.8, text:title),
            NormalText(fontWeight: FontWeight.w500, color: COLORS.black, fontSize:2, text: toUpperCamelCase(subTitle)),

          ],
        )
      ],
    );
  }
}

