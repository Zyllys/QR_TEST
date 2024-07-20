part of 'fetch_bloc.dart';

abstract class FetchEvent extends Equatable {
  const FetchEvent({required this.url, this.body});
  final String url;
  final Map<String,dynamic>? body;
  final String path = "FetchMenu";


  @override
  List<Object> get props => [];
}

class FetchStations extends FetchEvent {
  const FetchStations({required super.url, super.body});
  @override
  // ignore: overridden_fields
  final String path = "dust/summary-graphics";


  
  @override
  List<Object> get props => [];
}