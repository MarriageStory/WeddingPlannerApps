import 'dart:ui';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wedding_planner/screens/task/task_form.dart';
import 'package:wedding_planner/screens/task/task_detail.dart';
import 'package:wedding_planner/model/scheduleModel.dart';
import 'package:wedding_planner/service/scheduleService.dart';
import 'package:intl/intl.dart';

class TaskScreen extends StatefulWidget {
  static final url = "/task-page";
  const TaskScreen({Key? key}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  late Future<Schedule> _schedule;
  int id = 0;
  int allTask = 0;
  int totalData = 0;

  @override
  void initState() {
    super.initState();
    _schedule = ScheduleService().getAllSchedule();
  }

  void refreshData() {
    id++;
  }

  FutureOr onGoBack(dynamic value) {
    refreshData();
    setState(() {});
  }

  void _incrementCounter() {}

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final bottomNavigation = MediaQuery.of(context).viewInsets.bottom;
    final pageHeight = height - bottomNavigation;

    return Scaffold(
        backgroundColor: Color(0xFFE5E5E5),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: 150,
                    width: double.infinity,
                    alignment: AlignmentDirectional.topCenter,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image:
                                AssetImage("assets/images/bg-taskScreen.png"),
                            fit: BoxFit.fill)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const TaskScreen()),
                              );
                            },
                            icon: const Icon(Icons.list, color: Colors.white)),
                        const Text(
                          "Checklist",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.white),
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TaskForm()),
                              );
                            },
                            icon: const Icon(Icons.add, color: Colors.white))
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 50, right: 15, left: 18),
                    // margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Task in progress',
                          style: TextStyle(color: Colors.grey),
                        ),
                        TextButton(onPressed: () {}, child: Text("Sort by"))
                      ],
                    ),
                  ),

                  //pembatas
                  FutureBuilder(
                    future: _schedule,
                    builder: (context, AsyncSnapshot<Schedule> snapshot) {
                      var state = snapshot.connectionState;
                      if (state != ConnectionState.done) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              var schedule = snapshot.data!.data[index];
                              return InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, DetailTask.url,
                                        arguments: schedule);
                                  },
                                  child: listItem(schedule));
                            },
                            itemCount: snapshot.data!.data.length,
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              snapshot.error.toString(),
                            ),
                          );
                        } else {
                          return Text('');
                        }
                      }
                    },
                  ),
                ],
              ),
              FutureBuilder(
                future: _schedule,
                builder: (context, AsyncSnapshot<Schedule> snapshot) {
                  var state = snapshot.connectionState;
                  if (snapshot.hasData) {
                    allTask = snapshot.data!.data.length;

                    return Positioned(
                      top: 100,
                      left: 0,
                      right: 0,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 24),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20.0),
                                child: Column(
                                  children: [
                                    Text(
                                      "coming soon",
                                    ),
                                    Text("All Tasks"),
                                  ],
                                ),
                              ),
                              const VerticalDivider(
                                width: 20,
                                thickness: 1,
                                indent: 0,
                                endIndent: 0,
                                color: Colors.grey,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20.0),
                                child: Column(
                                  children: [
                                    Text(allTask.toString()),
                                    Text("Completed Tasks"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Text('');
                  }
                },
              ),
            ],
          ),
        )));
  }

  Widget listItem(Schedules view) {
    String tanggal = DateFormat.yMd().format(view.tanggal);

    return Card(
      color: Colors.white,
      child: SizedBox(
        height: 80,
        width: 350,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text(tanggal),
                  ),
                  Container(
                    child: Text(view.namaKegiatan),
                  ),
                ],
              ),
              SizedBox(
                width: 100,
              ),
              const VerticalDivider(
                width: 10,
                thickness: 1,
                indent: 10,
                endIndent: 10,
                color: Colors.grey,
              ),
              Container(
                child: Text(view.jam),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
