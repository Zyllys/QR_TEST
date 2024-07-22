import 'package:flutter/material.dart';
import 'package:qr_test/class/bloc/fetch/stations_data.dart';

class StationDataPage extends StatelessWidget {
  //TODO: rename Data class name
  final Data station;

  const StationDataPage({super.key, required this.station});
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title:  Text(station.name!),
        centerTitle: true,
      ),
      body: Container()
    );
  }

}