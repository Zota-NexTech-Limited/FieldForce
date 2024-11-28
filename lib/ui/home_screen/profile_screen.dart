import 'package:fieldsales/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:fieldsales/components/dropdown_component/not_editable_dropdown.dart';
import 'package:fieldsales/components/text_component/normal_text.dart';
import 'package:fieldsales/components/text_form_field_component/not_editable_text_form_field.dart';
import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/config.dart';
import 'package:fieldsales/helper/global_handler.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:flutter/material.dart';
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
    Scaffold(
      backgroundColor: COLORS.white,
      appBar:AppBar(backgroundColor: COLORS.appBarColor,
        titleSpacing: SizeConfig.blockWidth*1,
        leading: InkWell(
            onTap: (){

              Navigator.pop(context);
              FocusScope.of(context).unfocus();
            },
            child:  Icon(Icons.arrow_back_sharp,size: SizeConfig.blockHeight*3.6,color: COLORS.black,)),
        centerTitle: false,
        leadingWidth: SizeConfig.blockWidth*15,
        title: NormalText(fontWeight: FontWeight.w600, color: COLORS.black, fontSize: SizeConfig.blockHeight*2.5, text: "Profile") ,
      ) ,
      body: Container(
        width: SizeConfig.screenWidth,
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*3,vertical: SizeConfig.blockHeight*2),
        child: Column(
          children: [
            NotEditableTextFormComponent(text:Config.userName ,label: "Name",),
            SizedBox(height: SizeConfig.blockHeight*3,),
            NotEditableDropdownComponent(text: Config.userRole,label: "Role",),
            SizedBox(height: SizeConfig.blockHeight*3,),
            NotEditableDropdownComponent(text: Config.userDepartment,label: "Department"),
            SizedBox(height: SizeConfig.blockHeight*3,),
            NotEditableTextFormComponent(text:Config.userPhoneNumber ,label: "Mobile Number",),
            SizedBox(height: SizeConfig.blockHeight*3,),
            NotEditableTextFormComponent(text:Config.userPhoneNumber ,label: "Email",),
            Spacer(),
            SizedBox(
              width: SizeConfig.screenWidth,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(COLORS.red),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*0))))
                  ),
                  onPressed: (){
                    GlobalBlocClass.authenticationBloc!.add(AuthenticationLogoutEvent());
                  }, child: NormalText(color:COLORS.white ,fontSize: SizeConfig.blockHeight*2,fontWeight: FontWeight.w600,text: "LOG OUT",)
              ),
            )
          ],
        ),

      ),
    ));
  }
}
