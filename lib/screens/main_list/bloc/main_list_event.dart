part of 'main_list_bloc.dart';

abstract class MainListEvent extends Equatable {
  const MainListEvent();
}

class FetchArtists extends MainListEvent {
  const FetchArtists();
  @override
  List<Object> get props => [];
}

class CheckConnectivity extends MainListEvent {
  final ConnectivityResult result;
  const CheckConnectivity(this.result);
  @override
  List<Object> get props => [result];
}
