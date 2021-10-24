import 'package:aloompa/model/artist.dart';
import 'package:aloompa/screens/artists_details/artists_details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ArtistsCard extends StatelessWidget {
  final Artist artist;
  const ArtistsCard({Key key, this.artist}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArtistDetails(
                      artist: artist,
                    ))),
        leading: CircleAvatar(
          radius: 30.0,
          backgroundImage: CachedNetworkImageProvider(
            artist.image,
          ),
        ),
        title: Text(artist.name),
        subtitle: Text(
          artist.description,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
        ),
      ),
    );
  }
}
