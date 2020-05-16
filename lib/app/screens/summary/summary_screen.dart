import 'package:flutter/material.dart';
import 'package:hacker_news/APIs/api_helpers.dart';
import 'package:hacker_news/BLOCs/Stories/stories_provider.dart';
import 'package:hacker_news/Models/ids_list.dart';
import 'package:hacker_news/app/screens/summary/section_card.dart';

class SummaryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    StoriesBloc _storiesBloc = StoriesProvider.of(context);
    _storiesBloc.fetchAllList();

    Widget getListOdCards(
        {int index, AsyncSnapshot<Map<String, IdsListModel>> snapshot}) {
      List<Widget> sectionList = [
        SectionCard(
          title: "Top Stories",
          idListName: IdListName.topStories,
          snapshot: snapshot,
        ),
        SectionCard(
          title: "New Stories",
          idListName: IdListName.newStories,
          snapshot: snapshot,
        ),
        SectionCard(
          title: "Ask Stories",
          idListName: IdListName.askStories,
          snapshot: snapshot,
        ),
        SectionCard(
          title: "Job Stories",
          idListName: IdListName.jobStories,
          snapshot: snapshot,
        ),
        SectionCard(
          title: "Show Stories",
          idListName: IdListName.showStories,
          snapshot: snapshot,
        ),
      ];

      return sectionList[index];
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1.0,
        brightness: Brightness.light,
        centerTitle: true,
        title: Text(
          "Hacker News",
          style: TextStyle(color: Colors.black87),
        ),
      ),
      body: StreamBuilder(
        stream: _storiesBloc.listOfIds,
        builder: (BuildContext ctx,
            AsyncSnapshot<Map<String, IdsListModel>> snapshot) {
          if (!snapshot.hasData) {
            return Text("list of ids snapshot has no data");
          }
          return Container(
            color: Colors.grey[400],
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (BuildContext ctx, int index) {
                return getListOdCards(index: index, snapshot: snapshot);
              },
            ),
          );
        },
      ),
    );
  }
}
