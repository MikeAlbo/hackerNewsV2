import 'package:flutter/material.dart';
import 'package:hacker_news/app/screens/helpers.dart';
import 'package:hacker_news/app/widgets/app_bar.dart';

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
    return Scaffold(
      appBar: buildAppBar(title: "Profile", centerTitle: false),
      body: Container(
        color: Colors.grey[100],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ListBody(
              children: <Widget>[
                Center(child: Text("Last Updated:")),
                Center(child: Text("05/16/20200")),
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
                    onChanged: updateSwitch,
                    value: testBool,
                  ),
                  insertDivider(isTitle: false),
                  SwitchListTile(
                    title: Text("New Stories"),
                    onChanged: updateSwitch,
                    value: testBool,
                  ),
                  insertDivider(isTitle: false),
                  SwitchListTile(
                    title: Text("New Stories"),
                    onChanged: updateSwitch,
                    value: testBool,
                  ),
                  insertDivider(isTitle: false),
                  SwitchListTile(
                    title: Text("New Stories"),
                    onChanged: updateSwitch,
                    value: testBool,
                  ),
                  insertDivider(isTitle: false),
                  SwitchListTile(
                    title: Text("New Stories"),
                    onChanged: updateSwitch,
                    value: testBool,
                  ),
                  insertDivider(isTitle: false),
                  SwitchListTile(
                    title: Text("New Stories"),
                    onChanged: updateSwitch,
                    value: testBool,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
