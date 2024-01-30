library time_scale;

import 'package:flutter/material.dart';
import 'package:time_scale/time_period.dart';
import 'package:time_scale/widgets/hour_mark_widget.dart';
import 'package:time_scale/widgets/time_period_widget.dart';

typedef ScaleItemBuilder = Widget Function(BuildContext context, int hour);

class TimeScale extends StatefulWidget {
  final List<TimePeriod> periods;
  final Map<TimePeriod, Color> colors;
  final double scaleStep;
  final double scaleMax;
  final bool isInfinite;
  final int initialHour;
  final Axis scrollDirection;

  const TimeScale(
      {super.key,
      required this.periods,
      required this.colors,
      this.scaleStep = 1.0,
      this.scaleMax = 24,
      required this.initialHour,
      this.scrollDirection = Axis.vertical,
      this.isInfinite = true});

  @override
  State<StatefulWidget> createState() => _TimeScaleState();
}

class _TimeScaleState extends State<TimeScale> {
  static const hourHeight = 30.0;
  static const hourWidth = 30.0;

  ScaleItemBuilder getVerticalBuilder(TimePeriod item) =>
      (context, hour) => TimePeriodVerticalWidgetPart(
            localTime: item,
            hour: hour,
            hourHeight: hourHeight,
            color: widget.colors[item] ?? Colors.black,
          );

  ScaleItemBuilder scaleVerticalDotBuilder = (context, hour) =>
      HourMarkVerticalWidget(hour: hour, hourHeight: hourHeight);

  ScaleItemBuilder getHorizontalBuilder(TimePeriod item) =>
      (context, hour) => TimePeriodHorizontalWidgetPart(
            localTime: item,
            hour: hour,
            hourWidth: hourWidth,
            color: widget.colors[item] ?? Colors.black,
          );

  ScaleItemBuilder scaleHorizontalDotBuilder = (context, hour) =>
      HourMarkHorizontalWidget(hour: hour, hourWidth: hourWidth);

  final ScrollController controllerItems = ScrollController();
  final ScrollController controllerHourLabels = ScrollController();

  @override
  void initState() {
    controllerItems.addListener(() {
      if (controllerItems.offset != controllerHourLabels.offset) {
        controllerHourLabels.jumpTo(controllerItems.offset);
      }
    });
    controllerHourLabels.addListener(() {
      if (controllerItems.offset != controllerHourLabels.offset) {
        controllerItems.jumpTo(controllerHourLabels.offset);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controllerItems.dispose();
    controllerHourLabels.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.scrollDirection == Axis.vertical) {
      return Stack(
        children: [
          ListView.builder(
              controller: controllerItems,
              itemExtent: hourHeight,
              itemBuilder: (context, index) {
                var hour = widget.initialHour + index;
                if (widget.isInfinite) {
                  hour = hour % 24;
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ...widget.periods
                        .map((e) => getVerticalBuilder(e))
                        .toList()
                        .map((e) => e(context, hour)),
                    const SizedBox(width: 40),
                  ],
                );
              }),
          ListView.builder(
              padding: const EdgeInsets.only(top: hourHeight / 2),
              controller: controllerHourLabels,
              itemExtent: hourHeight,
              itemBuilder: (context, index) {
                var hour = widget.initialHour + index + 1;
                if (widget.isInfinite) {
                  hour = hour % 24;
                }
                return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [scaleVerticalDotBuilder.call(context, hour)]);
              }),
        ],
      );
    } else {
      return Stack(
        children: [
          ListView.builder(
              padding: const EdgeInsets.only(top: 50),
              scrollDirection: Axis.horizontal,
              controller: controllerItems,
              itemExtent: hourWidth,
              itemBuilder: (context, index) {
                var hour = widget.initialHour + index;
                if (widget.isInfinite) {
                  hour = hour % 24;
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ...widget.periods
                        .map((e) => getHorizontalBuilder(e))
                        .toList()
                        .map((e) => e(context, hour)),
                    const SizedBox(width: 40),
                  ],
                );
              }),
          ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(top: hourHeight / 2),
              controller: controllerHourLabels,
              itemExtent: hourWidth,
              itemBuilder: (context, index) {
                var hour = widget.initialHour + index + 1;
                if (widget.isInfinite) {
                  hour = hour % 24;
                }
                return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [scaleHorizontalDotBuilder.call(context, hour)]);
              }),
        ],
      );
    }
  }
}
