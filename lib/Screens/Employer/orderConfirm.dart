import 'dart:developer';

import 'package:employer_v1/Services/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:upi_payment_flutter/upi_payment_flutter.dart';
import 'package:wheel_chooser/wheel_chooser.dart';

import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderConfirm extends StatefulWidget {
  BuildContext ctx;
  String email;
  double distance;
  String text;
  int index;
  double price;
  Map<String, dynamic> contractDetails;
  OrderConfirm(
      {super.key,
      required this.ctx,
      required this.email,
      required this.distance,
      required this.text,
      required this.price,
      required this.index,
      required this.contractDetails});

  @override
  State<OrderConfirm> createState() => _OrderConfirmState();
}

class _OrderConfirmState extends State<OrderConfirm> {
  late Razorpay _razorpay;
  late UpiPaymentHandler upiPaymentHandler;
  final database = DatabaseService();
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds

    database
        .updateEmployeesContractPayment(widget.contractDetails['Code'],
            widget.email, List.filled(presentDays - paidDays, true))
        .then((value) => {log(value.toString())});
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    log(response.message.toString());
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
    log(response.toString());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay = Razorpay();
    upiPaymentHandler = UpiPaymentHandler();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    setState(() {
      presentDays = widget.contractDetails['Attendance'][widget.index].values
          .elementAt(0)
          .where((element) => element == true)
          .length;
      List paid = widget.contractDetails['Paid'];
      paid.forEach(
        (element) {
          if (element.keys.contains(widget.email))
            paidDays = element.values.toList()[0].length;
        },
      );
      amount = (presentDays - paidDays) *
          int.parse(widget.contractDetails['Hourly-Rate']);

      absentDays = widget.contractDetails['Attendance'][widget.index].values
          .elementAt(0)
          .where((element) => !element)
          .length;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear();
  }

  Future<void> initiateTransaction(double amount) async {
    try {
      bool success = await upiPaymentHandler.initiateTransaction(
        payeeVpa: '9481089140@paytm',
        payeeName: 'Ferme Merchant',
        transactionRefId: 'TXN123456',
        transactionNote: 'Test transaction',
        amount: amount,
      );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Transaction initiated successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Transaction initiation failed.')),
        );
      }
    } on PlatformException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.message}')),
      );
    }
  }

  void launchUPI() async {
    // Replace the placeholder values with the receiver's UPI ID and other information
    const String receiverUpiId = '9481089140@paytm'; // Receiver's UPI ID
    const String receiverName = "Ferme Owner";
    const String transactionId = "121212";
    const String yourRefId = "yourRefId";
    const String paymentDescription = "Ferme Products";
    const double amount = 100.00;
    const String currency = "INR";

    // Construct the UPI URL with the parameters
    const String upiUrl =
        "upi://pay?pa=$receiverUpiId&pn=$receiverName&mc=1234&tid=$transactionId&tr=$yourRefId&tn=$paymentDescription&am=$amount&cu=$currency";

    // Check if the URL can be launched
    if (await canLaunch(upiUrl)) {
      // Launch the UPI URL
      await launch(upiUrl);
    } else {
      // Handle error if the URL cannot be launched
      throw 'Could not launch UPI';
    }
  }

  int value = 0;
  double delCharge = 0;
  int amount = 1;
  int deduction = 0;
  int bonus = 0;
  int totat = 0;
  int paidDays = 0;
  double order_total = 0;
  int presentDays = 0;
  int absentDays = 0;
  void fireRazorPay(options) {
    log(options.toString());
    _razorpay.open(options);
  }

  @override
  Widget build(BuildContext context) {
    double petrol_price = widget.price;
    return presentDays - paidDays == 0
        ? AlertDialog(
            title: Text(
              "Alert",
              textAlign: TextAlign.center,
            ),
            titleTextStyle: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
            backgroundColor: Theme.of(context).colorScheme.primary,
            shape: const RoundedRectangleBorder(
                side: BorderSide(color: Colors.white, width: 2),
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                )),
            content: Text(
              'Payment for all ${presentDays + absentDays} days were successfull for ${widget.email}',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        : AlertDialog(
            backgroundColor: Colors.black87.withOpacity(0.4),
            surfaceTintColor: Colors.black87.withOpacity(0.4),
            title: Text(
              "Payment",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.white)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Attendance Summary',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total Days',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17),
                                  ),
                                  Text(
                                    '${widget.contractDetails['End-Date']}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Absent',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17),
                                  ),
                                  Text(
                                    '$absentDays',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Present',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17),
                                  ),
                                  Text(
                                    '$presentDays',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Start Date',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17),
                                  ),
                                  Text(
                                    '${widget.contractDetails['Start-Date']}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Daily Wages',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17),
                                  ),
                                  Text(
                                    '${widget.contractDetails['Hourly-Rate']}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Paid Days',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17),
                                  ),
                                  Text(
                                    '${paidDays}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.white)),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Amount',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17),
                              ),
                              Text(
                                'Rs. ${amount}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Bonus',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17),
                              ),
                              SizedBox(
                                child: Container(
                                  height: 40,
                                  width: 50,
                                  child: WheelChooser.integer(
                                    magnification: 0.8,
                                    itemSize: 30,
                                    selectTextStyle:
                                        TextStyle(color: Colors.white),
                                    unSelectTextStyle:
                                        TextStyle(color: Colors.white),
                                    onValueChanged: (i) => {
                                      setState(
                                        () {
                                          bonus = i;
                                          totat = amount + bonus - deduction;
                                        },
                                      )
                                    },
                                    maxValue: 1000,
                                    minValue: 0,
                                    isInfinite: true,
                                    step: 5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Deduction',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17),
                              ),
                              Row(
                                children: [
                                  Text(
                                    '-',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  SizedBox(
                                    child: Container(
                                      height: 40,
                                      width: 50,
                                      child: WheelChooser.integer(
                                        magnification: 0.8,
                                        itemSize: 30,
                                        selectTextStyle:
                                            TextStyle(color: Colors.white),
                                        unSelectTextStyle:
                                            TextStyle(color: Colors.white),
                                        onValueChanged: (i) => {
                                          setState(
                                            () {
                                              deduction = i;
                                              totat =
                                                  amount + bonus - deduction;
                                            },
                                          )
                                        },
                                        maxValue: 1000,
                                        minValue: 0,
                                        isInfinite: true,
                                        step: 5,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17),
                              ),
                              Text(
                                'Rs. ${amount + bonus - deduction}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        var options = {
                          // 'key': 'rzp_test_AQVSMKeAc1YtdQ',
                          'key': 'rzp_test_3DdsTROk4aScJx',
                          'amount': totat * 100,
                          'name': widget.email,
                          'description': widget.contractDetails['Job-Titles'],
                          'send_sms_hash': true,
                          'prefill': {
                            'contact': '9481089140',
                            'email': 'test@razorpay.com'
                          },
                          'external': {
                            'wallets': ['paytm']
                          }
                        };
                        fireRazorPay(options);
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.white)),
                        width: double.infinity,
                        height: 40,
                        child: Center(
                          child: Text(
                            'Pay Now',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(widget.ctx);
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.white)),
                        width: double.infinity,
                        height: 40,
                        child: Center(
                          child: Text(
                            'Back',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          );
  }
}
