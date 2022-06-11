import 'package:flutter/material.dart';
import 'package:wedding_planner/screens/homePage/homePage.dart';
import 'package:wedding_planner/screens/task/task_edit_form.dart';
import 'package:wedding_planner/model/scheduleModel.dart';
import 'package:wedding_planner/screens/task/task_screen.dart';
import 'package:wedding_planner/navbar/navbar.dart';

class DetailTask extends StatelessWidget {
  static final url = "/detail-task";
  const DetailTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Schedules schedule =
        ModalRoute.of(context)!.settings.arguments as Schedules;

    return Scaffold(
      body: Column(children: <Widget>[
        const Padding(padding: EdgeInsets.all(18.0)),
        const Padding(padding: EdgeInsets.only(top: 8)),
        Container(
          margin: const EdgeInsets.only(right: 16, left: 16),
          height: 70,
          child: Row(
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BaseScreen(index: 1)),
                    );
                  },
                  child: Icon(Icons.arrow_back)),
              SizedBox(width: 76),
              Text(
                "Detail Task",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              SizedBox(width: 70),
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, TaskEditForm.url,
                        arguments: schedule);
                  },
                  icon: Icon(Icons.edit))
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(right: 23, left: 23),
          height: MediaQuery.of(context).size.height * 0.732,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 2,
                offset: Offset(0, 0), // Shadow position
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(right: 16, left: 16, top: 20),
                child: Text(
                  schedule.namaClient,
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color(0xFFFE6A7E).withOpacity(0.65),
                      Color(0xFFFE6A7E),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 16, left: 16, top: 20),
                child: Text(
                  schedule.jam,
                  style: TextStyle(fontSize: 35),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 16, left: 16, top: 2),
                child: Text(
                  schedule.tanggal.toString(),
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 16, left: 16, top: 30),
                child: Text(
                  "Task:",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 16, left: 16, top: 2),
                child: Text(
                  schedule.namaKegiatan,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 16, left: 16, top: 30),
                child: Text(
                  "Place:",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 16, left: 16, top: 2),
                child: Text(
                  schedule.tempat,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 16, left: 16, top: 30),
                child: Text(
                  "Detail:",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 16, left: 16, top: 2),
                child: Text(
                  schedule.detailKegiatan,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 16, left: 16, top: 30),
                child: Text(
                  "Map:",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 16, left: 16, top: 2),
                child: Text(
                  "Map not found",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
