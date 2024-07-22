import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_test/class/common/token_mixin.dart';
import 'package:qr_test/class/bloc/fetch/fetch_bloc.dart';
import 'package:qr_test/class/bloc/fetch/stations_data.dart';
import 'package:qr_test/widget/page/station_data_page.dart';

class StationListViewBloc extends StatelessWidget with Token {
  final int category;
  const StationListViewBloc({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FetchBloc>(
      create: (context) => FetchBloc(),
      child: BlocBuilder<FetchBloc, FetchState>(
        builder: (BuildContext context, FetchState<dynamic> state) {
          //pre fetch
          if (state is FetchInitial) {
            return Column(
              children: [
                const Text("Pre Fetch"),
                TextButton(
                  onPressed: () => {
                    BlocProvider.of<FetchBloc>(context).add(FetchStations(
                        url: 'http://10.88.10.104:3000/api/graph/stations',
                        body: <String, dynamic>{'category': category}))
                  },
                  child: const Text("Fetch"),
                )
              ],
            );
          }

          if (state is FetchError) {
            return Text(state.error);
          }

          if (state is FetchLoading) {
            return const CircularProgressIndicator();
          }

          //listview here
          if (state is FetchCompleted) {
            // final stations = state.data as StationsData;
            // final Data station = Data.fromJson(state.data[0]);

            // // return Text(stations.data![0].name!);
            // return Text(station.tablename!);

            return SizedBox(
              height: 200,
              child: ListView.builder(
                  itemCount: state.data.length,
                  prototypeItem: const ListTile(title: Text("Place Holder")),
                  itemBuilder: (context, index) {
                    final Data station = Data.fromJson(state.data[index]);
                    return ListTile(
                      title: Text(station.name!),
                      tileColor: Colors.blue[100],
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => StationDataPage(station: station,))
                        );
                      },
                    );
                  }),
            );
          }

          //place holder
          return const SizedBox();
        },
      ),
    );
  }
}
