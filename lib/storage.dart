import 'package:aloompa/data/sqlite_persistence.dart';
import 'package:aloompa/model/artist.dart';

class AloompaStorage {
  final SqlitePersistence _repository;

  static Future<AloompaStorage> createFrom(
      {Future<SqlitePersistence> future}) async {
    final repository = await future;
    final ret = AloompaStorage(repository);
    return ret;
  }

  AloompaStorage(this._repository);

  void addToArtist(Artist artist) async {
    await _repository.createOrUpdateObject(artist.id, artist.toJson());
  }

  void addListOfArtist(List<Artist> artist) async {
    await _repository
        .createOrUpdateBatchObject(artist.map((e) => e.toJson()).toList());
  }

  Future<List<Artist>> artistList(String query) async {
    final objects = query?.isNotEmpty == true
        ? await _repository.findObjects(query)
        : await _repository.getUniqueObjects();
    return objects.map((map) => Artist.fromJson(map)).toList();
  }

  void removeArtist(Artist artist) async {
    await _repository.removeObject(artist.id);
  }
}
