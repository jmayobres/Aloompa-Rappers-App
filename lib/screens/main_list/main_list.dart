import 'dart:async';
import 'package:aloompa/model/artist.dart';
import 'package:aloompa/screens/main_list/widgets/artist_card.dart';
import 'package:aloompa/widgets/empty_view.dart';
import 'package:aloompa/widgets/error_view.dart';
import 'package:aloompa/widgets/offline_view.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:aloompa/screens/main_list/bloc/main_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DriverDialogWidget extends StatefulWidget {
  const DriverDialogWidget({
    Key key,
  }) : super(key: key);

  @override
  _DriverDialogWidgetState createState() => _DriverDialogWidgetState();
}

class _DriverDialogWidgetState extends State<DriverDialogWidget> {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  TextEditingController textController = TextEditingController();
  MainListBloc _mainListBloc;
  ThemeData _theme;
  List<Artist> _searchResult = [];

  @override
  void initState() {
    super.initState();
    _mainListBloc = BlocProvider.of<MainListBloc>(context);
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    _mainListBloc.add(CheckConnectivity(result));
  }

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: BlocListener(
            bloc: _mainListBloc,
            listener: (context, state) {
              if (state is ArtistsListLoaded) {}
            },
            child: BlocBuilder(
              bloc: _mainListBloc,
              builder: (context, state) {
                if (state is ArtistsListError) {
                  return ErrorView(
                    appBar: true,
                    error: state.error,
                  );
                }
                if (state is ArtistsListLoaded) {
                  if (state.offline && state.artistData.isEmpty) {
                    return OfflineView();
                  }
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Home",
                                style: _theme.textTheme.headline5.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Visibility(
                                visible: state.offline,
                                child: Chip(
                                  backgroundColor: Colors.white,
                                  avatar: Icon(
                                    Icons.offline_pin,
                                    color: Colors.purple,
                                  ),
                                  label: Text(
                                    'Offline',
                                    style: TextStyle(color: Colors.purple),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(child: searchList(state.artistData))
                      ],
                    ),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            )),
      ),
    );
  }

  Widget searchList(List<Artist> artists) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Card(
          shadowColor: Colors.green.shade800,
          elevation: 3,
          child: ListTile(
            leading: Icon(Icons.search),
            title: TextField(
                enabled: artists.isNotEmpty,
                controller: textController,
                decoration: InputDecoration(
                    hintText: 'Search', border: InputBorder.none),
                onChanged: (value) {
                  onSearchTextChanged(value, artists);
                }),
            trailing: IconButton(
              icon: Icon(Icons.cancel),
              onPressed: () {
                textController.clear();
                onSearchTextChanged('', artists);
              },
            ),
          ),
        ),
        Expanded(
            child: Visibility(
          visible: artists.isEmpty,
          child: EmptyView(),
          replacement:
              _searchResult.isNotEmpty || textController.text.isNotEmpty
                  ? ListView.builder(
                      itemCount: _searchResult.length,
                      itemBuilder: (context, index) {
                        return ArtistsCard(artist: _searchResult[index]);
                      },
                    )
                  : ListView.builder(
                      itemCount: artists.length,
                      itemBuilder: (context, index) {
                        return ArtistsCard(artist: artists[index]);
                      },
                    ),
        ))
      ],
    );
  }

  onSearchTextChanged(String text, List<Artist> artits) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    for (var artistData in artits) {
      if (artistData.name.toLowerCase().contains(text.toLowerCase())) {
        _searchResult.add(artistData);
      }
    }
    setState(() {});
  }
}
