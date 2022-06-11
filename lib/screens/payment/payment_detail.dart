import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wedding_planner/screens/payment/payment_screen.dart';
import 'package:wedding_planner/model/paymentDetailModel.dart';
import 'package:wedding_planner/model/paymentModel.dart';
import 'package:wedding_planner/service/paymentDetailService.dart';
import 'package:wedding_planner/components/formatAngka.dart';
import 'package:intl/intl.dart';
import 'package:wedding_planner/navbar/navbar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wedding_planner/screens/payment/payment_screen.dart';

class detailPayment extends StatefulWidget {
  static final url = "/detail-payment";
  const detailPayment({Key? key}) : super(key: key);

  @override
  State<detailPayment> createState() => _detailPaymentState();
}

class _detailPaymentState extends State<detailPayment> {
  late Future<PaymentDetail> _payments;
  int id = 0;
  int totalBayar = 0;
  int unpaid = 0;
  int totalData = 0;
  bool cek = false;

  @override
  void initState() {
    super.initState();
    _payments = PaymentDetailService().getAllPaymentDetail();
  }

  void refreshData() {
    id++;
  }

  FutureOr onGoBack(dynamic value) {
    refreshData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final payments payment =
        ModalRoute.of(context)!.settings.arguments as payments;

    String tanggalPayment = DateFormat.yMd().format(payment.tanggal);
    unpaid = int.parse(payment.tunaiKeseluruhan);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 70,
                  child: Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BaseScreen(index: 2)),
                            );
                          },
                          child: Icon(Icons.arrow_back)),
                      SizedBox(width: 50),
                      Text(
                        "Detail Payment",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                      SizedBox(width: 50),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const PaymentPage(),
                                ));
                          },
                          icon: Icon(Icons.list))
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  height: 115,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/bg.png"),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                payment.namaClient,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(width: 120),
                              Text(
                                payment.keterangan,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tanggalPayment,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300),
                              ),
                              Text(
                                formatAngka.convertToIdr(
                                    int.parse(payment.tunaiKeseluruhan), 2),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25),
                FutureBuilder(
                  future: _payments,
                  builder: (context, AsyncSnapshot<PaymentDetail> snapshot) {
                    var state = snapshot.connectionState;
                    if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var payment_detail = snapshot.data!.data[index];
                          if (payment_detail.idPayment == payment.id) {
                            totalBayar += int.parse(payment_detail.bayar);
                            unpaid -= int.parse(payment_detail.bayar);
                            totalData++;
                          }
                          if (totalData < snapshot.data!.data.length) {
                            return SizedBox();
                          } else {
                            return Row(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 45,
                                      height: 45,
                                      decoration: BoxDecoration(
                                          // gradient: LinearGradient(
                                          //   begin: Alignment.topRight,
                                          //   end: Alignment.bottomLeft,
                                          //   colors: [
                                          //     Color(0xFF8CDA8A).withOpacity(0.65),
                                          //     Color(0xFFFFFFFF),
                                          //   ],
                                          // ),
                                          color: Color(0xFF8CDA8A)
                                              .withOpacity(0.65),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text(
                                        "Already Paid",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        formatAngka.convertToIdr(totalBayar, 2),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 15),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(width: 20),
                                Row(
                                  children: [
                                    Container(
                                      width: 45,
                                      height: 45,
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topRight,
                                            end: Alignment.bottomLeft,
                                            colors: [
                                              Color(0xFFFE6A7E)
                                                  .withOpacity(0.65),
                                              Color(0xFFFE6A7E),
                                            ],
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Icon(
                                        Icons.navigate_next,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text(
                                        "Unpaid",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        formatAngka.convertToIdr(unpaid, 2),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 15),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            );
                          }
                        },
                        itemCount: snapshot.data!.data.length,
                      );
                    } else {
                      return Text('');
                    }
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Container(
                      child: Text("Transactions"),
                    ),
                    SizedBox(width: 200),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const PaymentPage()),
                              );
                            },
                            child: Icon(Icons.plumbing)),
                      ],
                    ),
                  ],
                ),
                FutureBuilder(
                  future: _payments,
                  builder: (context, AsyncSnapshot<PaymentDetail> snapshot) {
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
                            var payment_detail = snapshot.data!.data[index];

                            return SizedBox(
                              child: payment_detail.idPayment == payment.id
                                      ? listItem(payment_detail)
                                      : SizedBox(),
                            );
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
          ),
        ),
      ),
    );
  }

  Widget listItem(PaymentDetails paymentDetail) {
    String tanggal = DateFormat.yMd().format(paymentDetail.tanggal);
    cek = true;

    return Row(
      children: [
        Expanded(
          child: ListTile(
            leading: FlutterLogo(),
            title: Text(
              "Paid for " + paymentDetail.paymentFor,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
            subtitle: Text(tanggal),
            trailing: Text(
                formatAngka.convertToIdr(int.parse(paymentDetail.bayar), 2)),
          ),
        ),
      ],
    );
  }
}
