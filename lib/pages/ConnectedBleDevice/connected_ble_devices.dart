import 'package:flutter/material.dart';
import 'package:flutter_ble_sample/components/bluetooth_on_of_layout.dart';

class ConnectedBleDevice extends StatefulWidget {
  const ConnectedBleDevice({Key? key}) : super(key: key);

  @override
  State<ConnectedBleDevice> createState() => _ConnectedBleDeviceState();
}

class _ConnectedBleDeviceState extends State<ConnectedBleDevice> {
  @override
  Widget build(BuildContext context) {
    return BluetoothOnOfLayout(child: Container());
  }
}
