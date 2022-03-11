import 'package:flutter/material.dart';
import 'package:flutter_ble_sample/bloc/BleDeviceBloc/ble_device_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BleDeviceCubit extends Cubit<BleDeviceState> {
  BleDeviceCubit() : super(BleDeviceState());

  final FlutterBlue flutterBlue = FlutterBlue.instance;

  List<BluetoothDevice> listOfDevices = [];

  final Map<Guid, List<int>> readValues = <Guid, List<int>>{};

  ///  [Adding Available Bluetooth Device to Global State ]

  // addDeviceTolist(final BluetoothDevice device) {
  //   if (!state.devicesList.contains(device)) {
  //     listOfDevices.add(device);
  //   }
  //   emit(state.copyWith(devicesList: listOfDevices));
  // }

  ///  [Initiate Bluetooth Scanning Function]

  initiatBluethoothScanning() {
    // flutterBlue.connectedDevices
    //     .asStream()
    //     .listen((List<BluetoothDevice> devices) {
    //   debugPrint(devices.length.toString());
    //   for (BluetoothDevice device in devices) {
    //     addDeviceTolist(device);
    //   }
    // });
    // flutterBlue.scanResults.listen((List<ScanResult> results) {
    //   for (ScanResult result in results) {
    //     debugPrint(result.device.toString());
    //     addDeviceTolist(result.device);
    //   }
    // });
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

  syncBatteryLevelsToCloud() {}

  /// [Get Realtime Battery Levels from Cloud ]

  getRealTimeCloudBatteryLevels() {}

  /// [Stop Scanning Bluetooth Device]
  stopScanningBluetoothDevice() {
    flutterBlue.stopScan();
  }
}
