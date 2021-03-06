import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wedding_planner/model/schedule_model.dart';
import 'package:wedding_planner/screens/task/task_edit_form.dart';
import 'package:wedding_planner/navbar/navbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedding_planner/service/schedule_service.dart';

class DetailTask extends StatelessWidget {
  static final url = "/detail-task";
  const DetailTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final schedule =
        ModalRoute.of(context)!.settings.arguments as ScheduleModel;

    return Scaffold(
      body: Column(children: <Widget>[
        const Padding(padding: EdgeInsets.all(18.0)),
        const Padding(padding: EdgeInsets.only(top: 8)),
        Container(
          margin: const EdgeInsets.only(right: 16, left: 16),
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BaseScreen(index: 1)),
                  );
                },
                child: Icon(Icons.arrow_back, color: Colors.black87),
              ),
              Text(
                "Detail Task",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: Colors.black87),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, TaskEditForm.url,
                        arguments: schedule);
                  },
                  icon: Icon(
                    Icons.edit,
                    size: 23,
                  ))
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
                margin: const EdgeInsets.only(right: 28, left: 28, top: 24),
                child: Text(
                  schedule.namaClient.toUpperCase(),
                  style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),
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
                margin: const EdgeInsets.only(right: 28, left: 28, top: 40),
                child: Text(
                  schedule.jam,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 28),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 28, left: 28),
                child: Text(
                  DateFormat.yMd().format(schedule.tanggal),
                  style: TextStyle(fontSize: 14),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 28, left: 28, top: 40),
                child: Text(
                  "Task :",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 28, left: 28),
                child: Text(
                  schedule.namaKegiatan,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 28, left: 28, top: 28),
                child: Text(
                  "Place :",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 28, left: 28,),
                child: Text(
                  schedule.tempat,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 28, left: 28, top: 28),
                child: Text(
                  "Detail:",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 28, left: 28),
                child: Text(
                  schedule.detailKegiatan,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 28, left: 28, top: 28),
                child: Text(
                  "Map:",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 28, left: 28,),
                child: Text(
                  "Map not found",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                ),
              ),
            ],
          ),
        ),

        InkWell(
            child: Container(
              width: size.width,
              height: 45,
              padding: EdgeInsets.symmetric(vertical: 10),
              margin: const EdgeInsets.only(right: 16, left: 16, top: 20),
              child: Text(
                "Delete",
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
              await ScheduleService.deleteSchedule(schedule.id).then((value) {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return BaseScreen(index: 1);
                }));
              });
            }),

        // InkWell(
        //     child: Container(
        //       height: 45,
        //       padding: EdgeInsets.symmetric(vertical: 10),
        //       // width: MediaQuery.of(context).size.width,
        //       width: 80,
        //       margin: const EdgeInsets.only(right: 16, left: 16, top: 20),
        //       child: Text(
        //         "Done",
        //         style: GoogleFonts.poppins(
        //           fontSize: 16,
        //           color: Colors.white,
        //         ),
        //         textAlign: TextAlign.center,
        //       ),
        //       decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(25),
        //         gradient: LinearGradient(
        //           begin: Alignment.topRight,
        //           end: Alignment.bottomLeft,
        //           colors: [
        //             Color(0xFFFE6A7E).withOpacity(0.65),
        //             Color(0xFFFE6A7E),
        //           ],
        //         ),
        //       ),
        //     ),
        //     onTap: () async {
        //       Map<String, dynamic> body = {
        //         'nama_kegiatan': schedule.namaKegiatan,
        //         'detail_kegiatan': schedule.detailKegiatan,
        //         'tanggal': schedule.tanggal.toString(),
        //         'tempat': schedule.tempat,
        //         'nama_client': schedule.namaClient,
        //         'jam': schedule.jam,
        //         'status': "done",
        //       };

        //       await ScheduleService.updateSchedule(schedule.id, body)
        //           .then((value) {
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //               builder: (context) => BaseScreen(index: 1)),
        //         );
        //         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        //             content:
        //                 Text('You have successfully update a scedule')));
        //       });
        //     }),
      ]),
    );
  }
}
