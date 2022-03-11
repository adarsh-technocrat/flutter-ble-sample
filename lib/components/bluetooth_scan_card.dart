import 'package:flutter/material.dart';
import 'package:flutter_ble_sample/bloc/BleDeviceBloc/ble_device_cubit.dart';
import 'package:flutter_ble_sample/widgets/common_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class BluetoothScanCard extends StatefulWidget {
  final ScanResult scanResult;
  const BluetoothScanCard({
    Key? key,
    required this.scanResult,
  }) : super(key: key);

  @override
  State<BluetoothScanCard> createState() => _BluetoothScanCardState();
}

class _BluetoothScanCardState extends State<BluetoothScanCard> {
  bool isLoading = false;
  BluetoothDevice? connectedDevice;
  CommonWidgets commonWidgets = CommonWidgets();

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
                      widget.scanResult.device.name == ''
                          ? 'unknown device'
                          : widget.scanResult.device.name,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    const SizedBox(height: 5),
                    Text(widget.scanResult.device.id.toString()),
                  ],
                )
              ],
            ),
          ),
          ElevatedButton(
            style: TextButton.styleFrom(
                backgroundColor: widget.scanResult.advertisementData.connectable
                    ? connectedDevice != null
                        ? const Color(0xff0E3300)
                        : Colors.black
                    : Colors.grey,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0))),
            child: isLoading
                ? SizedBox(height: 20, child: spinkit)
                : Text(
                    connectedDevice != null ? "Disconnect" : 'Connect',
                    style: const TextStyle(color: Colors.white),
                  ),
            onPressed: () async {
              if (widget.scanResult.advertisementData.connectable) {
                if (connectedDevice != null) {
                  await provider
                      .disconnecteBluetoothDevice(widget.scanResult.device);
                  setState(() {
                    connectedDevice = null;
                  });

                  commonWidgets.snackBar(
                      context, "Disconneted " + widget.scanResult.device.name);
                } else {
                  setState(() {
                    isLoading = true;
                  });
                  await provider
                      .connectToBluetoothDevice(widget.scanResult.device)
                      .then((device) {
                    commonWidgets.snackBar(context,
                        "Connected to  " + widget.scanResult.device.name);
                    setState(() {
                      connectedDevice = device;
                    });
                  });
                  setState(() {
                    isLoading = false;
                  });
                }
              } else {
                commonWidgets.snackBar(context, "Device is not Connectable !!");
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
