import 'package:flutter/material.dart';
import 'package:hacker_news/APIs/api_helpers.dart';
import 'package:hacker_news/Models/ids_list.dart';
import 'package:hacker_news/app/screens/summary/section_tile.dart';

class SectionCard extends StatelessWidget {
  final String title;
  final IdListName idListName;
  final AsyncSnapshot<Map<String, IdsListModel>> snapshot;
  final int subsetLength;

  SectionCard(
      {this.title, this.idListName, this.snapshot, this.subsetLength = 5});
  @override
  Widget build(BuildContext context) {
    // get a subset of a specific list
    final List<int> idsSubset = snapshot
        .data[getStoriesList(idListName)].storyIdsList
        .sublist(0, subsetLength)
        .cast<int>();

    //print("${getStoriesList(idListName)} : --> $idsSubset");

    List<Widget> sectionTitleList = List.generate(
        idsSubset.length,
        (index) => SectionTile(
              itemId: idsSubset[index],
              idListName: idListName,
            ));

    sectionTitleList.insert(
        0,
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ],
          ),
        ));

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
      margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      elevation: 0.0,
      child: Column(
        children: sectionTitleList,
      ),
    );
  }
}
