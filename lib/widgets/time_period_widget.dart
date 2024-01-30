import 'package:flutter/material.dart';

import '../time_period.dart';

class TimePeriodVerticalWidgetPart extends StatelessWidget {
  final TimePeriod localTime;
  final double hourHeight;
  final int hour;
  final Color color;

  const TimePeriodVerticalWidgetPart(
      {super.key,
      required this.localTime,
      this.hourHeight = 100.0,
      required this.hour,
      required this.color});

  static const containerRadius = Radius.circular(4.0);
  static const containerWidth = 10.0;
  static const marginBetweenContainers = 5.0;

  Widget selectWidgetByPositionVariant(int hour, PositionVariant variant) {
    switch (variant) {
      case PositionVariant.starting:
        final offset = localTime.startingOffsetForHour(hour, hourHeight) ?? 0;
        return Column(children: [
          SizedBox(height: offset),
          Container(
            margin:
                const EdgeInsets.symmetric(horizontal: marginBetweenContainers),
            width: containerWidth,
            height: hourHeight - offset,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.only(
                  topLeft: containerRadius, topRight: containerRadius),
            ),
          ),
        ]);
      case PositionVariant.inner:
        return Container(
          margin:
              const EdgeInsets.symmetric(horizontal: marginBetweenContainers),
          width: containerWidth,
          height: hourHeight,
          decoration: BoxDecoration(
            color: color,
          ),
        );
      case PositionVariant.finishing:
        final offset = localTime.endingOffsetForHour(hour, hourHeight) ?? 0;
        return Column(children: [
          Container(
            margin:
                const EdgeInsets.symmetric(horizontal: marginBetweenContainers),
            width: containerWidth,
            height: offset,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.only(
                  bottomLeft: containerRadius, bottomRight: containerRadius),
            ),
          ),
          SizedBox(height: hourHeight - offset),
        ]);
      case PositionVariant.nothing:
        return SizedBox(
          height: hourHeight,
          width: containerWidth + marginBetweenContainers * 2,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return selectWidgetByPositionVariant(hour, localTime.positionForHour(hour));
  }
}

class TimePeriodHorizontalWidgetPart extends StatelessWidget {
  final TimePeriod localTime;
  final double hourWidth;
  final int hour;
  final Color color;

  const TimePeriodHorizontalWidgetPart(
      {super.key,
      required this.localTime,
      this.hourWidth = 100.0,
      required this.hour,
      required this.color});

  static const containerRadius = Radius.circular(4.0);
  static const containerHeight = 10.0;
  static const marginBetweenContainers = 3.0;

  Widget selectWidgetByPositionVariant(int hour, PositionVariant variant) {
    switch (variant) {
      case PositionVariant.starting:
        final offset = localTime.startingOffsetForHour(hour, hourWidth) ?? 0;
        return Row(children: [
          SizedBox(width: offset),
          Container(
            margin:
                const EdgeInsets.symmetric(vertical: marginBetweenContainers),
            height: containerHeight,
            width: hourWidth - offset,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.only(
                  topLeft: containerRadius, bottomLeft: containerRadius),
            ),
          ),
        ]);
      case PositionVariant.inner:
        return Container(
          margin: const EdgeInsets.symmetric(vertical: marginBetweenContainers),
          height: containerHeight,
          width: hourWidth,
          decoration: BoxDecoration(
            color: color,
          ),
        );
      case PositionVariant.finishing:
        final offset = localTime.endingOffsetForHour(hour, hourWidth) ?? 0;
        return Row(children: [
          Container(
            margin:
                const EdgeInsets.symmetric(vertical: marginBetweenContainers),
            height: containerHeight,
            width: offset,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.only(
                  topRight: containerRadius, bottomRight: containerRadius),
            ),
          ),
          SizedBox(width: hourWidth - offset),
        ]);
      case PositionVariant.nothing:
        return SizedBox(
          height: containerHeight + marginBetweenContainers * 2,
          width: hourWidth,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return selectWidgetByPositionVariant(hour, localTime.positionForHour(hour));
  }
}
