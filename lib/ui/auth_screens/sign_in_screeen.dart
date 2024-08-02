import 'package:fieldforce/bloc/login_bloc/login_bloc.dart';
import 'package:fieldforce/components/button_component/auth_screen_button.dart';
import 'package:fieldforce/components/svg_image_component.dart';
import 'package:fieldforce/components/text_component/auth_screen_inputfield_title_text.dart';
import 'package:fieldforce/components/text_component/auth_screen_subtitle_text.dart';
import 'package:fieldforce/components/text_component/auth_screens_title_text.dart';
import 'package:fieldforce/components/text_component/normal_text.dart';
import 'package:fieldforce/components/text_form_field_component/normal_textform_field.dart';
import 'package:fieldforce/components/text_form_field_component/password_text_form_field.dart';
import 'package:fieldforce/helper/colors.dart';
import 'package:fieldforce/helper/global_handler.dart';
import 'package:fieldforce/helper/size_config.dart';
import 'package:fieldforce/ui/auth_screens/host_url_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/authentication_bloc/authentication_bloc.dart';
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  bool selectedValue=false;
  bool isLoding=false;
  late LoginBloc loginBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginBloc=BlocProvider.of<LoginBloc>(context);
  }
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocListener<LoginBloc,LoginState>(
        listener: (context, state) {
          if(state is LoginWithEmailLoadingState)
            {
              setState(() {
                isLoding=true;
              });
            }else if(state is LoginWithEmailSuccessState)
              {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
                GlobalBlocClass.authenticationBloc!.add(const AuthenticationHomeScreenRedirectEvent());
                setState(() {
                  isLoding=false;
                });
              }else if(state is LoginWithEmailFailedState)
                {
                  final snackBar = SnackBar(content: Text(state.message));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  setState(() {
                    isLoding=false;
                  });
                }
          setState(() {

          });
        },child: SafeArea(
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
                      AuthScreenTitleText(text: "Sign In",),
                      SizedBox(height: SizeConfig.blockHeight*1,),
                      AuthScreenSubTitleText(text:"Welcome back! Please enter your details." ,),
                      SizedBox(height: SizeConfig.blockHeight*3,),
                      Align(
                          alignment: Alignment.topLeft,
                          child: AuthScreenInputFieldTitleText(text:"Email or phone number" ,)),
                      SizedBox(height: SizeConfig.blockHeight*1,),
                      Container(
                        width: SizeConfig.screenWidth,

                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*2))
                        ),
                        child:NormalTextFormField(
                          hintText:"Enter your email" ,
                          onChanged: (value){

                          },
                          inputType: TextInputType.emailAddress,
                          readOnly: false,
                          controller:emailController ,
                          validator:(String? value) {
                            String pattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                            RegExp regex = RegExp(pattern);
                            if (value!.trim().isEmpty) {
                              return 'Email is Empty';
                            } else if (!regex.hasMatch(value)) {
                              return 'Email is not valid';
                            }
                            return null;
                          },
                        ) ,
                      ),
                      SizedBox(height: SizeConfig.blockHeight*3,),
                      Align(
                          alignment: Alignment.topLeft,
                          child: AuthScreenInputFieldTitleText(text:"Password" ,)),
                      SizedBox(height: SizeConfig.blockHeight*1,),
                      Container(
                        width: SizeConfig.screenWidth,
                        margin:EdgeInsets.only(bottom: SizeConfig.blockHeight*2) ,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*2))
                        ),
                        child:PassWordTextFormField(
                          // isHideInput: true,
                          hintText:"Enter your password" ,
                          onChanged: (value){

                          },
                          inputType: TextInputType.visiblePassword,
                          isReadOnly: false,
                          controller:passwordController ,
                          validator:(String? value) {
                            //String pattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                            //RegExp regex = RegExp(pattern);
                            if (value!.trim().isEmpty) {
                              return 'password is Empty';
                            } else if (value.length<8) {
                              return 'password is not valid';
                            }
                            return null;
                          },
                        ) ,
                      ),
                      Row(
                        children: [
                         /* Checkbox(
                            value:selectedValue ,
                            onChanged: (value)
                            {
                              setState(() {
                                selectedValue=value!;
                              });
                            },
                            visualDensity:const VisualDensity(horizontal:-3),
                            activeColor: COLORS.darkBlue,
                            side: BorderSide(color: COLORS.gray.withOpacity(0.6),width: SizeConfig.blockWidth*0.3),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*1))),
                          ) ,*/
                          InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>HostUrlScreen()));
                              },
                              child: NormalText(fontWeight: FontWeight.w600, color: COLORS.black, fontSize: 2, text: "Update Host URL")),
                          Spacer(),
                          InkWell(
                              onTap: (){
                              //  Navigator.push(context, MaterialPageRoute(builder: (context)=>BlocProvider(create: (context)=>ResetPasswordBloc(),child:const ForgotPasswordScreen(),)));
                              },
                              child: NormalText(fontWeight: FontWeight.w600, color: COLORS.black, fontSize:2.2, text: "Forgot password?")),
                        ],
                      ),
                      SizedBox(
                        height: SizeConfig.blockHeight*4,
                      ),
                      AuthScreenButton(
                        isLoding: isLoding,
                        onPressed: (){
                          if(_formKey.currentState!.validate())
                          {
                            String email=emailController.text.toLowerCase();
                            print("email---------------------------------$email");
                            loginBloc.add(LoginWithEmailEvent(email: email, password: passwordController.text));
                          }

                        },
                        text: "Sign in",
                      )
                    ],
                  )

                ],
              ),
            ),
          ),
        )),);
  }
}
