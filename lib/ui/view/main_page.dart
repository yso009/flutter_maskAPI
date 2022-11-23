import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mask/model/store.dart';
import 'package:flutter_mask/viewmodel/store_model.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final storeModel = Provider.of<StoreModel>(context); // main 함수에서 제공하는 value : StoreModel instance를 사용할 수 있게 함.
    return Scaffold(
        appBar: AppBar(
          title: Text('마스크 재고 있는 곳 : ${storeModel.stores.where((e) {
            return e.remainStat == 'plenty' ||
                e.remainStat == 'some' ||
                e.remainStat == 'few';
          }).length}곳'),
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                storeModel.fetch();
              },
            )
          ],
        ),
        body: storeModel.isLoading
            ? loadingWidget()
            : // isLoading 이면 loadingWidget을 리턴
        ListView(
            children: storeModel.stores.where((e) {
              return e.remainStat == 'plenty' ||
                  e.remainStat == 'some' ||
                  e.remainStat == 'few';
            }) // where 함수는 필요한 것만 걸러내는 기능을 함.
                .map((e) {
              return ListTile(
                title: Text(e.name),
                subtitle: Text(e.addr),
                trailing: _buildRemainStatWidget(e),
              );
            }).toList() // null 값을 ''로 표시
        ));
  }

  Widget _buildRemainStatWidget(Store store) {
    var remainStat = '판매중지';
    var description = '판매중지';
    var color = Colors.black;
    if (store.remainStat == 'planty') {
      remainStat = '충분';
      description = '100개 이상';
      color = Colors.green;
    }
    switch (store.remainStat) {
      case 'plenty':
        remainStat = '충분';
        description = '100개 이상';
        color = Colors.green;
        break;
      case 'some':
        remainStat = '보통';
        description = '30 ~ 100개';
        color = Colors.yellow;
        break;
      case 'few':
        remainStat = '부족';
        description = '2 ~ 30개';
        color = Colors.red;
        break;
      case 'empty':
        remainStat = '소진임박';
        description = '1개 이하';
        color = Colors.grey;
        break;
      default:
    }

    return Column(
      children: [
        Text(
          remainStat,
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        ),
        Text(description,
            style: TextStyle(
              color: color,
            ))
      ],
    );
  }

  Widget loadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('정보를 가져오는 중'),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}