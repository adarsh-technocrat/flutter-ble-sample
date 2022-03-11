import 'package:flutter_blue/flutter_blue.dart';

class BleDeviceState {
  List<BluetoothDevice> devicesList;
  List<BluetoothService> services;
  BluetoothDevice? connectedDevice;
  bool? isScanning;

  BleDeviceState(
      {required this.devicesList,
      required this.services,
      this.connectedDevice,
      this.isScanning});

  BleDeviceState copyWith({
    List<BluetoothDevice>? devicesList,
    List<BluetoothService>? services,
    BluetoothDevice? connectedDevice,
    bool? isScanning,
  }) {
    return BleDeviceState(
        devicesList: devicesList ?? this.devicesList,
        services: services ?? this.services,
        connectedDevice: connectedDevice ?? this.connectedDevice,
        isScanning: isScanning ?? this.isScanning);
  }
}
