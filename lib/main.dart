import 'package:aloompa/data/sqlite_persistence.dart';
import 'package:aloompa/repositories/artists_repository.dart';
import 'package:aloompa/screens/main_list/bloc/main_list_bloc.dart';
import 'package:aloompa/screens/main_list/main_list.dart';
import 'package:aloompa/storage.dart';
import 'package:aloompa/theme/principal_light_theme.dart';
import 'package:aloompa/utils/api_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AloompaStorage storage = await AloompaStorage.createFrom(
    future: SqlitePersistence.create(),
  );
  runApp(MyApp(
    storage: storage,
  ));
}

class MyApp extends StatelessWidget {
  final AloompaStorage storage;
  const MyApp({Key key, this.storage}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: principalLightTheme(context),
        home: BlocProvider(
          create: (BuildContext context) =>
              MainListBloc(ArtistsRepository(netUtil: ApiClient()), storage)
                ..add(FetchArtists()),
          child: DriverDialogWidget(),
        ));
  }
}
