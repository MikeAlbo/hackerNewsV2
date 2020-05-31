import 'package:flutter/material.dart';
import 'package:hacker_news/Models/item.dart';
import 'package:hacker_news/app/screens/Story/Comments/comments_list_builder.dart';
import 'package:hacker_news/app/widgets/app_bar.dart';

class FullListOfComments extends StatelessWidget {
  final ItemModel itemModel;

  FullListOfComments({this.itemModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: "All Comments", centerTitle: true),
      body: _buildAllCommentsLayout(itemModel, context),
    );
  }
}

Widget _buildAllCommentsLayout(ItemModel itemModel, BuildContext context) {
  return SingleChildScrollView(
    child: Column(
      children: [
        Center(
          child: Container(
            padding: EdgeInsets.all(10.0),
            color: Colors.white,
            child: Text(
              "${itemModel.title}",
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        CommentsListBuilder(
          itemModel: itemModel,
          numberOfComments: NumberOfComments.all,
        ),
      ],
    ),
  );
}
