import 'package:flutter/foundation.dart';
import 'package:flutter_mask/model/store.dart';
import 'package:flutter_mask/repository/store_repository.dart';

class StoreModel with ChangeNotifier {
  List<Store> stores = [];
  final _storeRepository = StoreRepository();

  StoreModel() { // 처음 한번 데이터를 받아줌
    fetch();
  }

  Future fetch() async {
    stores = await _storeRepository.fetch();
    notifyListeners(); // 받은 값을 통지 함
  }
}