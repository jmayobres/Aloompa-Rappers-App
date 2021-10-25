import 'package:aloompa/model/artist.dart';
import 'package:aloompa/repositories/artists_repository.dart';
import 'package:aloompa/utils/api_client.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Artists can be fetched', () async {
    ArtistsRepository artistsRepository =
        await ArtistsRepository(netUtil: ApiClient());
    ArtistResponse response = await artistsRepository.getRappers();

    expect(response.artists.length, greaterThan(0));
  });
}
