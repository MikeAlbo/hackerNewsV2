import 'package:flutter/material.dart'
    show InheritedWidget, Widget, required, Key, BuildContext;

import 'items_bloc.dart';

export 'items_bloc.dart';

class ItemsProvider extends InheritedWidget {
  final ItemsBloc _itemsBloc;

  ItemsProvider({
    Key key,
    @required Widget child,
  })  : assert(child != null),
        _itemsBloc = ItemsBloc(),
        super(key: key, child: child);

  static ItemsBloc of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ItemsProvider>()
        ._itemsBloc;
  }

  @override
  bool updateShouldNotify(ItemsProvider old) {
    return true;
  }
}
