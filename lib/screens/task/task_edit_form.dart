import 'dart:math';
import 'package:flutter/material.dart';

//pubspec
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:date_time_picker/date_time_picker.dart';
//component
import 'package:wedding_planner/components/dateTime.dart';
import 'package:wedding_planner/components/rounded_input_field_form.dart';
//screen
import 'package:wedding_planner/screens//task/task_screen.dart';
import 'package:wedding_planner/screens/task/task_detail.dart';
//service
import 'package:wedding_planner/service/scheduleService.dart';
//model
import 'package:wedding_planner/model/scheduleModel.dart';

class TaskEditForm extends StatefulWidget {
  static final url = "/task-edit-form";
  const TaskEditForm({Key? key}) : super(key: key);

  @override
  State<TaskEditForm> createState() => _TaskEditFormState();
}

class _TaskEditFormState extends State<TaskEditForm> {
  //controller
  TextEditingController _nameClientController = TextEditingController();
  TextEditingController _nameTaskController = TextEditingController();
  TextEditingController _detailTaskController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _placeController = TextEditingController();
  //cek
  bool inisialisasi = false;
  //date & time
  DateTime tanggal = DateTime.now();
  TimeOfDay time = TimeOfDay.now();

  void showTime() {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) {
      setState(() {
        _timeController.text = value!.format(context).toString();
      });
    });
  }

  final TextStyle valueStyle = GoogleFonts.poppins(
    fontSize: 14,
  );
  final TextStyle valueStyleBefore =
      GoogleFonts.poppins(fontSize: 14, color: Color(0xFF8d8d8d));

  Future<Null> _selectDate(BuildContext context, DateTime date) async {
    // Initial DateTime FIinal Picked
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));

    if (picked != null)
      setState(() {
        _dateController.text = picked.toString();
      });
  }

  @override
  Widget build(BuildContext context) {
    final Schedules schedule =
        ModalRoute.of(context)!.settings.arguments as Schedules;

    if (schedule != null && inisialisasi == false) {
      _nameClientController.text = schedule.namaClient;
      _nameTaskController.text = schedule.namaKegiatan;
      _detailTaskController.text = schedule.detailKegiatan;
      _placeController.text = schedule.tempat;
      _timeController.text = schedule.jam;
      _dateController.text = schedule.tanggal.toString();

      inisialisasi = true;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: AlignmentDirectional.topCenter,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  color: Colors.white,
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, DetailTask.url,
                                arguments: schedule);
                          },
                          icon: const Icon(Icons.arrow_back,
                              color: Colors.black)),
                      SizedBox(
                        width: 80,
                      ),
                      const Text(
                        "Edit Task",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30, right: 16, left: 16),
                  child: RoundedInputFieldForm(
                    controller: _nameClientController,
                    valueStyle: valueStyle,
                    hintText: "Client Name",
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30, right: 16, left: 16),
                  child: RoundedInputFieldForm(
                    controller: _nameTaskController,
                    valueStyle: valueStyle,
                    hintText: "Task Name",
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30, right: 16, left: 16),
                  child: RoundedInputFieldForm(
                    controller: _detailTaskController,
                    valueStyle: valueStyle,
                    hintText: "Detail Task",
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30, right: 16, left: 16),
                  child: RoundedInputFieldForm(
                    controller: _placeController,
                    valueStyle: valueStyle,
                    hintText: "Place",
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20, right: 16, left: 16),
                  child: Column(children: [
                    dateTime(
                      // labelText: "Date",
                      valueText: DateFormat.yMd().format(schedule.tanggal),
                      valueStyle: valueStyle,
                      onPressed: () {
                        _selectDate(context, schedule.tanggal);
                      },
                    ),
                  ]),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20, right: 16, left: 16),
                  child: Column(children: [
                    dateTime(
                      // labelText: "Time",
                      // valueText: time.format(context),
                      valueText: _timeController.text,
                      valueStyle: valueStyle,
                      onPressed: () {
                        showTime();
                      },
                    ),
                  ]),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, right: 20),
                  child: Column(
                    children: <Widget>[
                      InkWell(
                        child: Container(
                          height: 45,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(
                              right: 16, left: 16, top: 20),
                          child: Text(
                            "save",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
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
                        onTap: () async {
                          Map<String, dynamic> body = {
                            'nama_kegiatan': _nameTaskController.text,
                            'detail_kegiatan': _detailTaskController.text,
                            'tanggal': _dateController.text,
                            'jam': _timeController.text,
                            'tempat': _placeController.text,
                            'nama_client': _nameClientController.text,
                          };

                          await ScheduleService()
                              .updateSchedule(body, schedule.id)
                              .then((value) {
                            Navigator.pushNamed(context, DetailTask.url,
                                arguments: schedule);
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'You have successfully update a scedule')));
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
