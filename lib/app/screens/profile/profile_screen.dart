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

    void bestStorySwitch(bool _) {
      setState(() {
        _storiesBloc.updateSettingsBool(idListName: IdListName.bestStories);
      });
    }

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
      appBar: buildAppBar(title: "Profile", centerTitle: false),
      body: Container(
        color: Colors.grey[100],
        child: StreamBuilder(
          stream: _storiesBloc.userPrefs,
          builder: (BuildContext ctx, AsyncSnapshot<UserPrefs> snapshot) {
            if (!snapshot.hasData) {
              //return PlaceHolderTile();
              return Text("no data");
            }
            return FadeAnimation(
              duration: Duration(milliseconds: 500),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ListBody(
                    children: <Widget>[
                      Center(child: Text("Last Updated:")),
                      Center(
                        child: Text(formatDate(
                            time: snapshot.data.lastUpdated,
                            convertFromSeconds: false)),
                      ),
                      IconButton(
                        icon: Icon(Icons.refresh),
                        color: Colors.blue,
                        //iconSize: 50.0,
                        onPressed: () {
                          print("refresh!");
                        }, //todo: call refresh
                      ),
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
                        SwitchListTile(
                          title: Text("Best Stories"),
                          onChanged: bestStorySwitch,
                          value: snapshot.data.showBestStories,
                        ),
                        insertDivider(isTitle: false),
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
