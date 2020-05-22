import 'package:flutter/material.dart';

import 'favorites_bloc.dart';

export 'favorites_bloc.dart';

class FavoritesProvider extends InheritedWidget {
  final FavoritesBloc favoritesBloc;

  FavoritesProvider({
    Key key,
    @required Widget child,
  })  : assert(child != null),
        favoritesBloc = FavoritesBloc(),
        super(key: key, child: child);

  static FavoritesBloc of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<FavoritesProvider>()
        .favoritesBloc;
  }

  @override
  bool updateShouldNotify(FavoritesProvider old) {
    return true;
  }
}
