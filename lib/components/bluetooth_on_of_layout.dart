import 'package:flutter/material.dart';
import 'package:flutter_ble_sample/bloc/BleDeviceBloc/ble_device_cubit.dart';
import 'package:flutter_ble_sample/components/bluetooth_off_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BluetoothOnOfLayout extends StatelessWidget {
  final Widget child;

  const BluetoothOnOfLayout({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = BlocProvider.of<BleDeviceCubit>(context);
    return SizedBox(
      child: StreamBuilder<BluetoothState>(
        stream: provider.flutterBlue.state,
        initialData: BluetoothState.unknown,
        builder: (c, snapshot) {
          final state = snapshot.data;
          if (state == BluetoothState.on) {
            return child;
          }
          return BluetoothOffScreen(state: state);
        },
      ),
    );
  }
}
