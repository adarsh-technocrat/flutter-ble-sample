import 'package:flutter_blue/flutter_blue.dart';

class FirebaseState {
  // List<BluetoothDevice> devicesList;
  List<BluetoothService> services;
  BluetoothDevice? connectedDevice;
  bool? isScanning;
  String batteryLevel;

  FirebaseState({
    // this.devicesList = const [],
    this.services = const [],
    this.connectedDevice,
    this.isScanning,
    this.batteryLevel = "0",
  });

  FirebaseState copyWith({
    // List<BluetoothDevice>? devicesList,
    List<BluetoothService>? services,
    BluetoothDevice? connectedDevice,
    bool? isScanning,
    String? batteryLevel,
  }) {
    return FirebaseState(
        services: services ?? this.services,
        connectedDevice: connectedDevice ?? this.connectedDevice,
        isScanning: isScanning ?? this.isScanning,
        batteryLevel: batteryLevel ?? this.batteryLevel);
  }
}
