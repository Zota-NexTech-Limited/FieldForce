import 'dart:collection';

import 'package:fieldsales/bloc/add_expense/add_expense_bloc.dart';
import 'package:fieldsales/bloc/expense_list_bloc/expense_list_bloc.dart';
import 'package:fieldsales/components/state_management_components/error_screen.dart';
import 'package:fieldsales/components/state_management_components/loading_screen.dart';
import 'package:fieldsales/components/svg_image_component.dart';
import 'package:fieldsales/components/text_component/normal_text.dart';
import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/config.dart';
import 'package:fieldsales/helper/date_converter.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:fieldsales/models/expense/expense_list_model.dart';
import 'package:fieldsales/ui/expense/add_expense_screen.dart';
import 'package:fieldsales/ui/my_activity/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../components/state_management_components/empty_screen_component.dart';
class ExpenceScreen extends StatefulWidget {
  const ExpenceScreen({super.key});

  @override
  State<ExpenceScreen> createState() => _ExpenceScreenState();
}

class _ExpenceScreenState extends State<ExpenceScreen> {

  late final ValueNotifier<List<Expense>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  late LinkedHashMap<DateTime, List<Expense>> kEvents;
  late ExpenseListBloc expenseListBloc;
  bool isSelectedEventsInitialized=false;
  @override
  void initState() {
    super.initState();
    expenseListBloc=BlocProvider.of<ExpenseListBloc>(context);
    // _selectedDay = _focusedDay;
    // _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));

  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Expense> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  List<Expense> _getEventsForRange(DateTime start, DateTime end) {
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
      child: BlocBuilder<ExpenseListBloc,ExpenseListState>(
          builder: (context, state) {
            if(state is ExpenseListLoadingState)
            {
              return LoadingScreen();
            } else if(state is ExpenseListSuccessState)
            {
              List<Expense> todayExpenseList=[];
              DateTime now = DateTime.now();
              String _twoDigits(int n) {
                if (n >= 10) {
                  return '$n';
                }
                return '0$n';
              }
              String formattedDate = '${now.year}-${_twoDigits(now.month)}-${_twoDigits(now.day)}';
              for(ExpenseListModel item in state.expenseList)
              {
                if(item.date==formattedDate)
                {
                  todayExpenseList=item.expense!;
                }
              }
              // Print the formatted date
              print('Formatted Date: $formattedDate');

              final _kEventSource = Map.fromIterable(
                  List.generate(state.expenseList.length, (index) => index),
                  key: (item) => DateTime.parse(state.expenseList[item].date.toString()),
                  value: (item) => List.generate(
                      state.expenseList[item].expense!.length, (index) =>state.expenseList[item].expense![index]
                  )
              )
                ..addAll({
                  kToday: todayExpenseList,
                });
              kEvents =LinkedHashMap<DateTime, List<Expense>>(
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
                backgroundColor: COLORS.scaffoldBg,
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.endFloat,
                floatingActionButton: FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => BlocProvider(create: (context) => AddExpenseBloc(), child: AddExpenseScreen())));
                  },
                  backgroundColor: COLORS.primaryColor,
                  foregroundColor: COLORS.white,
                  elevation: 3,
                  icon: const Icon(Icons.add_rounded, size: 22),
                  label: const Text(
                    "Add Expense",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 14.5,
                    ),
                  ),
                ),
                appBar:PreferredSize(preferredSize: Size(SizeConfig.screenWidth, SizeConfig.blockHeight*8), child: Container(
                  width: SizeConfig.screenWidth,
                  decoration: BoxDecoration(
                    color: COLORS.surface,
                    boxShadow: [
                      BoxShadow(
                        color: COLORS.shadow,
                        blurRadius: 14,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: SafeArea(
                    bottom: false,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*4, vertical: SizeConfig.blockHeight*1.6),
                      child: Row(
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(SizeConfig.blockWidth*3),
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: EdgeInsets.all(SizeConfig.blockWidth*2),
                              decoration: BoxDecoration(
                                color: COLORS.surfaceMuted,
                                borderRadius: BorderRadius.circular(SizeConfig.blockWidth*3),
                              ),
                              child: Icon(Icons.arrow_back, color: COLORS.textPrimary, size: SizeConfig.blockHeight*2.6),
                            ),
                          ),
                          SizedBox(width: SizeConfig.blockWidth*4,),
                          NormalText(fontWeight: FontWeight.w700, color: COLORS.textPrimary, fontSize: 2.6, text:"Expense"),
                        ],
                      ),
                    ),
                  ),
                )),
                body: Stack(
                  children: [
                    Container(
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.screenHeight,
                      color: COLORS.scaffoldBg,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*4,vertical: SizeConfig.blockHeight*2),
                            padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*5, vertical: SizeConfig.blockHeight*2),
                            width: SizeConfig.screenWidth,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [COLORS.primaryColor, COLORS.primaryDark],
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*4.5)),
                                boxShadow: [
                                  BoxShadow(
                                    color: COLORS.primaryColor.withOpacity(0.30),
                                    blurRadius: 18,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                            ),
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    NormalText(fontWeight: FontWeight.w400, color: COLORS.onPrimaryColor, fontSize: 1.8, text: "Total Claim") ,
                                    SizedBox(height: SizeConfig.blockHeight*0.6,),
                                    NormalText(fontWeight: FontWeight.w700, color: COLORS.onPrimaryColor, fontSize: 2.4, text: "₹0/Day") ,
                                  ],
                                ),
                                Container(
                                  width: 1,
                                  height: SizeConfig.blockHeight*5,
                                  color: COLORS.onPrimaryColor.withOpacity(0.25),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    NormalText(fontWeight: FontWeight.w400, color: COLORS.onPrimaryColor, fontSize: 1.8, text: "Total Approved") ,
                                    SizedBox(height: SizeConfig.blockHeight*0.6,),
                                    NormalText(fontWeight: FontWeight.w700, color: COLORS.onPrimaryColor, fontSize: 2.4, text: "₹0/Day") ,
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*4),
                            padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*2, vertical: SizeConfig.blockHeight*1),
                            decoration: BoxDecoration(
                              color: COLORS.surface,
                              border: Border.all(color: COLORS.cardBorder),
                              borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*4.5)),
                              boxShadow: [
                                BoxShadow(
                                  color: COLORS.shadow,
                                  blurRadius: 14,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),

                            child: TableCalendar<Expense>(
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
                                titleTextStyle: TextStyle(fontSize: SizeConfig.blockHeight*2.4,color:COLORS.textPrimary,fontFamily: Config.fountFamilyPrimary,fontWeight:FontWeight.w700),
                                decoration: const BoxDecoration(color: COLORS.surface,),
                                rightChevronIcon:  Container(
                                    padding: EdgeInsets.all(SizeConfig.blockWidth*1.5),
                                    decoration: BoxDecoration(
                                        color: COLORS.primarySoft,
                                        borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*2.5))
                                    ),
                                    child: Icon(Icons.arrow_forward_ios,color:COLORS.primaryColor,size: SizeConfig.blockHeight*2.2,)),
                                leftChevronIcon: Container(
                                    padding: EdgeInsets.all(SizeConfig.blockWidth*1.5),
                                    decoration: BoxDecoration(
                                        color: COLORS.primarySoft,
                                        borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*2.5))
                                    ),
                                    child: Icon(Icons.arrow_back_ios_new,color:COLORS.primaryColor,size: SizeConfig.blockHeight*2.2,)),

                              ),
                              calendarStyle: CalendarStyle(
                                outsideDaysVisible: false,
                                selectedTextStyle:TextStyle(fontSize: SizeConfig.blockHeight*2,color:COLORS.onPrimaryColor,fontFamily: Config.fountFamilyPrimary,fontWeight:FontWeight.w600) ,
                                defaultTextStyle:   textStyleComponent,//all exept sat and sunday
                                weekendTextStyle:textStyleComponent,//weelkend text style
                                selectedDecoration:  BoxDecoration(color:COLORS.primaryColor,shape:BoxShape.circle ),//decoration of selected date
                                todayDecoration:BoxDecoration(color:COLORS.primaryColor.withOpacity(0.35),shape:BoxShape.circle ),
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
                          SizedBox(height: SizeConfig.blockHeight*1.5),
                          Expanded(
                            child: ValueListenableBuilder<List<Expense>>(
                              valueListenable: _selectedEvents,
                              builder: (context, value, _) {
                                return value.length==0?SingleChildScrollView(physics:NeverScrollableScrollPhysics(),child: EmptyScreen(text: "Expense Not Found!",distanceFromTop: 0)): ListView.builder(
                                  padding: EdgeInsets.only(
                                    left: SizeConfig.blockWidth*4,
                                    right: SizeConfig.blockWidth*4,
                                    top: SizeConfig.blockHeight*0.5,
                                    bottom: SizeConfig.blockHeight*11,
                                  ),
                                  itemCount: value.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin:  EdgeInsets.only(
                                        bottom: SizeConfig.blockHeight*1.6,
                                      ),
                                      padding:  EdgeInsets.symmetric(
                                        horizontal: SizeConfig.blockWidth*4,
                                        vertical: SizeConfig.blockHeight*2,
                                      ),
                                      decoration: BoxDecoration(
                                          border: Border.all(color: COLORS.cardBorder),
                                          color: COLORS.surface,
                                          borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*4)),
                                          boxShadow: [
                                            BoxShadow(
                                              color: COLORS.shadow,
                                              blurRadius: 12,
                                              offset: const Offset(0, 6),
                                            ),
                                          ],
                                      ),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(top: SizeConfig.blockHeight*0.3, right: SizeConfig.blockWidth*3),
                                            padding: EdgeInsets.all(SizeConfig.blockWidth*2.6),
                                            decoration: BoxDecoration(
                                              color: COLORS.primarySoft,
                                              borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*3)),
                                            ),
                                            child: Icon(Icons.receipt_long_outlined, color: COLORS.primaryColor, size: SizeConfig.blockHeight*2.8),
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                NormalText(fontWeight: FontWeight.w700, color: COLORS.textPrimary, fontSize: 2, text: value[index].expenseProduct!),
                                                SizedBox(height: SizeConfig.blockHeight*0.8,),
                                                subTitleText(text: "Claim Amount : ₹ ${ value[index].expenseClaimPrice!}"),
                                                SizedBox(height: SizeConfig.blockHeight*0.4,),
                                                subTitleText(text: "Approved Amount : ₹ ${ value[index].expenseTotalPrice!}"),
                                              ],
                                            ),
                                          ),

                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              subTitleText(text:DateFormetConvertHelper(date: value[index].createdDate!.toString()) ),
                                              SizedBox(height: SizeConfig.blockHeight*1.4,),
                                              SizedBox(
                                                width: SizeConfig.blockWidth*20,
                                                height:SizeConfig.blockHeight*4,
                                                child:  ElevatedButton(
                                                  child: NormalText(fontWeight: FontWeight.w600, color: COLORS.success, fontSize:1.4, text: "To Submit") ,
                                                  style: ButtonStyle(

                                                      elevation: WidgetStatePropertyAll(0),
                                                      padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*1),),
                                                      backgroundColor: MaterialStatePropertyAll(COLORS.successSoft),
                                                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*3)))),
                                                      side: WidgetStatePropertyAll(BorderSide(color: COLORS.success.withOpacity(0.4)))
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
                                );
                              },
                            ),
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              );
            }else if(state is ExpenseListFailedState)
            {

              return ErrorScreen(onPressed: (){
                expenseListBloc.add(const FetchExpenseListEvent());
              });
            }

            return  Container();
          },
      )


    );
  }

  TextStyle textStyleComponent=TextStyle(fontSize: SizeConfig.blockHeight*2,color:COLORS.textColor,fontFamily: Config.fountFamilyPrimary,fontWeight:FontWeight.w500);
  Widget subTitleText({required String text}){
    return  NormalText(fontWeight: FontWeight.w400, color: COLORS.textSecondary, fontSize: 1.6, text: text);
  }
}

