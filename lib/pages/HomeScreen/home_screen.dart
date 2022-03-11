import 'package:flutter/material.dart';
import 'package:flutter_ble_sample/bloc/BleDeviceBloc/ble_device_cubit.dart';
import 'package:flutter_ble_sample/bloc/BleDeviceBloc/ble_device_state.dart';
import 'package:flutter_ble_sample/components/bluetooth_on_of_layout.dart';
import 'package:flutter_ble_sample/pages/BluetoothScanScreen/bluetooth_scan_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                    provider.notifyBatteryLevels();
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
                    state.services.isNotEmpty
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.all(50.0),
                              child: StreamBuilder<List<int>>(
                                  stream: state
                                      .services[2].characteristics[0].value,
                                  initialData: state
                                      .services[2].characteristics[0].lastValue,
                                  builder: (context, snapshot) {
                                    final value = snapshot.data!.isEmpty
                                        ? 0
                                        : snapshot.data![0];
                                    return Text(
                                      "$value%",
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 80,
                                          fontWeight: FontWeight.bold),
                                    );
                                  }),
                            ),
                          )
                        : const Center(
                            child: Padding(
                              padding: EdgeInsets.all(50.0),
                              child: SizedBox(
                                child: Text(
                                  "0%",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 80,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                    const Text(
                      "Cloude Sync Data (update every 5 sec)",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline),
                    ),
                    const SizedBox(height: 20),
                    ListView.builder(
                        itemCount: 2,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return const Card(
                            child: ListTile(
                              title: Text("Battery Level"),
                              subtitle: Text("Date time"),
                              trailing: Text("20%"),
                            ),
                          );
                        })
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.all(20)),
                child: const Text(
                  "Battery Levels",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  provider.getWatchBatteryLevels();
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
