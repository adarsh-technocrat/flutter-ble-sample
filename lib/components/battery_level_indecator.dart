import 'package:flutter/material.dart';
import 'package:flutter_ble_sample/bloc/BleDeviceBloc/ble_device_state.dart';
import 'package:flutter_ble_sample/server/notification_Service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/BleDeviceBloc/ble_device_cubit.dart';

class BatteryLevelIndicator extends StatefulWidget {
  final BleDeviceState state;

  const BatteryLevelIndicator({Key? key, required this.state})
      : super(key: key);

  @override
  State<BatteryLevelIndicator> createState() => _BatteryLevelIndicatorState();
}

class _BatteryLevelIndicatorState extends State<BatteryLevelIndicator> {
  @override
  Widget build(BuildContext context) {
    return widget.state.services.isNotEmpty
        ? Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: StreamBuilder<List<int>>(
                stream: widget.state.services[2].characteristics[0].value,
                initialData:
                    widget.state.services[2].characteristics[0].lastValue,
                builder: (context, snapshot) {
                  final value = snapshot.data!.isEmpty ? 0 : snapshot.data![0];
                  if (value == 100) {
                    NotificationService().showNotifications(
                      'Battery successful charged',
                      '',
                      "",
                    );
                  }

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "🔋",
                        style: TextStyle(fontSize: 40),
                      ),
                      Text(
                        "$value%",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 80,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  );
                },
              ),
            ),
          )
        : Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text(
                      "🔋",
                      style: TextStyle(fontSize: 40),
                    ),
                    Text(
                      "0%",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 80,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
