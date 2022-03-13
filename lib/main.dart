import 'dart:isolate';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ble_sample/bloc/BleDeviceBloc/ble_device_cubit.dart';
import 'package:flutter_ble_sample/bloc/firebaseBolc/firebase_cubit.dart';
import 'package:flutter_ble_sample/pages/SplashScreen/splash_screen.dart';
import 'package:flutter_ble_sample/server/notification_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // initialise the flutter local notification plugin
  await NotificationService().initialiseNotificationPlugin();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BleDeviceCubit>(create: (_) => BleDeviceCubit()),
        BlocProvider<FirebaseCubit>(create: (_) => FirebaseCubit())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter BLE Sample',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
