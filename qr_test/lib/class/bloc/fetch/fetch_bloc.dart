import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:qr_test/class/common/token_mixin.dart';
import 'package:http/http.dart' as http;
import 'package:qr_test/class/model/respond_model.dart';


part 'fetch_event.dart';
part 'fetch_state.dart';

class FetchBloc<T> extends Bloc<FetchEvent, FetchState<T>> with Token {
  final String url = "10.88.10.104:3001";

  FetchBloc() : super(FetchInitial()) {
    on<FetchEvent>((event, emit) async {
      //get token

      //change state to FetchLoading
      emit(FetchLoading());
    
      //send out post request and convert result
      try {
        //get token
        String token = await getToken().then((token) => token!);
        
        //fetch data
        final response = await http.post(Uri.parse(event.url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
          'path' : event.path,
        },
        body: jsonEncode(event.body));

        //status error
        if(response.statusCode != 200) {
          throw Exception('Error ${response.statusCode}');
        }

        Respond res = Respond.fromJson(jsonDecode(response.body) as Map<String,dynamic>);
        
        //error occur
        if(res.status != "ok") {
          //logout here?
          throw Exception(res.message);
        }

        await setToken(res.token!);

        emit(FetchCompleted(data: res.data));
      } catch (error) {
        emit(FetchError(error: error.toString()));
      }
    });
  }

  // Future<String?> getToken() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString('token');
  // }

  // Future<void> setToken(String token) async {
  //   await SharedPreferences.getInstance().then((prefs) => prefs.setString('token',token));
  // }
}
