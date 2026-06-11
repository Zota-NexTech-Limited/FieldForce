import 'package:fieldsales/bloc/login_bloc/login_bloc.dart';
import 'package:fieldsales/components/button_component/auth_screen_button.dart';
import 'package:fieldsales/components/svg_image_component.dart';
import 'package:fieldsales/components/text_component/auth_screen_inputfield_title_text.dart';
import 'package:fieldsales/components/text_component/auth_screen_subtitle_text.dart';
import 'package:fieldsales/components/text_component/auth_screens_title_text.dart';
import 'package:fieldsales/components/text_component/normal_text.dart';
import 'package:fieldsales/components/text_form_field_component/normal_textform_field.dart';
import 'package:fieldsales/components/text_form_field_component/password_text_form_field.dart';
import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/global_handler.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:fieldsales/ui/auth_screens/host_url_screen.dart';
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
          backgroundColor: COLORS.scaffoldBg,
          body:Form(
            key: _formKey,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                constraints: BoxConstraints(
                  minHeight: SizeConfig.screenHeight,
                ),
                width: SizeConfig.screenWidth,
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.blockWidth * 6,
                  vertical: SizeConfig.blockHeight * 4,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: SizeConfig.blockHeight * 2),
                    Center(
                      child: Container(
                        padding: EdgeInsets.all(SizeConfig.blockWidth * 5),
                        decoration: BoxDecoration(
                          color: COLORS.primarySoft,
                          borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 6),
                        ),
                        child: SvgImageHelper(image: "assets/image/svg_icons/logo.svg"),
                      ),
                    ),
                    SizedBox(height: SizeConfig.blockHeight * 4),
                    Center(child: AuthScreenTitleText(text: "Sign In")),
                    SizedBox(height: SizeConfig.blockHeight * 1),
                    AuthScreenSubTitleText(text: "Welcome back! Please enter your details."),
                    SizedBox(height: SizeConfig.blockHeight * 4),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.blockWidth * 5,
                        vertical: SizeConfig.blockHeight * 3,
                      ),
                      decoration: BoxDecoration(
                        color: COLORS.surface,
                        borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 4.5),
                        border: Border.all(color: COLORS.cardBorder, width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: COLORS.shadow,
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Align(
                              alignment: Alignment.topLeft,
                              child: AuthScreenInputFieldTitleText(text: "Email or phone number")),
                          SizedBox(height: SizeConfig.blockHeight * 1),
                          NormalTextFormField(
                            hintText: "Enter your email",
                            onChanged: (value) {

                            },
                            inputType: TextInputType.emailAddress,
                            readOnly: false,
                            controller: emailController,
                            validator: (String? value) {
                              String pattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                              RegExp regex = RegExp(pattern);
                              if (value!.trim().isEmpty) {
                                return 'Email is Empty';
                              } else if (!regex.hasMatch(value)) {
                                return 'Email is not valid';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: SizeConfig.blockHeight * 2.5),
                          Align(
                              alignment: Alignment.topLeft,
                              child: AuthScreenInputFieldTitleText(text: "Password")),
                          SizedBox(height: SizeConfig.blockHeight * 1),
                          PassWordTextFormField(
                            // isHideInput: true,
                            hintText: "Enter your password",
                            onChanged: (value) {

                            },
                            inputType: TextInputType.visiblePassword,
                            isReadOnly: false,
                            controller: passwordController,
                            validator: (String? value) {
                              //String pattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                              //RegExp regex = RegExp(pattern);
                              if (value!.trim().isEmpty) {
                                return 'password is Empty';
                              } else if (value.length < 8) {
                                return 'password is not valid';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: SizeConfig.blockHeight * 1),
                          Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                                borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 2),
                                onTap: () {
                                  //  Navigator.push(context, MaterialPageRoute(builder: (context)=>BlocProvider(create: (context)=>ResetPasswordBloc(),child:const ForgotPasswordScreen(),)));
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: SizeConfig.blockHeight * 0.6,
                                    horizontal: SizeConfig.blockWidth * 1,
                                  ),
                                  child: NormalText(fontWeight: FontWeight.w600, color: COLORS.primaryColor, fontSize: 2, text: "Forgot password?"),
                                )),
                          ),
                          SizedBox(height: SizeConfig.blockHeight * 2.5),
                          AuthScreenButton(
                            isLoding: isLoding,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                String email = emailController.text.toLowerCase();
                                print("email---------------------------------$email");
                                loginBloc.add(LoginWithEmailEvent(email: email, password: passwordController.text));
                              }
                            },
                            text: "Sign in",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: SizeConfig.blockHeight * 3),
                    Center(
                      child: InkWell(
                          borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 3),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => HostUrlScreen()));
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: SizeConfig.blockHeight * 1,
                              horizontal: SizeConfig.blockWidth * 3,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.link_rounded, size: SizeConfig.blockHeight * 2.4, color: COLORS.textSecondary),
                                SizedBox(width: SizeConfig.blockWidth * 1.5),
                                NormalText(fontWeight: FontWeight.w600, color: COLORS.textSecondary, fontSize: 1.9, text: "Update Host URL"),
                              ],
                            ),
                          )),
                    ),
                    SizedBox(height: SizeConfig.blockHeight * 2),
                  ],
                ),
              ),
            ),
          ),
        )),);
  }
}
