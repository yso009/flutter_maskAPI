import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mask/ui/widget/remain_stat_list_tile.dart';
import 'package:flutter_mask/viewmodel/store_model.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final storeModel = Provider.of<StoreModel>(
        context); // main 함수에서 제공하는 value : StoreModel instance를 사용할 수 있게 함.
    return Scaffold(
        appBar: AppBar(
          title: Text('마스크 재고 있는 곳 : ${storeModel.stores.length}곳'),
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
            : ListView(                // isLoading 이면 loadingWidget을 리턴
        children: storeModel.stores.map((e) {
                return ListTile(
                  title: Text(e.name),
                  subtitle: Text(e.addr),
                  trailing: RemainStatListTile(e),
                );
              }).toList() // null 값을 ''로 표시
                ));
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
