import 'package:flutter_mask/model/store.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StoreRepository {

  Future<List<Store>> fetch(double lat, double lng) async { //List형태인 Store를 return 하겠다. 선언
    final stores = List<Store>();

    var url =
        'https://gist.githubusercontent.com/junsuk5/bb7485d5f70974deee920b8f0cd1e2f0/raw/063f64d9b343120c2cb01a6555cf9b38761b1d94/sample.json?lat=$lat&lng=$lng&m=5';

    var response = await http.get(url);

    final jsonResult = jsonDecode(utf8.decode(response.bodyBytes));

    final jsonStores = jsonResult['stores'];

      jsonStores.forEach((e) {
        stores.add(Store.fromJson(e));
      });
    print('fetch 완료');

    return stores.where((e) { // where 함수는 필요한 것만 걸러내는 기능을 함.
      return e.remainStat == 'plenty' ||
          e.remainStat == 'some' ||
          e.remainStat == 'few';
    }).toList();
  }
}