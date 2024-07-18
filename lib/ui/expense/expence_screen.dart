import 'package:fieldforce/components/button_component/circular_button.dart';
import 'package:fieldforce/components/button_component/normal_button.dart';
import 'package:fieldforce/components/text_component/normal_text.dart';
import 'package:fieldforce/helper/colors.dart';
import 'package:fieldforce/helper/config.dart';
import 'package:fieldforce/helper/size_config.dart';
import 'package:fieldforce/ui/expense/add_expense_screen.dart';
import 'package:fieldforce/ui/expense/demo_screen.dart';
import 'package:fieldforce/ui/my_activity/utils.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
class ExpenceScreen extends StatefulWidget {
  const ExpenceScreen({super.key});

  @override
  State<ExpenceScreen> createState() => _ExpenceScreenState();
}

class _ExpenceScreenState extends State<ExpenceScreen> {

  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));

  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
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
      child: Scaffold(
        appBar:AppBar(backgroundColor: COLORS.blue,
          leading: InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back_ios_new,color: COLORS.white,)),
          title:const NormalText(fontWeight: FontWeight.w400, color: COLORS.white, fontSize: 3.3, text: "Expense") ,
          bottom:   PreferredSize(
              preferredSize: Size(SizeConfig.screenWidth,SizeConfig.blockHeight*7),child:
          Container(
            decoration:const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: COLORS.blue,
                    spreadRadius: 14,
                    blurRadius: 1,
                    offset: Offset(2, 10),
                  ),
                ]
            ),
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*15),
            child:const Column(
              children: [
                Row(
                  children: [

                    Column(
                      children: [
                        NormalText(fontWeight: FontWeight.w400, color: COLORS.white, fontSize: 2, text: "Total Claim") ,
                        NormalText(fontWeight: FontWeight.w600, color: COLORS.white, fontSize: 2, text: "₹0/Month") ,
                      ],
                    ),
                    Spacer(),
                    Column(
                      children: [
                        NormalText(fontWeight: FontWeight.w400, color: COLORS.white, fontSize: 2, text: "Total Approved") ,
                        NormalText(fontWeight: FontWeight.w600, color: COLORS.white, fontSize: 2, text: "₹0/Month") ,
                      ],
                    )
                  ],
                ),

              ],
            ),
          )),
        ),
        body: Stack(
          children: [
            Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight,
              color: COLORS.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TableCalendar<Event>(
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
                      titleTextStyle: TextStyle(fontSize: SizeConfig.blockHeight*2.8,color:COLORS.white,fontFamily: Config.fountFamilyPrimary,fontWeight:FontWeight.w500),
                      decoration: const BoxDecoration(color: COLORS.blue,),
                      rightChevronIcon:const  Icon(Icons.arrow_forward,color:COLORS.white),
                      leftChevronIcon:const Icon(Icons.arrow_back,color: COLORS.white,),

                    ),
                    calendarStyle: CalendarStyle(
                      outsideDaysVisible: false,
                      defaultTextStyle:   textStyleComponent,//all exept sat and sunday
                      weekendTextStyle:textStyleComponent,//weelkend text style
                      selectedDecoration: const BoxDecoration(color:COLORS.blue,shape:BoxShape.circle ),//decoration of selected date
                      todayDecoration:BoxDecoration(color:COLORS.blue.withOpacity(0.4),shape:BoxShape.circle ),
                      markerDecoration: const BoxDecoration(color: COLORS.black,borderRadius: BorderRadius.all(Radius.circular(10))),//event show


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
                    child: ValueListenableBuilder<List<Event>>(
                      valueListenable: _selectedEvents,
                      builder: (context, value, _) {
                        return value.length==0?Container(
                          width: SizeConfig.screenWidth,
                          padding: EdgeInsets.only(left: SizeConfig.blockWidth*25,top: SizeConfig.blockHeight*10),
                          child: const NormalText(fontWeight: FontWeight.w400, color: COLORS.black, fontSize: 3.3, text: "No Record Found"),
                        ): ListView.builder(
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
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      spreadRadius: 0.1,
                                      blurRadius: 4,
                                      offset: Offset(0, 1),
                                    ),
                                  ],
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
                                      NormalText(fontWeight: FontWeight.w600, color: COLORS.black, fontSize: 2, text: "AB23434543677899"),
                                      subTitleText(text: "Clime Amount : ₹ 10"),
                                      subTitleText(text: "Approve Amount : ₹ 10"),

                                    ],
                                  ),

                                  Column(
                                    children: [
                                      subTitleText(text: "Date :15-07-2001"),
                                      SizedBox(height: SizeConfig.blockHeight*1,),
                                      SizedBox(
                                        width: SizeConfig.blockWidth*20,
                                        height:SizeConfig.blockHeight*4,
                                        child:  ElevatedButton(
                                          child: NormalText(fontWeight: FontWeight.w500, color: COLORS.black, fontSize:1.8, text: "To Submit") ,
                                          style: ButtonStyle(
                                              elevation: WidgetStatePropertyAll(0),
                                              padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*1),),
                                              backgroundColor: MaterialStatePropertyAll(COLORS.yellow),
                                              shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*3))))
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
            Positioned(
                bottom: SizeConfig.blockHeight*2,

                child: Container(
                  width: SizeConfig.screenWidth,
                  padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*4,vertical: SizeConfig.blockHeight*0.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> FilePickerDemo()));
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*3,vertical: SizeConfig.blockHeight*0.5),
                          width: SizeConfig.blockWidth*70,
                          height: SizeConfig.blockHeight*7,
                          decoration: BoxDecoration(
                              color: COLORS.blue,
                              borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*3))
                          ),
                          child:const  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Column(
                                children: [
                                  NormalText(fontWeight: FontWeight.w400, color: COLORS.white, fontSize: 2, text: "Total Claim") ,
                                  NormalText(fontWeight: FontWeight.w600, color: COLORS.white, fontSize: 2, text: "₹0/Day") ,
                                ],
                              ),
                              Spacer(),
                              Column(
                                children: [
                                  NormalText(fontWeight: FontWeight.w400, color: COLORS.white, fontSize: 2, text: "Total Approved") ,
                                  NormalText(fontWeight: FontWeight.w600, color: COLORS.white, fontSize: 2, text: "₹0/Day") ,
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      CircularButtonComponent(icon: Icons.add,onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddExpenseScreen()));
                      },),

                    ],
                  ),
                )),


          ],
        ),
      ),
    );
  }

  TextStyle textStyleComponent=TextStyle(fontSize: SizeConfig.blockHeight*2,color:COLORS.black,fontFamily: Config.fountFamilyPrimary,fontWeight:FontWeight.w500);
  Widget subTitleText({required String text}){
    return  NormalText(fontWeight: FontWeight.w400, color: COLORS.black, fontSize: 1.6, text: text);
  }
}

