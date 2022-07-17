import 'dart:async';

import 'package:flutter/material.dart';
import 'package:habits/widgets/habits_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//overall habit sumary

  List habitList = [
    //habitName, habitStart, timeSpent (sec), timeGoal(min)
    ['Exercicio', false, 0, 10],
    ['Leitura', false, 0, 20],
    ['Estudo', false, 0, 20],
    ['Code', false, 0, 40],
  ];

  void habitStart(int index) {
    var startTime = DateTime.now();

    int elapsedTime = habitList[index][2];
    //print(startTime.second);
    setState(() {
      habitList[index][1] = !habitList[index][1];
    });

    if (habitList[index][1]) {
      Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          //   habitList[index][2]++;
          if (habitList[index][1] == false) {
            timer.cancel();
          }
          var currentTime = DateTime.now();
          habitList[index][2] = elapsedTime +
              currentTime.second -
              startTime.second +
              60 * (currentTime.minute - startTime.minute) +
              60 * 60 * (currentTime.hour - startTime.hour);
        });
      });
    }
  }

  void settingsOpen(int index) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Configuracoes de' + habitList[index][0]),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepPurple[400],
        appBar: AppBar(
          backgroundColor: Colors.deepPurple[300],
          title: Text('Meus Habitos'),
          centerTitle: false,
        ),
        body: ListView.builder(
            itemCount: habitList.length,
            itemBuilder: ((context, index) {
              return MyHabits(
                HabitName: habitList[index][0],
                onTap: () {
                  habitStart(index);
                },
                settingsTap: () {
                  settingsOpen(index);
                },
                habitStart: habitList[index][1],
                timeSpent: habitList[index][2],
                timeGoal: habitList[index][3],
              );
            })));
  }
}
