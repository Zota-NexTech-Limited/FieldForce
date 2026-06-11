import 'package:fieldsales/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:fieldsales/bloc/reset_password/reset_password_bloc.dart';
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
        backgroundColor: COLORS.scaffoldBg,
        appBar:AppBar(
          backgroundColor: COLORS.surface,
          elevation: 0,
          scrolledUnderElevation: 0,
          surfaceTintColor: COLORS.surface,
          titleSpacing: SizeConfig.blockWidth*1,
          leading: InkWell(
              borderRadius: BorderRadius.circular(SizeConfig.blockWidth*6),
              onTap: (){

                Navigator.pop(context);
                FocusScope.of(context).unfocus();
              },
              child:  Icon(Icons.arrow_back_ios_new_rounded,size: SizeConfig.blockHeight*2.8,color: COLORS.textPrimary,)),
          centerTitle: false,
          leadingWidth: SizeConfig.blockWidth*11,
          title: NormalText(fontWeight: FontWeight.w700, color: COLORS.textPrimary, fontSize: 2.4, text: "Profile") ,
        ) ,
        body: SingleChildScrollView(
          child: Container(
            width: SizeConfig.screenWidth,
            child: Column(
              children: [
                // ---------------- Header card ----------------
                Container(
                  width: SizeConfig.screenWidth,
                  padding: EdgeInsets.only(
                    top: SizeConfig.blockHeight*3,
                    bottom: SizeConfig.blockHeight*4,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [COLORS.primarySoft, COLORS.surface],
                    ),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(SizeConfig.blockWidth*7),
                      bottomLeft: Radius.circular(SizeConfig.blockWidth*7),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: COLORS.shadow,
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                          height: SizeConfig.blockHeight*9.5,
                          width: SizeConfig.blockHeight*9.5,
                          decoration: BoxDecoration(
                              color: COLORS.surface,
                              border: Border.all(color: COLORS.primaryColor,width: SizeConfig.blockWidth*0.6),
                              borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockHeight*9.5)),
                              boxShadow: [
                                BoxShadow(
                                  color: COLORS.shadow,
                                  blurRadius: 12,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                          ),
                          child:  Center(child: NormalText(color: COLORS.primaryColor,fontWeight: FontWeight.w800,fontSize: 3.4,text: Config.userName[0].toUpperCase(),))
                      ),
                      SizedBox(height: SizeConfig.blockHeight*1.6,),
                      NormalText(fontWeight: FontWeight.w700, color: COLORS.textPrimary, fontSize: 2.6, text: toUpperCamelCase(Config.userName)),
                      SizedBox(height: SizeConfig.blockHeight*1,),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.blockWidth*3.5,
                          vertical: SizeConfig.blockHeight*0.7,
                        ),
                        decoration: BoxDecoration(
                          color: COLORS.infoSoft,
                          borderRadius: BorderRadius.circular(SizeConfig.blockWidth*6),
                        ),
                        child: NormalText(fontWeight: FontWeight.w600, color: COLORS.primaryDark, fontSize: 1.7, text: toUpperCamelCase(Config.userRole)),
                      ),
                      SizedBox(height: SizeConfig.blockHeight*0.8,),
                      NormalText(fontWeight: FontWeight.w500, color: COLORS.textSecondary, fontSize: 1.9, text: toUpperCamelCase(Config.userDepartment)),
                    ],
                  ),
                ),
                // ---------------- Body ----------------
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    SizeConfig.blockWidth*4.5,
                    SizeConfig.blockHeight*2.5,
                    SizeConfig.blockWidth*4.5,
                    SizeConfig.blockHeight*3,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionLabel("Personal Information"),
                      SizedBox(height: SizeConfig.blockHeight*1.4,),
                      Container(
                        width: SizeConfig.screenWidth,
                        padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.blockWidth*4,
                          vertical: SizeConfig.blockHeight*0.6,
                        ),
                        decoration: _cardDecoration(),
                        child: Column(
                          children: [
                            cardHelper(icon: Icons.email_outlined, title: "Email", subTitle: Config.userEmail),
                            _rowDivider(),
                            cardHelper(icon: Icons.phone_outlined, title: "Phone", subTitle: Config.userPhoneNumber),
                            _rowDivider(),
                            cardHelper(icon: Icons.apartment_rounded, title: "Department", subTitle: Config.userDepartment),
                            _rowDivider(),
                            cardHelper(icon: Icons.badge_outlined, title: "Position", subTitle: Config.userRole),
                          ],
                        ),
                      ),
                      SizedBox(height: SizeConfig.blockHeight*3,),
                      _sectionLabel("Quick Actions"),
                      SizedBox(height: SizeConfig.blockHeight*1.4,),
                      Container(
                        width: SizeConfig.screenWidth,
                        padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.blockWidth*4,
                          vertical: SizeConfig.blockHeight*0.6,
                        ),
                        decoration: _cardDecoration(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              borderRadius: BorderRadius.circular(SizeConfig.blockWidth*3),
                              onTap: (){
                                print("onTap triggered");
                                resetPasswordBloc.add(TriggerResetPasswordEvent(email: Config.userEmail.toLowerCase()));
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: SizeConfig.blockHeight*1.6),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    _iconChip(
                                      Icons.lock_outline_rounded,
                                      bg: COLORS.primarySoft,
                                      fg: COLORS.primaryColor,
                                    ),
                                    SizedBox(width: SizeConfig.blockWidth*3.5,),
                                    Expanded(
                                      child: NormalText(fontWeight: FontWeight.w600, color: COLORS.textPrimary, fontSize: 2, text: "Change Password"),
                                    ),
                                    Icon(Icons.chevron_right_rounded, color: COLORS.textTertiary, size: SizeConfig.blockHeight*3,),
                                  ],
                                ),
                              ),
                            ),
                            _rowDivider(),
                            InkWell(
                              borderRadius: BorderRadius.circular(SizeConfig.blockWidth*3),
                              onTap: (){
                                GlobalBlocClass.authenticationBloc!.add(AuthenticationLogoutEvent());
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: SizeConfig.blockHeight*1.6),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    _iconChip(
                                      Icons.logout_rounded,
                                      bg: COLORS.dangerSoft,
                                      fg: COLORS.danger,
                                    ),
                                    SizedBox(width: SizeConfig.blockWidth*3.5,),
                                    Expanded(
                                      child: NormalText(fontWeight: FontWeight.w600, color: COLORS.danger, fontSize: 2, text: "Logout"),
                                    ),
                                    Icon(Icons.chevron_right_rounded, color: COLORS.textTertiary, size: SizeConfig.blockHeight*3,),
                                  ],
                                ),
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
        ),
      )),
      );
  }

  Widget cardHelper({required IconData icon,required String title,required String subTitle,})
  {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SizeConfig.blockHeight*1.6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _iconChip(icon, bg: COLORS.primarySoft, fg: COLORS.primaryColor),
          SizedBox(width: SizeConfig.blockWidth*3.5,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NormalText(fontWeight: FontWeight.w600, color: COLORS.textTertiary, fontSize: 1.7, text:title),
                SizedBox(height: SizeConfig.blockHeight*0.4,),
                NormalText(fontWeight: FontWeight.w600, color: COLORS.textPrimary, fontSize:2, text: toUpperCamelCase(subTitle)),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _iconChip(IconData icon, {required Color bg, required Color fg}) {
    return Container(
      height: SizeConfig.blockHeight*5.2,
      width: SizeConfig.blockHeight*5.2,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(SizeConfig.blockWidth*3.5),
      ),
      child: Icon(icon, color: fg, size: SizeConfig.blockHeight*2.8),
    );
  }

  Widget _sectionLabel(String text) {
    return NormalText(fontWeight: FontWeight.w600, color: COLORS.textSecondary, fontSize: 1.8, text: text);
  }

  Widget _rowDivider() {
    return Divider(color: COLORS.divider, height: 1, thickness: 1);
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: COLORS.surface,
      borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*4)),
      border: Border.all(color: COLORS.cardBorder),
      boxShadow: [
        BoxShadow(
          color: COLORS.shadow,
          blurRadius: 14,
          offset: const Offset(0, 6),
        ),
      ],
    );
  }
}

