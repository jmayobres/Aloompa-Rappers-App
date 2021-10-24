import 'package:aloompa/model/artist.dart';
import 'package:aloompa/utils/api_client.dart';
import 'package:flutter/foundation.dart';

class ArtistsRepository {
  final ApiClient netUtil;
  ArtistsRepository({@required this.netUtil}) : assert(netUtil != null);

  Future<ArtistResponse> getRappers() async {
    const url = '/rappers/rappers.json';
    dynamic response = await netUtil.getDio(url);
    return ArtistResponse.fromJson(response.data);
  }
}
