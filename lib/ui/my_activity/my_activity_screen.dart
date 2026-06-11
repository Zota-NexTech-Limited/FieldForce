import 'dart:collection';
import 'package:fieldsales/bloc/get_activity_list/activity_list_bloc.dart';
import 'package:fieldsales/components/state_management_components/empty_screen_component.dart';
import 'package:fieldsales/components/state_management_components/error_screen.dart';
import 'package:fieldsales/components/state_management_components/loading_screen.dart';
import 'package:fieldsales/components/text_component/normal_text.dart';
import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/config.dart';
import 'package:fieldsales/helper/date_converter.dart';
import 'package:fieldsales/helper/reuse_functions/upper_camel_case.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:fieldsales/models/my_activity_models/activiti_list_model.dart';
import 'package:fieldsales/ui/my_activity/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

class MyActivityScreen extends StatefulWidget {
  const MyActivityScreen({super.key});

  @override
  State<MyActivityScreen> createState() => _MyActivityScreenState();
}

class _MyActivityScreenState extends State<MyActivityScreen> {

  late final ValueNotifier<List<Activity>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
bool isSelectedEventsInitialized=false;

  late LinkedHashMap<DateTime, List<Activity>> kEvents;
  late ActivityListBloc activityListBloc;
  @override
  void initState() {
    super.initState();

    activityListBloc=BlocProvider.of<ActivityListBloc>(context);

  }


  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Activity> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  List<Activity> _getEventsForRange(DateTime start, DateTime end) {
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
      child: BlocBuilder<ActivityListBloc,ActivityListState>(
        builder: (context, state) {
        if(state is ActivityListLoadingState)
          {
            return LoadingScreen();
          } else if(state is ActivityListSuccessState)
        {


          List<Activity> todayActivityList=[];
          DateTime now = DateTime.now();
          String _twoDigits(int n) {
            if (n >= 10) {
              return '$n';
            }
            return '0$n';
          }
          String formattedDate = '${now.year}-${_twoDigits(now.month)}-${_twoDigits(now.day)}';
          for(ActivityListModel item in state.activityList)
            {
              if(item.date==formattedDate)
                {
                  todayActivityList=item.activity!;
                }
            }
          // Print the formatted date
          print('Formatted Date: $formattedDate');

          final _kEventSource = Map.fromIterable(
              List.generate(state.activityList.length, (index) => index),
              key: (item) => DateTime.parse(state.activityList[item].date.toString()),
              value: (item) => List.generate(
                  state.activityList[item].activity!.length, (index) =>state.activityList[item].activity![index]
              )
          )
            ..addAll({
              kToday: todayActivityList,
            });
           kEvents =LinkedHashMap<DateTime, List<Activity>>(
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
            body: Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight,
              color: COLORS.backgroundColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(
                      SizeConfig.blockWidth * 3,
                      SizeConfig.blockHeight * 1.5,
                      SizeConfig.blockWidth * 3,
                      SizeConfig.blockHeight * 0.5,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.blockWidth * 2,
                      vertical: SizeConfig.blockHeight * 1,
                    ),
                    decoration: BoxDecoration(
                      color: COLORS.white,
                      borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 4.5),
                      border: Border.all(color: COLORS.cardBorder),
                      boxShadow: const [
                        BoxShadow(
                          color: COLORS.shadow,
                          blurRadius: 14,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    child: TableCalendar<Activity>(
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
                        titleTextStyle: TextStyle(fontSize: SizeConfig.blockHeight*2.6,color:COLORS.textPrimary,fontFamily: Config.fountFamilyPrimary,fontWeight:FontWeight.w700),
                        decoration: const BoxDecoration(color: COLORS.white,),
                        rightChevronIcon:  Container(
                          padding: EdgeInsets.all(SizeConfig.blockWidth*1.6),
                            decoration: BoxDecoration(
                              color: COLORS.primarySoft,
                              borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*3))
                            ),
                            child: Icon(Icons.arrow_forward_ios,color:COLORS.primaryColor,size: SizeConfig.blockHeight*2,)),
                        leftChevronIcon: Container(
                            padding: EdgeInsets.all(SizeConfig.blockWidth*1.6),
                            decoration: BoxDecoration(
                                color: COLORS.primarySoft,
                                borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*3))
                            ),
                            child: Icon(Icons.arrow_back_ios_new,color:COLORS.primaryColor,size: SizeConfig.blockHeight*2,)),

                      ),
                      daysOfWeekStyle: DaysOfWeekStyle(
                        weekdayStyle: TextStyle(fontSize: SizeConfig.blockHeight*1.6,color:COLORS.textTertiary,fontFamily: Config.fountFamilyPrimary,fontWeight:FontWeight.w600),
                        weekendStyle: TextStyle(fontSize: SizeConfig.blockHeight*1.6,color:COLORS.textTertiary,fontFamily: Config.fountFamilyPrimary,fontWeight:FontWeight.w600),
                      ),
                      calendarStyle: CalendarStyle(
                        outsideDaysVisible: false,
                        defaultTextStyle:   textStyleComponent,//all exept sat and sunday
                        weekendTextStyle:textStyleComponent,//weelkend text style
                        selectedTextStyle: TextStyle(fontSize: SizeConfig.blockHeight*2,color:COLORS.onPrimaryColor,fontFamily: Config.fountFamilyPrimary,fontWeight:FontWeight.w700),
                        selectedDecoration:  BoxDecoration(color:COLORS.primaryColor,shape:BoxShape.circle),//decoration of selected date
                        todayTextStyle: TextStyle(fontSize: SizeConfig.blockHeight*2,color:COLORS.primaryColor,fontFamily: Config.fountFamilyPrimary,fontWeight:FontWeight.w700),
                        todayDecoration:BoxDecoration(color:COLORS.primarySoft,shape:BoxShape.circle ),
                        markerDecoration:  BoxDecoration(color: COLORS.primaryColor,shape:BoxShape.circle),//event show


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
                  ),
                  const SizedBox(height: 8.0),
                  Expanded(
                    child: ValueListenableBuilder<List<Activity>>(
                      valueListenable: _selectedEvents,
                      builder: (context, value, _) {
                        return value.length==0?SingleChildScrollView(child: EmptyScreen(text: "Activity Not Found!",distanceFromTop: 0)): Container(
                          color: COLORS.backgroundColor,
                          child: ListView.builder(
                            itemCount: value.length,
                            padding: EdgeInsets.fromLTRB(
                              SizeConfig.blockWidth * 3,
                              SizeConfig.blockHeight * 1,
                              SizeConfig.blockWidth * 3,
                              SizeConfig.blockHeight * 2,
                            ),
                            itemBuilder: (context, index) {
                              return Container(
                                margin:  EdgeInsets.only(
                                  bottom: SizeConfig.blockHeight*1.5,
                                ),
                                padding:  EdgeInsets.all(SizeConfig.blockWidth*3.5),
                                decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                        color: COLORS.shadow,
                                        blurRadius: 12,
                                        offset: Offset(0, 6),
                                      ),
                                    ],
                                    border: Border.all(color: COLORS.cardBorder),
                                    color: COLORS.white,
                                    borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*4))
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(SizeConfig.blockWidth*2.4),
                                      decoration: BoxDecoration(
                                        color: COLORS.primarySoft,
                                        borderRadius: BorderRadius.circular(SizeConfig.blockWidth*3),
                                      ),
                                      child: Icon(
                                        Icons.event_note_rounded,
                                        color: COLORS.primaryColor,
                                        size: SizeConfig.blockHeight*2.6,
                                      ),
                                    ),
                                    SizedBox(width: SizeConfig.blockWidth*3),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          NormalText(fontWeight: FontWeight.w700, color: COLORS.textPrimary, fontSize: 2, text: toUpperCamelCase(value[index].activityName!)),
                                          SizedBox(height: SizeConfig.blockHeight*0.6),
                                          subTitleText(text: "Description"),
                                          SizedBox(height: SizeConfig.blockHeight*0.3),
                                          NormalText(fontWeight: FontWeight.w500, color: COLORS.textSecondary, fontSize: 1.8, text: value[index].activitySummary!),
                                          SizedBox(height: SizeConfig.blockHeight*1.4),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.access_time_rounded,
                                                color: COLORS.textTertiary,
                                                size: SizeConfig.blockHeight*1.8,
                                              ),
                                              SizedBox(width: SizeConfig.blockWidth*1.2),
                                              NormalText(fontWeight: FontWeight.w500, color: COLORS.textTertiary, fontSize: 1.5, text: DateFormetConvertHelper(date: value[index].updateDate!)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: SizeConfig.blockWidth*2),
                                    SizedBox(
                                      height:SizeConfig.blockHeight*4,
                                      child:  ElevatedButton(
                                        child: NormalText(fontWeight: FontWeight.w600, color: COLORS.success, fontSize:1.4, text: "To Submit") ,
                                        style: ButtonStyle(
                                            elevation: WidgetStatePropertyAll(0),
                                            padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*3),),
                                            backgroundColor: MaterialStatePropertyAll(COLORS.successSoft),
                                            shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*3.5)))),
                                            side: WidgetStatePropertyAll(BorderSide.none)
                                        ),
                                        onPressed: (){},
                                      ),
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
          );


        }else if(state is ActivityListLoadingState)
        {

            return ErrorScreen(onPressed: (){});
        }

        return  Container();
      },

      )


    );
  }

  TextStyle textStyleComponent=TextStyle(fontSize: SizeConfig.blockHeight*2,color:COLORS.textColor,fontFamily: Config.fountFamilyPrimary,fontWeight:FontWeight.w500);
  Widget subTitleText({required String text}){
    return  NormalText(fontWeight: FontWeight.w400, color: COLORS.textColor, fontSize: 1.6, text: text);
  }
}

