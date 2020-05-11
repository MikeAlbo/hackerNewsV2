import 'package:flutter/material.dart';

ListView buildListView({int length = 5}) {
  return ListView(
    children: generateFakeSubSetList(),
  );
}

//REMOVE!!
// for demo purpose

List<Widget> generateFakeSubSetList() {
  List<String> titles = ["Top Stories", "New Stories", "Jobs", "Ask", "Saved"];
  List<Widget> fakeList = [];
  titles.forEach((title) {
    fakeList.add(generateCard(title));
  });
  return fakeList;
}

List<Widget> generateFakeListWithHeader(
    {@required int length, @required String title}) {
  List<Widget> fakeList = [];
  fakeList.add(ListTile(
    title: Text(
      title,
      style: TextStyle(
        color: Colors.grey[600],
      ),
    ),
  ));
  fakeList.addAll(generateFakeList(length: length));
  return fakeList;
}

Card generateCard(String title) {
  return Card(
    //elevation: 0.0,
    child: Container(
      padding: EdgeInsets.all(5.0),
      child: Column(
        children: generateFakeListWithHeader(length: 6, title: title),
      ),
    ),
  );
}

List<Widget> generateFakeList({@required int length}) {
  List<Widget> fakeList = [];
  for (int i = 0; i < length; i++) {
    fakeList.add(ListTile(
      isThreeLine: true,
      title: Text("Fake title #$i"),
      subtitle:
          Text("www.postedSite.com/article \n by: Author Name, May 9, 2020"),
      trailing: Icon(
        Icons.bookmark_border,
        color: i % 3 == 0 ? Colors.black87 : Colors.redAccent,
      ),
    ));
    if (i != length - 1) {
      fakeList.add(insertDivider(isTitle: false));
    }
  }
  return fakeList;
}

Divider insertDivider({@required bool isTitle}) {
  return Divider(
    thickness: isTitle ? 1.0 : 0.5,
    height: 1.0,
    color: isTitle ? Colors.black87 : Colors.grey[300],
  );
}
