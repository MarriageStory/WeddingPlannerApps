// ignore_for_file: prefer_const_constructors, duplicate_ignore, prefer_const_literals_to_create_immutables
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'components/cards_payment.dart';
import 'package:wedding_planner/screens/payment/payment_detail.dart';
import 'package:wedding_planner/components/formatAngka.dart';
import 'package:wedding_planner/model/paymentModel.dart';
import 'package:wedding_planner/service/paymentService.dart';
import 'package:wedding_planner/screens/payment/payment_add.dart';

class PaymentPage extends StatefulWidget {
  static const routeName = '/payment';

  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late Future<Payment> _payments;
  int id = 0;
  int allPayment = 0;
  int Paymentdone = 0;
  int totalData = 0;
  bool cek = false;

  @override
  void initState() {
    super.initState();
    _payments = PaymentService().getAllPayment();
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: ListView(children: <Widget>[
          // AppBar
          Container(
            height: 140,
            width: size.width,
            padding: EdgeInsets.symmetric(vertical: 20),
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                  Color(0xFFFC9DA1),
                  Color(0xFFFE6A7E),
                ])),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: size.width * 0.3,
                ),
                Container(
                  width: size.width * 0.3,
                  child: Text(
                    'Payment',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  width: size.width * 0.3,
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddPayment()),
                        );
                      },
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      )),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15.0,
          ),

          //Cards
          FutureBuilder(
            future: _payments,
            builder: (context, AsyncSnapshot<Payment> snapshot) {
              var state = snapshot.connectionState;
              if (snapshot.hasData) {
                if (snapshot.data!.data.length > 0) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var payment = snapshot.data!.data[index];
                      allPayment++;
                      totalData++;
                      if (payment.keterangan == "done") {
                        Paymentdone++;
                      }
                      if (totalData < snapshot.data!.data.length) {
                        return SizedBox();
                      } else {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Container(
                                  width: 160,
                                  height: 160,
                                  padding: EdgeInsets.all(30.0),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.bottomRight,
                                        end: Alignment.topLeft,
                                        colors: [
                                          Color(0xFFFC9DA1),
                                          Color(0xFFFE6A7E),
                                        ]),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Payment Done',
                                        overflow: TextOverflow.ellipsis,
                                        // ignore: prefer_const_constructors
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 40.0,
                                      ),
                                      Text(
                                        Paymentdone.toString(),
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  width: 160,
                                  height: 160,
                                  padding: EdgeInsets.all(30.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white70,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'All Payment',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 40.0,
                                      ),
                                      Text(
                                        allPayment.toString(),
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      }
                    },
                    itemCount: snapshot.data!.data.length,
                  );
                } else {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 160,
                            height: 160,
                            padding: EdgeInsets.all(30.0),
                            decoration: BoxDecoration(
                              color: Colors.pink[200],
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Payment Done',
                                  // ignore: prefer_const_constructors
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 40.0,
                                ),
                                Text(
                                  Paymentdone.toString(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            width: 160,
                            height: 160,
                            padding: EdgeInsets.all(30.0),
                            decoration: BoxDecoration(
                              color: Colors.white70,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'All Payment',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                SizedBox(
                                  height: 40.0,
                                ),
                                Text(
                                  allPayment.toString(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }
              } else {
                return Text('');
              }
            },
          ),
          SizedBox(
            height: 5.0,
          ),

          Expanded(
            child: Container(
              padding: EdgeInsets.all(25.0),
              child: Center(
                child: Column(
                  children: [
                    //Heading payment
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Payment in Progress ',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12.0,
                    ),

                    // List view payment
                    FutureBuilder(
                      future: _payments,
                      builder: (context, AsyncSnapshot<Payment> snapshot) {
                        var state = snapshot.connectionState;
                        if (state != ConnectionState.done) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                var payment = snapshot.data!.data[index];
                                return InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, detailPayment.url,
                                        arguments: payment);
                                  },
                                  child: listItem(payment),
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
        ]),
      ),
      bottomNavigationBar: BottomAppBar(),
    );
  }

  Widget listItem(payments view) {
    cek = true;
    String tanggal = DateFormat.yMd().format(view.tanggal);

    return Column(
      children: [
        CardsPayment(
          name: view.namaClient,
          date: tanggal,
          pay: formatAngka.convertToIdr(int.parse(view.tunaiKeseluruhan), 2),
          color:
              view.keterangan != "done" ? Colors.amber[600] : Colors.green[600],
          status: view.keterangan != "done" ? 'Pending' : 'Done',
        ),
      ],
    );
  }
}
