import 'dart:developer';
import 'package:employer_v1/payment_configurations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pay/pay.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:upi_payment_flutter/upi_payment_flutter.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class RazorPay extends StatefulWidget {
  const RazorPay({super.key});

  @override
  State<RazorPay> createState() => _RazorPayState();
}

class _RazorPayState extends State<RazorPay> {
  late Razorpay _razorpay;
  late UpiPaymentHandler upiPaymentHandler;

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    log(response.toString());
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    log(response.toString());
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

  @override
  Widget build(BuildContext context) {
    // var options = {
    //   'key': 'rzp_test_3DdsTROk4aScJx',
    //   'amount': 100,
    //   'name': 'Acme Corp.',
    //   'description': 'Fine T-Shirt',
    //   'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
    //   'external': {
    //     'wallets': ['paytm']
    //   },
    // };
    var options = {
      // 'key': 'rzp_test_AQVSMKeAc1YtdQ',
      'key': 'rzp_test_3DdsTROk4aScJx',
      'amount': 100,
      'name': 'Employee',
      'description': 'Employee des',
      'send_sms_hash': true,
      'prefill': {'contact': '9481089140', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              _razorpay.open(options);
            },
            child: Text('Press me')),
      ),
    );
  }
}
