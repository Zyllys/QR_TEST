part of 'fetch_bloc.dart';

abstract class FetchState<T> extends Equatable {
  const FetchState();

  @override
  List<Object> get props => [];
}

class FetchInitial<T> extends FetchState<T> {}

class FetchLoading<T> extends FetchState<T> {}

class FetchCompleted<T> extends FetchState<T> {
  final T data;
  const FetchCompleted({required this.data});
}

class FetchError<T> extends FetchState<T> {
  final String error;
  const FetchError({required this.error});
}