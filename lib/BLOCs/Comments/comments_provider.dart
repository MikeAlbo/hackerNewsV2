import 'package:flutter/material.dart'
    show InheritedWidget, Widget, required, Key, BuildContext;

import 'comments_bloc.dart';

export 'comments_bloc.dart';

class CommentsProvider extends InheritedWidget {
  final CommentsBloc _commentsBloc;

  CommentsProvider({
    Key key,
    @required Widget child,
  })  : assert(child != null),
        _commentsBloc = CommentsBloc(),
        super(key: key, child: child);

  static CommentsBloc of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<CommentsProvider>()
        ._commentsBloc;
  }

  @override
  bool updateShouldNotify(CommentsProvider old) {
    return true;
  }
}
