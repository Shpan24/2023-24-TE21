// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Razorpay Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: RazorpayDemo(),
//     );
//   }
// }

class RazorpayDemo extends StatefulWidget {
  @override
  _RazorpayDemoState createState() => _RazorpayDemoState();
}

class _RazorpayDemoState extends State<RazorpayDemo> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _initializeRazorpay();
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void _initializeRazorpay() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Handle payment success
    print("Payment Successful: ${response.paymentId}");
    // You can navigate to a success page or perform other actions here
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Handle payment failure
    print("Payment Error: ${response.code} - ${response.message}");
    // You can display an error message or perform other actions here
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Handle external wallet payments (e.g., Paytm, PhonePe)
    print("External Wallet: ${response.walletName}");
    // You can perform specific actions for external wallet payments here
  }

  void _startPayment() {
    var options = {
      'key':
          'rzp_test_nxsIPa0CsV1gO6', // Replace with your actual Razorpay API key
      'amount': 10000, // Amount in paise (Example: 10000 = ₹100)
      'name': 'Breakdown Buddy',
      'description': 'Test Payment',
      'prefill': {'contact': '9876543210', 'email': 'example@example.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(75, 57, 239, 0.911),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Title(
            color: Colors.white,
            child: Text('Razorpay',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 24.0,
                ))),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _startPayment,
          child: Text('Make Payment'),
        ),
      ),
    );
  }
}
