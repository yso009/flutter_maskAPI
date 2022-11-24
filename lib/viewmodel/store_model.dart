import 'package:flutter/foundation.dart';
import 'package:flutter_mask/model/store.dart';
import 'package:flutter_mask/repository/location_repository.dart';
import 'package:flutter_mask/repository/store_repository.dart';
import 'package:geolocator/geolocator.dart';

class StoreModel with ChangeNotifier {
  var isLoading = false;
  List<Store> stores = [];

  final _storeRepository = StoreRepository();
  final _locationREpository = LocationRepository();

  StoreModel() { // 처음 한번 데이터를 받아줌
    fetch();
  }

  Future fetch() async {
    isLoading = true;
    notifyListeners(); // 받은 값을 통지 함

    Position position = await _locationREpository.getCurrentLocation();

    stores = await _storeRepository.fetch(
        position.latitude,
        position.longitude);
    isLoading = false;
    notifyListeners(); // 받은 값을 통지 함
  }
}