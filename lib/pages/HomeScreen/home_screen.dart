import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ble_sample/bloc/BleDeviceBloc/ble_device_cubit.dart';
import 'package:flutter_ble_sample/bloc/BleDeviceBloc/ble_device_state.dart';
import 'package:flutter_ble_sample/components/battery_level_indecator.dart';
import 'package:flutter_ble_sample/components/bluetooth_on_of_layout.dart';
import 'package:flutter_ble_sample/components/cloud_sync_battery_level_card.dart';
import 'package:flutter_ble_sample/pages/BluetoothScanScreen/bluetooth_scan_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void dispose() {
    final provider = BlocProvider.of<BleDeviceCubit>(context);
    provider.disposeTimerInstance();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BleDeviceCubit, BleDeviceState>(
      builder: (context, state) {
        final provider = BlocProvider.of<BleDeviceCubit>(context);
        return BluetoothOnOfLayout(
          child: Scaffold(
            backgroundColor: Colors.white,
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
                    provider.syncBatteryLevelsToCloud(context);
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
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BatteryLevelIndicator(state: state),
                    // ThermometerLevels(state: state),
                    const SizedBox(height: 50),
                    const Text(
                      "Cloude Sync Data (update every 15 sec)",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline),
                    ),

                    const SizedBox(height: 20),
                    const Text(
                      "Battery Levels",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const CloudSyncBatteryLevelCard()
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.black,
                          padding: const EdgeInsets.all(20)),
                      child: const Text(
                        "Thermometer Levels",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        provider.getWatchBatteryLevels();
                      },
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.black,
                          padding: const EdgeInsets.all(20)),
                      child: const Text(
                        "Battery Levels",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        provider.notifyBatteryLevels();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
