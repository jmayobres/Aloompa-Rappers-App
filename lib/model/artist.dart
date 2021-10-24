import 'dart:convert';

ArtistResponse artistResponseFromJson(String str) =>
    ArtistResponse.fromJson(json.decode(str));

String artistResponseToJson(ArtistResponse data) => json.encode(data.toJson());

class ArtistResponse {
  ArtistResponse({
    this.artists,
  });

  final List<Artist> artists;

  ArtistResponse copyWith({
    List<Artist> artists,
  }) =>
      ArtistResponse(
        artists: artists ?? this.artists,
      );

  factory ArtistResponse.fromJson(Map<String, dynamic> json) => ArtistResponse(
        artists: json["artists"] == null
            ? null
            : List<Artist>.from(json["artists"].map((x) => Artist.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "artists": artists == null
            ? null
            : List<dynamic>.from(artists.map((x) => x.toJson())),
      };
}

class Artist {
  Artist({
    this.id,
    this.name,
    this.description,
    this.image,
  });

  final String id;
  final String name;
  final String description;
  final String image;

  Artist copyWith({
    String id,
    String name,
    String description,
    String image,
  }) =>
      Artist(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        image: image ?? this.image,
      );

  factory Artist.fromJson(Map<String, dynamic> json) => Artist(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
        image: json["image"] == null ? null : json["image"],
      );

  // factory Artist.fromDB(Map<String, dynamic> json) => Artist(
  //     id: json["idArtists"] == null ? null : json["idArtists"],
  //     name: json["name"] == null ? null : json["name"],
  //     description: json["description"] == null ? null : json["description"],
  //     image: json["image"] == null ? null : json["image"],
  // );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "description": description == null ? null : description,
        "image": image == null ? null : image,
      };
}
