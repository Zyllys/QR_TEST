import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_test/class/common/token_mixin.dart';
import 'package:qr_test/class/bloc/fetch/fetch_bloc.dart';
import 'package:qr_test/class/bloc/fetch/stations_data.dart';

class StationListViewBloc extends StatelessWidget with Token {
  final int category;
  const StationListViewBloc({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FetchBloc>(
        create: (context) => FetchBloc(),
        child: Row(
          children: [
            BlocBuilder<FetchBloc, FetchState>(
              builder: (BuildContext context, FetchState<dynamic> state) {
                if (state is FetchInitial) {
                  return Column(
                    children: [
                      const Text("Pre Fetch"),
                      TextButton(
                        onPressed: () => {
                          BlocProvider.of<FetchBloc>(context)
                              .add( FetchStations(url: 'http://10.88.10.104:3000/api/graph/stations', body: <String, dynamic>{'category': category}) )
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
                  final Data station = Data.fromJson(state.data[0]);
                  
                  // return Text(stations.data![0].name!);
                  return Text(station.tablename!);
                }

                //place holder
                return const SizedBox();
              },
            ),
          ],
        ));
  }

  // Future<StationsData> fetchStations(int category,String path) async {
  //   const url = '10.88.10.104:3000';
  //   const api = 'api/graph/stations';
  //   final token = await getToken();
  //   final response = await http.post(Uri.parse('http://$url/$api'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         'Authorization': 'Bearer $token',
  //         'path' : path,
  //       },
  //       body: jsonEncode(<String, dynamic>{'category': category}));

  //   if (response.statusCode == 200) {
  //     //receive data and send it to new state
  //     StationsData data = StationsData.fromJson(
  //         jsonDecode(response.body) as Map<String, dynamic>);
  //     await setToken(data.token!);
  //     return data;
  //   } else {
  //     throw Exception('Error: ${response.statusCode}');
  //   }
  // }
}
