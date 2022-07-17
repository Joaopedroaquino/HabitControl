import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class MyHabits extends StatelessWidget {
  final String HabitName;
  final VoidCallback onTap;
  final VoidCallback settingsTap;
  final int timeSpent;
  final int timeGoal;
  final bool habitStart;

  const MyHabits(
      {Key? key,
      required this.HabitName,
      required this.onTap,
      required this.settingsTap,
      required this.timeSpent,
      required this.timeGoal,
      required this.habitStart})
      : super(key: key);

  String formartToMinSec(int totalSeconds) {
    String secs = (totalSeconds % 60).toString();
    String mins = (totalSeconds / 60).toStringAsFixed(5);

    if (secs.length == 1) {
      secs = '0' + secs;
    }

    if (mins[1] == '.') {
      mins = mins.substring(0, 1);
    }
    return mins + ':' + secs;
  }

  double percentComplete() {
    return timeSpent / (timeGoal * 60);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [Colors.purple, Colors.pinkAccent]),
            border: Border.all(color: Colors.white.withOpacity(0.4)),
            borderRadius: BorderRadius.circular(12)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: onTap,
                  child: SizedBox(
                    width: 80,
                    height: 80,
                    child: Stack(
                      children: [
                        //% circle
                        CircularPercentIndicator(
                            radius: 40,
                            percent:
                                percentComplete() < 1 ? percentComplete() : 1,
                            progressColor: percentComplete() > 0.5
                                ? (percentComplete() > 0.75
                                    ? Colors.green
                                    : Colors.orange)
                                : Colors.red),
                        Center(
                          child:
                              Icon(habitStart ? Icons.pause : Icons.play_arrow),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //name
                    Text(
                      HabitName,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 19,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    //progres
                    Text(
                      formartToMinSec(timeSpent) +
                          '/' +
                          timeGoal.toString() +
                          ' = ' +
                          (percentComplete() * 100).toStringAsFixed(0) +
                          '%',
                      style: TextStyle(color: Colors.black),
                    )
                  ],
                ),
              ],
            ),
            GestureDetector(onTap: settingsTap, child: Icon(Icons.settings))
          ],
        ),
      ),
    );
  }
}
