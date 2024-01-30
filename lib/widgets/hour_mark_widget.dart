import 'package:flutter/material.dart';

class HourMarkVerticalWidget extends StatelessWidget {
  final int hour;
  final double hourHeight;

  const HourMarkVerticalWidget(
      {super.key, required this.hour, required this.hourHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 10),
      height: hourHeight,
      child: Row(
        children: [
          Center(
            child: Container(
              width: 50,
              height: 1,
              decoration: const BoxDecoration(color: Colors.black),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          SizedBox(
            width: 20,
            child: Center(
              child: Text(hour.toString()),
            ),
          ),
        ],
      ),
    );
  }
}

class HourMarkHorizontalWidget extends StatelessWidget {
  final int hour;
  final double hourWidth;

  const HourMarkHorizontalWidget(
      {super.key, required this.hour, required this.hourWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 10),
      width: hourWidth,
      child: Column(
        children: [
          SizedBox(
            height: 20,
            child: Center(
              child: Text(hour.toString()),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Center(
            child: Container(
              width: 1,
              height: 50,
              decoration: const BoxDecoration(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
