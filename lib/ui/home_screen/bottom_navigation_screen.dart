import 'package:fieldsales/bloc/get_activity_list/activity_list_bloc.dart';
import 'package:fieldsales/bloc/reset_password/reset_password_bloc.dart';
import 'package:fieldsales/components/svg_image_component.dart';
import 'package:fieldsales/components/text_component/normal_text.dart';
import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/config.dart';
import 'package:fieldsales/helper/reuse_functions/upper_camel_case.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:fieldsales/ui/crm/crm_screen.dart';
import 'package:fieldsales/ui/home_screen/menu_screen.dart';
import 'package:fieldsales/ui/home_screen/profile_screen.dart';
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
    final String currentTitle = _selectedIndex == 0
        ? "CRM"
        : _selectedIndex == 1
            ? "My Activity"
            : _selectedIndex == 2
                ? "Reports"
                : "Menu";
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        //drawer:const DrawerScreen(),
        backgroundColor: COLORS.scaffoldBg,
        appBar: PreferredSize(
          preferredSize: Size(SizeConfig.screenWidth, SizeConfig.blockHeight * 12),
          child: Container(
            width: SizeConfig.screenWidth,
            decoration: BoxDecoration(
              color: COLORS.surface,
              border: Border(bottom: BorderSide(color: COLORS.divider, width: 1)),
              boxShadow: [
                BoxShadow(
                  color: COLORS.shadow,
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockWidth * 4,
              vertical: SizeConfig.blockHeight * 1.6,
            ),
            child: Row(
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 3),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => BlocProvider(create: (context) => ResetPasswordBloc(), child: const ProfileScreen(),)));

                    //_scaffoldKey.currentState!.openDrawer();
                    print("open drawer-----------------------------------");
                  },
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [COLORS.primaryColor, COLORS.primaryDark],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: COLORS.primaryColor.withOpacity(0.25),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: SizeConfig.blockWidth * 4.6,
                          backgroundColor: Colors.transparent,
                          child: NormalText(
                            color: COLORS.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 2.7,
                            text: Config.userName[0].toUpperCase(),
                          ),
                        ),
                      ),
                      SizedBox(width: SizeConfig.blockWidth * 3),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          NormalText(
                            fontWeight: FontWeight.w500,
                            color: COLORS.textTertiary,
                            fontSize: 1.5,
                            text: "Welcome back",
                          ),
                          SizedBox(height: SizeConfig.blockHeight * 0.2),
                          NormalText(
                            fontWeight: FontWeight.w700,
                            color: COLORS.textPrimary,
                            fontSize: 2.5,
                            text: currentTitle,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                _appBarAction(asset: "assets/image/svg_icons/notification.svg"),
                SizedBox(width: SizeConfig.blockWidth * 3),
                _appBarAction(asset: "assets/image/svg_icons/settings_icon.svg"),
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
        ),
        body: SizedBox(
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            switchInCurve: Curves.easeOutCubic,
            switchOutCurve: Curves.easeInCubic,
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.03),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
              );
            },
            layoutBuilder: (currentChild, previousChildren) => Stack(
              alignment: Alignment.topCenter,
              children: [
                ...previousChildren,
                if (currentChild != null) currentChild,
              ],
            ),
            child: KeyedSubtree(
              key: ValueKey<int>(_selectedIndex),
              child: _widgetOptions[_selectedIndex],
            ),
          ),
        ),
        bottomNavigationBar: _buildBottomBar(),
      ),
    );
  }

  Widget _appBarAction({required String asset}) {
    return Container(
      height: SizeConfig.blockWidth * 10,
      width: SizeConfig.blockWidth * 10,
      padding: EdgeInsets.all(SizeConfig.blockWidth * 2.4),
      decoration: BoxDecoration(
        color: COLORS.surfaceVariant,
        borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 3),
        border: Border.all(color: COLORS.cardBorder, width: 1),
      ),
      child: SvgImageHelper(image: asset),
    );
  }

  // ---------------------------------------------------------------------------
  // Modern custom bottom navigation bar.
  //
  // Built from scratch (instead of BottomNavigationBar) so each item sizes to
  // its content and never overflows. Same destinations, order and tap logic.
  // ---------------------------------------------------------------------------
  static const List<_NavDest> _destinations = <_NavDest>[
    _NavDest(icon: 'assets/image/svg_icons/home_icon2.svg', label: 'Home'),
    _NavDest(icon: 'assets/image/svg_icons/dashboard_icon.svg', label: 'Activity'),
    _NavDest(icon: 'assets/image/svg_icons/reports_icon.svg', label: 'Reports'),
    _NavDest(icon: 'assets/image/svg_icons/menu_icon.svg', label: 'Menu'),
  ];

  Widget _buildBottomBar() {
    // Floating, detached pill-style navigation bar.
    return SafeArea(
      top: false,
      child: Container(
        margin: EdgeInsets.only(
          left: SizeConfig.blockWidth * 4,
          right: SizeConfig.blockWidth * 4,
          bottom: SizeConfig.blockHeight * 1.4,
          top: SizeConfig.blockHeight * 0.4,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.blockWidth * 2,
          vertical: SizeConfig.blockHeight * 0.7,
        ),
        decoration: BoxDecoration(
          color: COLORS.surface,
          borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 9),
          border: Border.all(color: COLORS.divider, width: 1),
          boxShadow: [
            BoxShadow(
              color: COLORS.primaryColor.withOpacity(0.10),
              blurRadius: 24,
              offset: const Offset(0, 10),
            ),
            BoxShadow(
              color: COLORS.shadow,
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            _destinations.length,
            (index) => Expanded(child: _navItem(index)),
          ),
        ),
      ),
    );
  }

  Widget _navItem(int index) {
    final _NavDest dest = _destinations[index];
    final bool isSelected = _selectedIndex == index;

    return InkWell(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 4),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: SizeConfig.blockHeight * 0.6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutBack,
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockWidth * 4,
                vertical: SizeConfig.blockHeight * 0.6,
              ),
              decoration: BoxDecoration(
                color: isSelected ? COLORS.primarySoft : Colors.transparent,
                borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 6),
              ),
              child: AnimatedScale(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutBack,
                scale: isSelected ? 1.08 : 1.0,
                child: TweenAnimationBuilder<Color?>(
                  duration: const Duration(milliseconds: 280),
                  tween: ColorTween(
                    end: isSelected ? COLORS.primaryColor : COLORS.textTertiary,
                  ),
                  builder: (context, color, _) => SvgPicture.asset(
                    dest.icon,
                    width: SizeConfig.blockWidth * 4.4,
                    height: SizeConfig.blockWidth * 4.4,
                    colorFilter: ColorFilter.mode(
                      color ?? COLORS.textTertiary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: SizeConfig.blockHeight * 0.4),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 280),
              curve: Curves.easeOut,
              style: TextStyle(
                fontFamily: Config.fountFamilyPrimary,
                fontSize: 10.5,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? COLORS.primaryColor : COLORS.textTertiary,
              ),
              child: Text(
                dest.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavDest {
  final String icon;
  final String label;
  const _NavDest({required this.icon, required this.label});
}
