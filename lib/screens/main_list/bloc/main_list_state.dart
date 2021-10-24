part of 'main_list_bloc.dart';

abstract class MainListState extends Equatable {
  const MainListState();
}

class ArtistsListLoading extends MainListState {
  @override
  List<Object> get props => [];
}

class ArtistsListError extends MainListState {
  final String error;
  const ArtistsListError(this.error);
  @override
  List<Object> get props => [error];
  @override
  String toString() => 'ArtistsListError';
}

class ArtistsListLoaded extends MainListState {
  final List<Artist> artistData;
  final bool status;
  final bool offline;
  const ArtistsListLoaded(this.artistData, this.status, {this.offline});
  @override
  List<Object> get props => [artistData, status];
  @override
  String toString() => 'ArtistsListLoaded ';
}
