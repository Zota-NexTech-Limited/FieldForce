import 'dart:async';
import 'package:fieldsales/components/svg_image_component.dart';
import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:fieldsales/ui/auth_screens/authentication_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/authentication_bloc/authentication_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );
    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );
    _animationController.forward();

    if (context != null) {
      Timer(const Duration(seconds: 1), () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => BlocProvider(
            create: (context) => AuthenticationBloc()..add(const InitializeApp()),
            child: const Authentication(),
          ),
        ));
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final double logoSize = SizeConfig.blockWidth * 36;

    return Scaffold(
      backgroundColor: COLORS.backgroundColor,
      body: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              COLORS.primarySoft,
              COLORS.backgroundColor,
              COLORS.surface,
            ],
            stops: const [0.0, 0.55, 1.0],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Center(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: logoSize,
                          height: logoSize,
                          padding: EdgeInsets.all(SizeConfig.blockWidth * 6),
                          decoration: BoxDecoration(
                            color: COLORS.white,
                            borderRadius: BorderRadius.circular(28),
                            border: Border.all(color: COLORS.cardBorder),
                            boxShadow: [
                              BoxShadow(
                                color: COLORS.shadow,
                                blurRadius: 24,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: SvgImageHelper(
                              image: "assets/image/common/nextech_logo.svg",
                            ),
                          ),
                        ),
                        SizedBox(height: SizeConfig.blockHeight * 3.5),
                        Text(
                          "Field Sales",
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: SizeConfig.blockWidth * 6.5,
                            fontWeight: FontWeight.w700,
                            color: COLORS.textPrimary,
                            letterSpacing: 0.2,
                          ),
                        ),
                        SizedBox(height: SizeConfig.blockHeight * 1),
                        Text(
                          "Smarter selling, every visit",
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: SizeConfig.blockWidth * 3.6,
                            fontWeight: FontWeight.w500,
                            color: COLORS.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: SizeConfig.blockHeight * 6,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    children: [
                      SizedBox(
                        width: SizeConfig.blockWidth * 7,
                        height: SizeConfig.blockWidth * 7,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.6,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            COLORS.primaryColor,
                          ),
                        ),
                      ),
                      SizedBox(height: SizeConfig.blockHeight * 2),
                      Text(
                        "Powered by Nextech",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: SizeConfig.blockWidth * 3.2,
                          fontWeight: FontWeight.w500,
                          color: COLORS.textTertiary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
