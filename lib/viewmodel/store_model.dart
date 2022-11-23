import 'package:flutter/foundation.dart';
import 'package:flutter_mask/model/store.dart';
import 'package:flutter_mask/repository/store_repository.dart';

class StoreModel with ChangeNotifier {
  List<Store> data = [];
  final _storeRepository = StoreRepository();

  Future fetch() async {
    data = await _storeRepository.fetch();
    notifyListeners();
  }
}