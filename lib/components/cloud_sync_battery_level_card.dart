import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ble_sample/bloc/BleDeviceBloc/ble_device_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';

class CloudSyncBatteryLevelCard extends StatelessWidget {
  const CloudSyncBatteryLevelCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = BlocProvider.of<BleDeviceCubit>(context);
    return StreamBuilder(
        stream: provider.collectionRef("batteryLevels").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            final DocumentSnapshot documentSnapshot = snapshot.data!.docs[0];
            Timestamp timestamp = documentSnapshot['dateTime'];
            DateTime dateTime = timestamp.toDate();
            return Card(
              child: ListTile(
                title: const Text("Battery Level"),
                subtitle: Text(Jiffy().startOf(Units.SECOND).from(dateTime)),
                trailing: Text(documentSnapshot['value'].toString() + "%"),
              ),
            );
          } else {
            return const SizedBox();
          }
        });
  }
}
