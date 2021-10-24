import 'package:aloompa/model/artist.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ArtistDetails extends StatefulWidget {
  final Artist artist;
  ArtistDetails({Key key, @required this.artist}) : super(key: key);

  @override
  _ArtistDetailsState createState() => _ArtistDetailsState();
}

class _ArtistDetailsState extends State<ArtistDetails> {
  ThemeData _theme;

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 300.0,
            floating: true,
            pinned: true,
            snap: true,
            elevation: 50,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              title:
                  Text(widget.artist.name, style: _theme.textTheme.headline6),
              background: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: widget.artist.image,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                margin: EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('About', style: _theme.textTheme.headline6),
                    SizedBox(height: 6),
                    Text(widget.artist.description,
                        style: _theme.textTheme.bodyText1),
                    SizedBox(height: 16),
                  ],
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }
}
