import 'package:flutter/material.dart';
import 'package:flutter_ble_sample/components/bluetooth_on_of_layout.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../HomeScreen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2)).then(
      (value) => {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const HomeScreen()),
            (route) => false)
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const BluetoothOnOfLayout(
      child: Scaffold(
          body: Center(
        child: SizedBox(
            width: 250,
            child: SpinKitCircle(
              color: Colors.black,
            )),
      )),
    );
  }
}
