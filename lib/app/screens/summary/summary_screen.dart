import 'package:flutter/material.dart';
import 'package:hacker_news/APIs/api_helpers.dart';
import 'package:hacker_news/BLOCs/Stories/stories_provider.dart';
import 'package:hacker_news/Models/ids_list.dart';
import 'package:hacker_news/Models/user_prefs.dart';
import 'package:hacker_news/app/screens/summary/section_card.dart';
import 'package:hacker_news/app/widgets/app_bar.dart';
import 'package:hacker_news/app/widgets/fade_animation.dart';
import 'package:hacker_news/app/widgets/refresh.dart';

class SummaryScreen extends StatefulWidget {
  @override
  _SummaryScreenState createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  @override
  Widget build(BuildContext context) {
    StoriesBloc _storiesBloc = StoriesProvider.of(context);
    _storiesBloc.getUserPrefs();

    List<Widget> buildListOfSectionCards(
        {UserPrefs userPrefs,
        AsyncSnapshot<Map<String, IdsListModel>> snapshot}) {
      List<Widget> sectionList = [];
      if (userPrefs.showTopStories) {
        sectionList.add(SectionCard(
          title: "Top Stories",
          idListName: IdListName.topStories,
          snapshot: snapshot,
        ));
      }
      if (userPrefs.showNewStories) {
        sectionList.add(SectionCard(
          title: "New Stories",
          idListName: IdListName.newStories,
          snapshot: snapshot,
        ));
      }
      if (userPrefs.showAskStories) {
        sectionList.add(SectionCard(
          title: "Ask Stories",
          idListName: IdListName.askStories,
          snapshot: snapshot,
        ));
      }
      if (userPrefs.showJobStories) {
        sectionList.add(SectionCard(
          title: "Job Stories",
          idListName: IdListName.jobStories,
          snapshot: snapshot,
        ));
      }
      if (userPrefs.showShowStories) {
        sectionList.add(SectionCard(
          title: "Show Stories",
          idListName: IdListName.showStories,
          snapshot: snapshot,
        ));
      }

      return sectionList;
    }

    return StreamBuilder(
      stream: _storiesBloc.userPrefs,
      builder: (BuildContext ctx, AsyncSnapshot<UserPrefs> prefsSnapshot) {
        if (!prefsSnapshot.hasData) {
          return Container(
            constraints: BoxConstraints.expand(),
          );
        }
        _storiesBloc.fetchAllList();
        return Scaffold(
          appBar: buildAppBar(
              title: "Hacker News",
              centerTitle: true,
              titleTextTheme: TitleTextTheme.AppHeading),
          body: StreamBuilder(
            stream: _storiesBloc.listOfIds,
            builder: (BuildContext ctx,
                AsyncSnapshot<Map<String, IdsListModel>> snapshot) {
              if (!snapshot.hasData) {
                return Container(
                  constraints: BoxConstraints.expand(),
                );
              }

              List<Widget> sectionCards = buildListOfSectionCards(
                  snapshot: snapshot, userPrefs: prefsSnapshot.data);

              return Refresh(
                child: FadeAnimation(
                  duration: Duration(seconds: 1),
                  child: Container(
                    color: Colors.grey[400],
                    child: ListView.builder(
                      itemCount: sectionCards.length,
                      itemBuilder: (BuildContext ctx, int index) {
                        return sectionCards[index];
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
