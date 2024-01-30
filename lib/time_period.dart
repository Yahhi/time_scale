import 'package:flutter/material.dart';

class TimePeriod {
  final TimeOfDay start;
  final TimeOfDay end;

  const TimePeriod({required this.start, required this.end});

  double verticalSize(double hourHeight) =>
      _difference(start, end) * hourHeight;

  PositionVariant positionForHour(int hour) {
    if (hour == start.hour) {
      return PositionVariant.starting;
    } else if ((end.minute > 0 && hour == end.hour) ||
        (end.minute == 0 && hour == end.hour - 1)) {
      return PositionVariant.finishing;
    } else if (start.hour < end.hour &&
        (hour > start.hour && hour < end.hour)) {
      return PositionVariant.inner;
    } else if (start.hour > end.hour &&
        (hour > start.hour || hour < end.hour)) {
      return PositionVariant.inner;
    } else {
      return PositionVariant.nothing;
    }
  }

  double? startingOffsetForHour(int hour, double hourHeight) {
    if (start.hour == hour) {
      return start.minute / 60 * hourHeight;
    } else {
      return null;
    }
  }

  double? endingOffsetForHour(int hour, double hourHeight) {
    if (end.hour == hour && end.minute == 0) {
      return null;
    } else if (end.hour == hour) {
      return end.minute / 60 * hourHeight;
    } else if (end.hour == hour + 1) {
      return hourHeight;
    } else {
      return null;
    }
  }

  /// calculates number of hours (with dot) which is the difference between start and end
  double _difference(TimeOfDay start, TimeOfDay end) {
    final minutesAfter0ForStart = start.hour * 60 + start.minute;
    var minutesAfter0ForEnd = end.hour * 60 + end.minute;
    if (minutesAfter0ForEnd < minutesAfter0ForStart) {
      minutesAfter0ForEnd += 24 * 60;
    }
    return (minutesAfter0ForEnd - minutesAfter0ForStart) / 60;
  }

  double verticalPosition(double hourHeight) {
    return (start.hour + start.minute / 60) * hourHeight;
  }
}

enum PositionVariant {
  starting,
  inner,
  finishing,
  nothing,
}
