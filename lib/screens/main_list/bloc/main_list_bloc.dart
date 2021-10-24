import 'package:aloompa/model/artist.dart';
import 'package:aloompa/repositories/artists_repository.dart';
import 'package:aloompa/storage.dart';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
part 'main_list_event.dart';
part 'main_list_state.dart';

class MainListBloc extends Bloc<MainListEvent, MainListState> {
  final ArtistsRepository _artistsRepository;
  final AloompaStorage _storage;

  MainListBloc(ArtistsRepository artistsRepository, AloompaStorage storage)
      : assert(artistsRepository != null, storage != null),
        _artistsRepository = artistsRepository,
        _storage = storage,
        super(ArtistsListLoading());

  @override
  Stream<MainListState> mapEventToState(MainListEvent event) async* {
    if (event is FetchArtists) {
      yield ArtistsListLoading();
      try {
        yield await manageData();
      } catch (e) {
        yield ArtistsListError(e.toString());
      }
    }
    var currentState = state;
    if (currentState is ArtistsListLoaded) {
      if (event is CheckConnectivity) {
        try {
          if (currentState.offline && event.result != ConnectivityResult.none) {
            //Online state
            yield ArtistsListLoaded(
                (await _artistsRepository.getRappers()).artists, true,
                offline: false);
          } else if (!currentState.offline &&
              event.result == ConnectivityResult.none) {
            //Offline state
            yield ArtistsListLoaded(await _storage.artistList(''), true,
                offline: true);
          }
        } catch (e) {
          yield ArtistsListError(e.toString());
        }
      }
    }
  }

  Future<ArtistsListLoaded> manageData() async {
    if (await checkConnectivity()) {
      //Online state
      return ArtistsListLoaded(
          (await _artistsRepository.getRappers()).artists, true,
          offline: false);
    } else {
      //Offline state
      return ArtistsListLoaded(await _storage.artistList(''), true,
          offline: true);
    }
  }

  sortByName(List<Artist> artistList) {
    artistList.sort((a, b) {
      return a.name.toLowerCase().compareTo(b.name.toLowerCase());
    });
  }

  Future<bool> checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }
}
