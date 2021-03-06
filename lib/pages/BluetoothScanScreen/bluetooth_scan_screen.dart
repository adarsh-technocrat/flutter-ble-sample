import 'package:flutter/material.dart';
import 'package:flutter_ble_sample/bloc/BleDeviceBloc/ble_device_cubit.dart';
import 'package:flutter_ble_sample/bloc/BleDeviceBloc/ble_device_state.dart';
import 'package:flutter_ble_sample/components/bluetooth_on_of_layout.dart';
import 'package:flutter_ble_sample/components/bluetooth_scan_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class BluetoothConnectionScreen extends StatefulWidget {
  const BluetoothConnectionScreen({Key? key}) : super(key: key);

  @override
  State<BluetoothConnectionScreen> createState() =>
      _BluetoothConnectionScreenState();
}

class _BluetoothConnectionScreenState extends State<BluetoothConnectionScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BleDeviceCubit, BleDeviceState>(
      builder: (context, state) {
        final provider = BlocProvider.of<BleDeviceCubit>(context);
        return BluetoothOnOfLayout(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              iconTheme: const IconThemeData(color: Colors.black),
              title: const Text(
                "Bluetooth Scanning",
                style: TextStyle(color: Colors.black),
              ),
              elevation: 0,
              leading: BackButton(
                color: Colors.black,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () {
                      if (state.isScanning == true) {
                        provider.stopScanningBluetoothDevice();
                      } else {
                        provider.initiatBluethoothScanning();
                      }
                    },
                    child: Text(
                      state.isScanning == true
                          ? "Stop Scanning"
                          : "Start Scanning",
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                )
              ],
            ),
            body: SingleChildScrollView(
                child: Column(
              children: [
                StreamBuilder<List<ScanResult>>(
                    stream: provider.flutterBlue.scanResults,
                    builder: (context, snapshot) {
                      var data = snapshot.data;
                      if (snapshot.hasData) {
                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: data?.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:
                                  BluetoothScanCard(scanResult: data![index]),
                            );
                          },
                        );
                      }
                      return Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 3.5),
                        child: Center(
                          child: SizedBox(
                            height: 150,
                            child: Image.asset(
                              "assets/icons/bluetooth-x.png",
                              height: 100,
                              color: Colors.black.withOpacity(0.2),
                            ),
                          ),
                        ),
                      );
                    }),
                const SizedBox(height: 10),
                state.isScanning == true
                    ? const SpinKitThreeBounce(
                        color: Colors.black,
                        size: 22,
                      )
                    : const SizedBox(),
                const SizedBox(height: 10),
              ],
            )),
          ),
        );
      },
    );
  }
}
