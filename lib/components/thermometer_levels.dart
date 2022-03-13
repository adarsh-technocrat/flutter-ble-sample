import 'package:flutter/material.dart';
import 'package:flutter_ble_sample/bloc/BleDeviceBloc/ble_device_state.dart';

class ThermometerLevels extends StatelessWidget {
  final BleDeviceState state;

  const ThermometerLevels({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return state.services.isNotEmpty
        ? Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: StreamBuilder<List<int>>(
                stream: state.services[2].characteristics[0].value,
                initialData: state.services[2].characteristics[0].lastValue,
                builder: (context, snapshot) {
                  final value = snapshot.data!.isEmpty ? 0 : snapshot.data![0];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "🌡️",
                        style: TextStyle(fontSize: 40),
                      ),
                      Text(
                        "$value\u2103",
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
              padding: const EdgeInsets.all(50.0),
              child: SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text(
                      "🌡️",
                      style: TextStyle(fontSize: 40),
                    ),
                    Text(
                      "0\u2103",
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
