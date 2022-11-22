import 'package:flutter/foundation.dart';
import 'package:flutter_mask/repository/store_repository.dart';

class StoreModel with ChangeNotifier {
  final _storeRepository = StoreRepository();

  Future fetch() {
    _storeRepository.fetch();
  }
}