import 'package:time_scale/time_period.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('vertical size calculation', () {
    test('time before noon works fine', () {
      const period = TimePeriod(
          start: TimeOfDay(hour: 8, minute: 0),
          end: TimeOfDay(hour: 11, minute: 0));
      expect(period.verticalSize(100), 300.0);
    });

    test('time with minutes works fine', () {
      const period = TimePeriod(
          start: TimeOfDay(hour: 8, minute: 30),
          end: TimeOfDay(hour: 9, minute: 30));
      expect(period.verticalSize(50), 50.0);
    });

    test('time before and after noon works fine', () {
      const period = TimePeriod(
          start: TimeOfDay(hour: 8, minute: 0),
          end: TimeOfDay(hour: 17, minute: 0));
      expect(period.verticalSize(100), 900.0);
    });

    test('time after and before noon works fine', () {
      const period = TimePeriod(
          start: TimeOfDay(hour: 17, minute: 0),
          end: TimeOfDay(hour: 8, minute: 0));
      expect(period.verticalSize(100), 1500.0);
    });
  });

  group('position for hour', () {
    test('positions inside starting hour', () {
      const period = TimePeriod(
          start: TimeOfDay(hour: 8, minute: 0),
          end: TimeOfDay(hour: 11, minute: 0));
      expect(period.positionForHour(8), PositionVariant.starting);
      const periodInNight = TimePeriod(
          start: TimeOfDay(hour: 17, minute: 0),
          end: TimeOfDay(hour: 8, minute: 0));
      expect(periodInNight.positionForHour(17), PositionVariant.starting);
      const periodWithMinutes = TimePeriod(
          start: TimeOfDay(hour: 8, minute: 30),
          end: TimeOfDay(hour: 11, minute: 0));
      expect(periodWithMinutes.positionForHour(8), PositionVariant.starting);
    });

    test('positions inside finishing hour', () {
      const period = TimePeriod(
          start: TimeOfDay(hour: 8, minute: 0),
          end: TimeOfDay(hour: 11, minute: 0));
      expect(period.positionForHour(10), PositionVariant.finishing);
      const periodInNight = TimePeriod(
          start: TimeOfDay(hour: 17, minute: 0),
          end: TimeOfDay(hour: 8, minute: 0));
      expect(periodInNight.positionForHour(7), PositionVariant.finishing);
      const periodWithMinutes = TimePeriod(
          start: TimeOfDay(hour: 8, minute: 30),
          end: TimeOfDay(hour: 11, minute: 30));
      expect(periodWithMinutes.positionForHour(11), PositionVariant.finishing);
    });

    test('positions inside', () {
      const period = TimePeriod(
          start: TimeOfDay(hour: 8, minute: 0),
          end: TimeOfDay(hour: 11, minute: 0));
      expect(period.positionForHour(9), PositionVariant.inner);
      const periodInNight = TimePeriod(
          start: TimeOfDay(hour: 17, minute: 0),
          end: TimeOfDay(hour: 8, minute: 0));
      expect(periodInNight.positionForHour(22), PositionVariant.inner);
      expect(periodInNight.positionForHour(6), PositionVariant.inner);
      const periodWithMinutes = TimePeriod(
          start: TimeOfDay(hour: 8, minute: 30),
          end: TimeOfDay(hour: 11, minute: 30));
      expect(periodWithMinutes.positionForHour(10), PositionVariant.inner);
    });

    test('positions outside', () {
      const period = TimePeriod(
          start: TimeOfDay(hour: 8, minute: 0),
          end: TimeOfDay(hour: 11, minute: 0));
      expect(period.positionForHour(7), PositionVariant.nothing);
      expect(period.positionForHour(11), PositionVariant.nothing);
      const periodInNight = TimePeriod(
          start: TimeOfDay(hour: 17, minute: 0),
          end: TimeOfDay(hour: 8, minute: 0));
      expect(periodInNight.positionForHour(16), PositionVariant.nothing);
      expect(periodInNight.positionForHour(9), PositionVariant.nothing);
      const periodWithMinutes = TimePeriod(
          start: TimeOfDay(hour: 8, minute: 30),
          end: TimeOfDay(hour: 11, minute: 30));
      expect(periodWithMinutes.positionForHour(7), PositionVariant.nothing);
      expect(periodWithMinutes.positionForHour(12), PositionVariant.nothing);
    });
  });

  group('vertical offset for hour', () {
    test('ending value of offset', () {
      const period = TimePeriod(
          start: TimeOfDay(hour: 8, minute: 0),
          end: TimeOfDay(hour: 11, minute: 0));
      expect(period.endingOffsetForHour(10, 100), 100);
      expect(period.endingOffsetForHour(11, 100), null);
      const periodInNight = TimePeriod(
          start: TimeOfDay(hour: 17, minute: 0),
          end: TimeOfDay(hour: 8, minute: 0));
      expect(periodInNight.endingOffsetForHour(7, 50), 50);
      expect(periodInNight.endingOffsetForHour(9, 50), null);
      const periodWithMinutes = TimePeriod(
          start: TimeOfDay(hour: 8, minute: 30),
          end: TimeOfDay(hour: 11, minute: 30));
      expect(periodWithMinutes.endingOffsetForHour(11, 50), 25);
      expect(periodWithMinutes.endingOffsetForHour(12, 50), null);
      const periodWithMinutes2 = TimePeriod(
          start: TimeOfDay(hour: 18, minute: 0),
          end: TimeOfDay(hour: 3, minute: 30));
      expect(periodWithMinutes2.endingOffsetForHour(3, 30), 15);
    });
  });
}
