import 'package:flutter/material.dart';
import 'package:flutter_ble_sample/bloc/BleDeviceBloc/ble_device_cubit.dart';
import 'package:flutter_ble_sample/bloc/BleDeviceBloc/ble_device_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class BluetoothScanCard extends StatefulWidget {
  final BluetoothDevice device;
  final BleDeviceState state;
  const BluetoothScanCard({Key? key, required this.device, required this.state})
      : super(key: key);

  @override
  State<BluetoothScanCard> createState() => _BluetoothScanCardState();
}

class _BluetoothScanCardState extends State<BluetoothScanCard> {
  bool isLoading = false;
  BluetoothDevice? connectedDevice;
  @override
  Widget build(BuildContext context) {
    final provider = BlocProvider.of<BleDeviceCubit>(context);
    return Container(
      color: Colors.white,
      height: 85,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.bluetooth,
                      size: 30,
                    )),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.device.name == ''
                          ? 'unknown device'
                          : widget.device.name,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    const SizedBox(height: 5),
                    Text(widget.device.id.toString()),
                  ],
                )
              ],
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
                backgroundColor: widget.state.connectedDevice != null
                    ? const Color(0xff0E3300)
                    : Colors.black),
            child: isLoading
                ? SizedBox(height: 20, child: spinkit)
                : Text(
                    widget.state.connectedDevice != null
                        ? "Disconnect"
                        : 'Connect',
                    style: const TextStyle(color: Colors.white),
                  ),
            onPressed: () async {
              if (widget.state.connectedDevice != null) {
                await provider.disconnecteBluetoothDevice(widget.device);
              } else {
                await provider.connectToBluetoothDevice(widget.device);
              }
            },
          ),
        ],
      ),
    );
  }

  final spinkit = const SpinKitThreeBounce(
    color: Colors.white,
    size: 10.0,
  );
}
