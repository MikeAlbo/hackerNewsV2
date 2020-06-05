import 'package:flutter/material.dart';
import 'package:hacker_news/APIs/api_helpers.dart';
import 'package:hacker_news/BLOCs/Stories/stories_provider.dart';
import 'package:hacker_news/Models/user_prefs.dart';
import 'package:hacker_news/app/widgets/app_bar.dart';
import 'package:hacker_news/app/widgets/fade_animation.dart';

import '../helpers.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool testBool = true;

  updateSwitch(bool value) {
    setState(() {
      testBool = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    StoriesBloc _storiesBloc = StoriesProvider.of(context);
    _storiesBloc.getUserPrefs();

    void newStorySwitch(bool _) {
      setState(() {
        _storiesBloc.updateSettingsBool(idListName: IdListName.newStories);
      });
    }

    void topStorySwitch(bool _) {
      setState(() {
        _storiesBloc.updateSettingsBool(idListName: IdListName.topStories);
      });
    }

//    void bestStorySwitch(bool _) {
//      setState(() {
//        _storiesBloc.updateSettingsBool(idListName: IdListName.bestStories);
//      });
//    }

    void jobStorySwitch(bool _) {
      setState(() {
        _storiesBloc.updateSettingsBool(idListName: IdListName.jobStories);
      });
    }

    void showStorySwitch(bool _) {
      setState(() {
        _storiesBloc.updateSettingsBool(idListName: IdListName.showStories);
      });
    }

    void askStorySwitch(bool _) {
      setState(() {
        _storiesBloc.updateSettingsBool(idListName: IdListName.askStories);
      });
    }

    return Scaffold(
      appBar: buildAppBar(
          title: "Profile",
          centerTitle: false,
          titleTextTheme: TitleTextTheme.SectionHeading),
      body: Container(
        color: Colors.grey[100],
        child: StreamBuilder(
          stream: _storiesBloc.userPrefs,
          builder: (BuildContext ctx, AsyncSnapshot<UserPrefs> snapshot) {
            if (!snapshot.hasData) {
              //return PlaceHolderTile();
              return Container(
                constraints: BoxConstraints.expand(),
              );
            }
            return FadeAnimation(
              duration: Duration(milliseconds: 500),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ListBody(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                  child: Text(
                                "App Settings\nLast Updated:",
                                textAlign: TextAlign.center,
                              )),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    0.0, 10.0, 0.0, 0.0),
                                child: Center(
                                  child: Text(
                                    formatDate(
                                        time: snapshot.data.lastUpdated,
                                        convertFromSeconds: false),
                                    style: TextStyle(fontSize: 22.0),
                                  ),
                                ),
                              ),
                              IconButton(
                                  //todo: clear settings
                                  padding: EdgeInsets.all(5.00),
                                  onPressed: () => _storiesBloc.clearAllData(),
                                  icon: Icon(
                                    Icons.delete_outline,
                                    size: 30.0,
                                    color: Colors.red[300],
                                  )),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                  child: Text(
                                "List and Stories\nLast Updated:",
                                textAlign: TextAlign.center,
                              )),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    0.0, 10.0, 0.0, 000.0),
                                child: Center(
                                  child: Text(
                                    formatDate(
                                        time: snapshot.data.lastUpdated,
                                        convertFromSeconds: false),
                                    style: TextStyle(fontSize: 22.0),
                                  ),
                                ),
                              ),
                              IconButton(
                                  padding: EdgeInsets.all(5.00),
                                  onPressed: () => _storiesBloc.clearAllData(),
                                  icon: Icon(
                                    Icons.delete_outline,
                                    size: 30.0,
                                    color: Colors.red[300],
                                  )),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  Card(
                    elevation: 0.5,
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: Center(child: Text("View Story List")),
                        ),
                        insertDivider(isTitle: false),
                        SwitchListTile(
                          title: Text("New Stories"),
                          onChanged: newStorySwitch,
                          value: snapshot.data.showNewStories,
                        ),
                        insertDivider(isTitle: false),
//                        SwitchListTile(
//                          title: Text("Best Stories"),
//                          onChanged: bestStorySwitch,
//                          value: snapshot.data.showBestStories,
//                        ),
//                        insertDivider(isTitle: false),
                        SwitchListTile(
                          title: Text("Top Stories"),
                          onChanged: topStorySwitch,
                          value: snapshot.data.showTopStories,
                        ),
                        insertDivider(isTitle: false),
                        SwitchListTile(
                          title: Text("Job Stories"),
                          onChanged: jobStorySwitch,
                          value: snapshot.data.showJobStories,
                        ),
                        insertDivider(isTitle: false),
                        SwitchListTile(
                          title: Text("Show Stories"),
                          onChanged: showStorySwitch,
                          value: snapshot.data.showShowStories,
                        ),
                        insertDivider(isTitle: false),
                        SwitchListTile(
                          title: Text("Ask Stories"),
                          onChanged: askStorySwitch,
                          value: snapshot.data.showAskStories,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
