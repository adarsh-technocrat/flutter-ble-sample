import 'package:flutter_blue/flutter_blue.dart';

class BleDeviceState {
  // List<BluetoothDevice> devicesList;
  List<BluetoothService> services;
  BluetoothDevice? connectedDevice;
  bool? isScanning;
  String batteryLevel;

  BleDeviceState({
    // this.devicesList = const [],
    this.services = const [],
    this.connectedDevice,
    this.isScanning,
    this.batteryLevel = "0",
  });

  BleDeviceState copyWith({
    // List<BluetoothDevice>? devicesList,
    List<BluetoothService>? services,
    BluetoothDevice? connectedDevice,
    bool? isScanning,
    String? batteryLevel,
  }) {
    return BleDeviceState(
        // devicesList: devicesList ?? this.devicesList,
        services: services ?? this.services,
        connectedDevice: connectedDevice ?? this.connectedDevice,
        isScanning: isScanning ?? this.isScanning,
        batteryLevel: batteryLevel ?? this.batteryLevel);
  }
}
