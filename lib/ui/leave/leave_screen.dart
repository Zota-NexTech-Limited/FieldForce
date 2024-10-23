import 'dart:collection';
//import 'package:fieldsales/bloc/get_activity_list/activity_list_bloc.dart';
import 'package:fieldsales/bloc/add_leave_bloc/add_leave_bloc.dart';
import 'package:fieldsales/bloc/create_activity_bloc/create_activity_bloc.dart';
import 'package:fieldsales/bloc/leave_list_bloc/leave_list_bloc.dart';
import 'package:fieldsales/components/button_component/add_new_button.dart';
import 'package:fieldsales/components/state_management_components/empty_screen_component.dart';
import 'package:fieldsales/components/state_management_components/error_screen.dart';
import 'package:fieldsales/components/state_management_components/loading_screen.dart';
import 'package:fieldsales/components/text_component/normal_text.dart';
import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/config.dart';
import 'package:fieldsales/helper/date_converter.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:fieldsales/models/leave/leave_model.dart';
import 'package:fieldsales/ui/leave/add_leave_screen.dart';
//import 'package:fieldsales/models/my_activity_models/activiti_list_model.dart';
import 'package:fieldsales/ui/my_activity/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

class LeaveScreen extends StatefulWidget {
  const LeaveScreen({super.key});

  @override
  State<LeaveScreen> createState() => _LeaveScreenState();
}

class _LeaveScreenState extends State<LeaveScreen> {

  late final ValueNotifier<List<Leave>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  bool isSelectedEventsInitialized=false;

  late LinkedHashMap<DateTime, List<Leave>> kEvents;
  late LeaveListBloc leaveListBloc;
  @override
  void initState() {
    super.initState();

    leaveListBloc=BlocProvider.of<LeaveListBloc>(context);

  }


  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Leave> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  List<Leave> _getEventsForRange(DateTime start, DateTime end) {
    // Implementation example
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocBuilder<LeaveListBloc,LeaveListState>(
          builder: (context, state) {
            if(state is LeaveListLoadingState)
            {
              return LoadingScreen();
            } else if(state is LeaveListSuccessState)
            {


              List<Leave> todayActivityList=[];
              DateTime now = DateTime.now();
              String _twoDigits(int n) {
                if (n >= 10) {
                  return '$n';
                }
                return '0$n';
              }
              String formattedDate = '${now.year}-${_twoDigits(now.month)}-${_twoDigits(now.day)}';
              for(LeaveModel item in state.leaveList)
              {
                if(item.date==formattedDate)
                {
                  todayActivityList=item.leave!;
                }
              }
              // Print the formatted date
              print('Formatted Date: $formattedDate');

              final _kEventSource = Map.fromIterable(
                  List.generate(state.leaveList.length, (index) => index),
                  key: (item) => DateTime.parse(state.leaveList[item].date.toString()),
                  value: (item) => List.generate(
                      state.leaveList[item].leave!.length, (index) =>state.leaveList[item].leave![index]
                  )
              )
                ..addAll({
                  kToday: todayActivityList,
                });
              kEvents =LinkedHashMap<DateTime, List<Leave>>(
                equals: isSameDay,
                hashCode: getHashCode,
              )..addAll(_kEventSource);

              if(isSelectedEventsInitialized==false)
              {
                _selectedDay = _focusedDay;
                _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
              }
              isSelectedEventsInitialized=true;
              return  Scaffold(
                /*appBar:AppBar(backgroundColor: COLORS.blue,
              leading: InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.arrow_back_ios_new,color: COLORS.white,)),
              title:const NormalText(fontWeight: FontWeight.w400, color: COLORS.white, fontSize: 3.3, text: "My Activity") ,
            ),*/
                appBar: PreferredSize(preferredSize: Size(SizeConfig.screenWidth, SizeConfig.blockHeight*13), child: Container(
                  width: SizeConfig.screenWidth,
                  color: COLORS.skyBlue,
                  child: Container(
                    //margin: EdgeInsets.only(bottom:SizeConfig.blockHeight*3),
                    color: COLORS.lightBlue,
                    padding: EdgeInsets.all(SizeConfig.blockHeight*2),
                    child: Row(
                      children: [
                        InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.arrow_back)),
                        SizedBox(width: SizeConfig.blockWidth*5,),
                        NormalText(fontWeight: FontWeight.w700, color: COLORS.black, fontSize: 2.7, text:"Leave"),



                      ],
                    ),
                  ),
                )),
                body: Container(
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight,
                  color: COLORS.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TableCalendar<Leave>(
                        firstDay: kFirstDay,
                        lastDay: kLastDay,
                        focusedDay: _focusedDay,
                        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                        rangeStartDay: _rangeStart,
                        rangeEndDay: _rangeEnd,
                        calendarFormat: _calendarFormat,
                        rangeSelectionMode: _rangeSelectionMode,
                        eventLoader: _getEventsForDay,
                        startingDayOfWeek: StartingDayOfWeek.monday,
                        ///header style of cakender
                        headerStyle:  HeaderStyle(
                          formatButtonVisible: false,
                          titleCentered: true,
                          titleTextStyle: TextStyle(fontSize: SizeConfig.blockHeight*2.8,color:COLORS.blueDark,fontFamily: Config.fountFamilyPrimary,fontWeight:FontWeight.w500),
                          decoration: const BoxDecoration(color: COLORS.white,),
                          rightChevronIcon:  Container(
                              padding: EdgeInsets.all(SizeConfig.blockWidth*1),
                              decoration: BoxDecoration(
                                  border: Border.all(color: COLORS.blueExtraLight),
                                  borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*2))
                              ),
                              child: Icon(Icons.arrow_forward_ios,color:COLORS.blueDark,size: SizeConfig.blockHeight*2.5,)),
                          leftChevronIcon: Container(
                              padding: EdgeInsets.all(SizeConfig.blockWidth*1),
                              decoration: BoxDecoration(
                                  border: Border.all(color: COLORS.blueExtraLight),
                                  borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*2))
                              ),
                              child: Icon(Icons.arrow_back_ios_new,color:COLORS.blueDark,size: SizeConfig.blockHeight*2.5,)),

                        ),
                        calendarStyle: CalendarStyle(
                          outsideDaysVisible: false,
                          defaultTextStyle:   textStyleComponent,//all exept sat and sunday
                          weekendTextStyle:textStyleComponent,//weelkend text style
                          selectedDecoration: const BoxDecoration(color:COLORS.blue,shape:BoxShape.circle),//decoration of selected date
                          todayDecoration:BoxDecoration(color:COLORS.blue.withOpacity(0.4),shape:BoxShape.circle ),
                          markerDecoration: const BoxDecoration(color: COLORS.blueExtraDark,borderRadius: BorderRadius.all(Radius.circular(10))),//event show


                          //  weekNumberTextStyle: const TextStyle(color: Colors.red),
                          //  disabledTextStyle: const TextStyle(color: Colors.blue),//which not in range
                          // holidayTextStyle: const TextStyle(color: Colors.green),
                          //  outsideTextStyle:const TextStyle(color: Colors.brown),
                          //  withinRangeTextStyle: const TextStyle(color: Colors.red),
                        ),
                        onDaySelected: _onDaySelected,
                        onRangeSelected: _onRangeSelected,
                        onFormatChanged: (format) {
                          if (_calendarFormat != format) {
                            setState(() {
                              _calendarFormat = format;
                            });
                          }
                        },
                        onPageChanged: (focusedDay) {
                          _focusedDay = focusedDay;
                        },

                      ),
                      const SizedBox(height: 8.0),
                      Expanded(
                        child: ValueListenableBuilder<List<Leave>>(
                          valueListenable: _selectedEvents,
                          builder: (context, value, _) {
                            return value.length==0?SingleChildScrollView(child: EmptyScreen(text: "Activity Not Found!",distanceFromTop: 10)): Container(
                              color: COLORS.skyBlue,
                              child: ListView.builder(
                                itemCount: value.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin:  EdgeInsets.symmetric(
                                      horizontal: SizeConfig.blockWidth*2,
                                      vertical: SizeConfig.blockHeight*1,
                                    ),
                                    padding:  EdgeInsets.symmetric(
                                      horizontal: SizeConfig.blockWidth*2,
                                      vertical: SizeConfig.blockHeight*2,
                                    ),
                                    decoration: BoxDecoration(
                                      /*boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        spreadRadius: 0.1,
                                        blurRadius: 4,
                                        offset: Offset(0, 1),
                                      ),
                                    ],*/
                                        color: COLORS.white,
                                        borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*1.8))
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            //NormalText(fontWeight: FontWeight.w600, color: COLORS.black, fontSize: 2, text: "${value[index]}"),
                                            NormalText(fontWeight: FontWeight.w600, color: COLORS.black, fontSize: 2, text: value[index].leaveType!),
                                            subTitleText(text: "Description"),
                                            NormalText(fontWeight: FontWeight.w600, color: COLORS.black, fontSize: 1.8, text: value[index].description!),


                                          ],
                                        ),

                                        Column(
                                          children: [
                                            subTitleText(text:DateFormetConvertHelper(date: value[index].createdDate!.toString()) ),
                                            SizedBox(height: SizeConfig.blockHeight*1,),
                                            SizedBox(
                                              width: SizeConfig.blockWidth*18,
                                              height:SizeConfig.blockHeight*3.5,
                                              child:  ElevatedButton(
                                                child: NormalText(fontWeight: FontWeight.w500, color: COLORS.black, fontSize:1.3, text: "To Submit") ,
                                                style: ButtonStyle(

                                                    elevation: WidgetStatePropertyAll(0),
                                                    padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*1),),
                                                    backgroundColor: MaterialStatePropertyAll(COLORS.green.withOpacity(.3)),
                                                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*2)))),
                                                    side: WidgetStatePropertyAll(BorderSide(color: COLORS.green))
                                                ),
                                                onPressed: (){},
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),

                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                bottomNavigationBar: Container(
                  color: COLORS.skyBlue,
                  height: SizeConfig.blockHeight*8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AddNewButton(title: "Add Leave", onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> BlocProvider(create: (context)=>AddLeaveBloc(),child:const AddLeaveScreen(),)));
                      }),
                    ],
                  ),
                ),
              );


            }else if(state is LeaveListFailedState)
            {

              return ErrorScreen(onPressed: (){});
            }

            return  Container();
          },

        )


    );
  }

  TextStyle textStyleComponent=TextStyle(fontSize: SizeConfig.blockHeight*2,color:COLORS.black,fontFamily: Config.fountFamilyPrimary,fontWeight:FontWeight.w500);
  Widget subTitleText({required String text}){
    return  NormalText(fontWeight: FontWeight.w400, color: COLORS.black, fontSize: 1.6, text: text);
  }
}

