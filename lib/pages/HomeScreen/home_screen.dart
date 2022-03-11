import 'package:flutter/material.dart';
import 'package:flutter_ble_sample/bloc/BleDeviceBloc/ble_device_cubit.dart';
import 'package:flutter_ble_sample/bloc/BleDeviceBloc/ble_device_state.dart';
import 'package:flutter_ble_sample/pages/BluetoothScanScreen/bluetooth_scan_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BleDeviceCubit, BleDeviceState>(
      builder: (context, state) {
        final provider = BlocProvider.of<BleDeviceCubit>(context);
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: const Text(
              "BLE Sample App",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,
            actions: [
              IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.devicesList.isNotEmpty
                          ? "Syncing.. " +
                              state.devicesList[0].name +
                              " Battery levels with cloud"
                          : "Connect to peripheral device to perform this operation !"),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.cloud_sync_outlined,
                  color: Colors.black,
                  size: 30,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const BluetoothConnectionScreen()));
                },
                icon: const Icon(
                  Icons.bluetooth,
                  color: Colors.black,
                ),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [],
              ),
            ),
          ),
        );
      },
    );
  }
}
