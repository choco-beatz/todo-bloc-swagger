import 'package:flutter/material.dart';
import 'package:flutter_analog_clock/flutter_analog_clock.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_bloc/bloc/time_bloc.dart';
import 'package:todo_bloc/constant/colors.dart';

class TopPart extends StatelessWidget {
  const TopPart({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimeBloc, TimeState>(
      builder: (context, state) {
        return Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              height: height * 0.15,
              width: width * 0.62,
              decoration: BoxDecoration(
                  color: mainColor, borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat.EEEE().format(state.currentTime).toUpperCase(),
                      style: const TextStyle(fontSize: 36),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        DateFormat.yMMMMd().format(
                          state.currentTime,
                        ),
                        style: const TextStyle(fontSize: 18, color: textColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: height * 0.15,
              width: width * 0.3,
              decoration: BoxDecoration(
                  color: mainColor, borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 12, top: 14, bottom: 14, right: 8),
                    child: Material(
                      elevation: 10,
                      borderRadius: BorderRadius.circular(50),
                      child: AnalogClock(
                        dateTime: state.currentTime,
                        dialColor: clockColor,
                        centerPointColor: white,
                        markingColor: clockColor,
                        hourNumberSizeFactor: 1.25,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
