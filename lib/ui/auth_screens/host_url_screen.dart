import 'package:fieldforce/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:fieldforce/components/button_component/auth_screen_button.dart';
import 'package:fieldforce/components/svg_image_component.dart';
import 'package:fieldforce/components/text_component/auth_screen_inputfield_title_text.dart';
import 'package:fieldforce/components/text_form_field_component/normal_textform_field.dart';
import 'package:fieldforce/helper/colors.dart';
import 'package:fieldforce/helper/config.dart';
import 'package:fieldforce/helper/global_handler.dart';
import 'package:fieldforce/helper/local_constant.dart';
import 'package:fieldforce/helper/size_config.dart';
import 'package:fieldforce/ui/auth_screens/authentication_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HostUrlScreen extends StatefulWidget {
  const HostUrlScreen({super.key});

  @override
  State<HostUrlScreen> createState() => _HostUrlScreenState();
}

class _HostUrlScreenState extends State<HostUrlScreen> {
  TextEditingController urlController=TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(Config.hostUrl.isNotEmpty)
      {
        urlController.text=Config.hostUrl;
      }
  }
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: COLORS.white,
          body:Form(
            key: _formKey,
            child: Container(
              height: SizeConfig.screenHeight,
              width: SizeConfig.screenWidth,
              padding: EdgeInsets.symmetric(horizontal:SizeConfig.blockHeight*4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SvgImageHelper(image: "assets/image/svg_icons/logo.svg"),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     AuthScreenInputFieldTitleText(text: "Enter Host OR Server URL",),
                      SizedBox(height: SizeConfig.blockHeight*2,),
                      Container(
                        width: SizeConfig.screenWidth,

                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*2))
                        ),
                        child:NormalTextFormField(
                          hintText:"Enter Host Url" ,
                          onChanged: (value){

                          },
                          inputType: TextInputType.emailAddress,
                          readOnly: false,
                          controller:urlController ,
                          validator:(String? value) {
                            if (value!.trim().isEmpty) {
                              return 'Url should not be  Empty';
                            }
                            return null;
                          },
                        ) ,
                      ),

                      SizedBox(
                        height: SizeConfig.blockHeight*4,
                      ),
                      AuthScreenButton(
                        onPressed: (){
                          if(_formKey.currentState!.validate()){
                            setState(() {
                              storeToLocalStorage(LocalConstant.hostUrl, urlController.text);
                              Config.hostUrl=urlController.text.toLowerCase();
                              Config.url="https://${urlController.text.toLowerCase()}/api";
                              Navigator.pushAndRemoveUntil(
                                GlobalBlocClass.authenticationContext!,
                                MaterialPageRoute(
                                  builder: (context) => BlocProvider(create: (context) => AuthenticationBloc()..add(const InitializeApp()),
                                      child: const Authentication()),
                                ),
                                    (Route<dynamic> route) => false,
                              );
                            });
                          }
                        },
                        text: "Save",
                        isLoding: false,
                      ),

                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
