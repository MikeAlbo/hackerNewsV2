import 'package:hacker_news/APIs/repository.dart';
import 'package:hacker_news/Models/item.dart';
import 'package:rxdart/rxdart.dart';

class ItemsBloc {
  final _repo = getRepository;
  final PublishSubject<int> _itemFetcher = PublishSubject<int>();
  final BehaviorSubject<Map<int, Future<ItemModel>>> _itemsOutput =
      BehaviorSubject<Map<int, Future<ItemModel>>>();

  // getter to add an item ID to the fetcher sink
  Function(int) get fetchItem => _itemFetcher.sink.add;

  // getter output for list of fetched items
  Stream<Map<int, Future<ItemModel>>> get itemsOutput => _itemsOutput.stream;

  ItemsBloc() {
    _itemFetcher.transform(_itemsTransformer()).pipe(_itemsOutput);
  }

  _itemsTransformer() {
    return ScanStreamTransformer(
      (Map<int, Future<ItemModel>> cache, int id, index) {
        cache[id] = _repo.getItem(id);
        return cache;
      },
      <int, Future<ItemModel>>{},
    );
  }

  dispose() {
    _itemFetcher.close();
    _itemsOutput.close();
  }
}
