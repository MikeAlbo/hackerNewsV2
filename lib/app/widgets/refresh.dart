import 'package:flutter/material.dart';
import 'package:hacker_news/BLOCs/Stories/stories_bloc.dart';
import 'package:hacker_news/BLOCs/Stories/stories_provider.dart';

class Refresh extends StatelessWidget {
  final Widget child;

  Refresh({@required this.child});

  @override
  Widget build(BuildContext context) {
    StoriesBloc storiesBloc = StoriesProvider.of(context);
    return RefreshIndicator(
      child: child,
      onRefresh: () async {
        await storiesBloc.clearAllData();
        await storiesBloc.fetchAllList();
        print("cleared");
      },
    );
  }
}
