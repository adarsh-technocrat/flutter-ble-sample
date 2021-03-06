import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ble_sample/bloc/BleDeviceBloc/ble_device_state.dart';
import 'package:flutter_ble_sample/widgets/common_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BleDeviceCubit extends Cubit<BleDeviceState> {
  BleDeviceCubit() : super(BleDeviceState());

  final FlutterBlue flutterBlue = FlutterBlue.instance;

  List<BluetoothDevice> listOfDevices = [];

  Timer? timer;

  CollectionReference collectionRef(String collection) {
    return FirebaseFirestore.instance.collection(collection);
  }

  CommonWidgets commonWidgets = CommonWidgets();

  ///  [Initiate Bluetooth Scanning Function]

  initiatBluethoothScanning() {
    flutterBlue.startScan(timeout: const Duration(seconds: 4));
    flutterBlue.isScanning.listen((scanning) {
      emit(state.copyWith(isScanning: scanning));
    });

    flutterBlue.startScan();
  }

  ///  [Connect Bluetooth Device Function]

  Future connectToBluetoothDevice(BluetoothDevice device) async {
    flutterBlue.stopScan();
    // device.disconnect();
    try {
      await device.connect();
    } catch (e) {
      debugPrint("Error:" + e.toString());
    } finally {
      device.discoverServices().then((services) {
        emit(state.copyWith(services: services));
      });
    }

    emit(state.copyWith(connectedDevice: device));
    return device;
  }

  /// [Disconnect Connected Bluetooth Device]

  disconnecteBluetoothDevice(BluetoothDevice device) async {
    await device.disconnect();
  }

  /// [Getting Battery Levels Of Watch]

  getWatchBatteryLevels() async {
    var c = state.services[2].characteristics[0];
    await c.read();
  }

  notifyBatteryLevels() async {
    var c = state.services[2].characteristics[0];
    await c.setNotifyValue(!c.isNotifying);
    await c.read();
  }

  /// [Background Function to Store Battery Levels to Cloude ]
  /// [For testing purpose hardcoded the values]

  syncBatteryLevelsToCloud(BuildContext context) {
    commonWidgets.snackBar(context, "Cloud syncing will perform evey 15 sec !");
    timer = Timer.periodic(const Duration(seconds: 15), (Timer t) {
      collectionRef("batteryLevels")
          .doc("5DG4qk2Kdpdf2xyiVDmi")
          .set({"dateTime": DateTime.now(), "value": state.batteryLevel});
    });
  }

  ///[Dispose Timer Instance]

  void disposeTimerInstance() {
    timer?.cancel();
  }

  /// [Get Realtime Battery Levels from Cloud ]

  getRealTimeCloudBatteryLevels() {}

  /// [Stop Scanning Bluetooth Device]
  stopScanningBluetoothDevice() {
    flutterBlue.stopScan();
  }
}
