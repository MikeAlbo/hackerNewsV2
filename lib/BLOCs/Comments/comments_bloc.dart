import 'package:hacker_news/APIs/repository.dart';
import 'package:hacker_news/Models/item.dart';
import 'package:rxdart/rxdart.dart';

class CommentsBloc {
  final _repo = getRepository;
  final PublishSubject<int> _commentFetcher = PublishSubject<int>();
  final BehaviorSubject<Map<int, Future<ItemModel>>> _commentsOutput =
      BehaviorSubject<Map<int, Future<ItemModel>>>();

  // getter add ItemId --> add an ItemId (comment id) to the itemFetcher sink
  Function(int) get fetchComment => _commentFetcher.sink.add;

  // getter output stream listener --> a Map of Future ItemModels (comments) will be added to this stream
  Stream<Map<int, Future<ItemModel>>> get commentsOutput =>
      _commentsOutput.stream;

  /*
  * recursive comments call
  * limit the number of comments fetched
  * allow for auto-fetching as user scrolls
  * user can select to show more comments
  * */

  dispose() {
    _commentFetcher.close();
    _commentsOutput.close();
  }
}
