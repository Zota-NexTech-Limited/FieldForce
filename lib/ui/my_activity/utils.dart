
// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';

import 'package:table_calendar/table_calendar.dart';

/// Example event class.
class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}



LinkedHashMap<DateTime, List<Event>> kEvents =LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);



  List<DateTime> dateTimeList=[DateTime(2024, 7, 1),DateTime(2024, 7, 2),DateTime(2024, 7, 3),DateTime(2024, 7, 4),DateTime(2024, 7, 5),DateTime(2024, 7, 6),DateTime(2024, 7, 23)];

final _kEventSource = Map.fromIterable(
    List.generate(dateTimeList.length, (index) => index),
    key: (item) => dateTimeList[item],
    value: (item) => List.generate(
         2, (index) => Event('Event $item | ${index + 1}')
    )
)
  ..addAll({
    kToday: [
      Event('Today\'s Event 1'),

    ],
  });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;

}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
        (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
