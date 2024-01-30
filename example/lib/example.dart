import 'package:time_scale/time_period.dart';
import 'package:time_scale/widgets/hour_mark_widget.dart';
import 'package:flutter/material.dart';
import 'package:time_scale/vertical_time_scale.dart';

class ExamplePage extends StatelessWidget {
  static const times = [
    TimePeriod(
        start: TimeOfDay(hour: 8, minute: 0),
        end: TimeOfDay(hour: 17, minute: 0)),
    TimePeriod(
        start: TimeOfDay(hour: 14, minute: 0),
        end: TimeOfDay(hour: 23, minute: 0)),
    TimePeriod(
        start: TimeOfDay(hour: 18, minute: 0),
        end: TimeOfDay(hour: 3, minute: 30)),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Time Scale Example'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.horizontal_distribute)),
              Tab(icon: Icon(Icons.vertical_distribute)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            TimeScale(
              scrollDirection: Axis.horizontal,
              periods: times,
              initialHour: DateTime.now().hour,
            ),
            TimeScale(
              scrollDirection: Axis.vertical,
              periods: times,
              initialHour: DateTime.now().hour,
            ),
          ],
        ),
      ),
    );
  }
}
