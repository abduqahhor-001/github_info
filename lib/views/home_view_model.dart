import 'package:flutter/cupertino.dart';

import '../model/post_model.dart';
import '../services/http_service.dart';
import '../services/log_service.dart';

class HomeViewModel extends ChangeNotifier{
  List<Post?> item = [];
  bool loader = false;

  void apiPostList() async {
    var response = await Network.GET(Network.API_LIST, Network.paramsEmpty());
    if (response != null) {

        loader =false;
        notifyListeners();

      item = Network.parsePostList(response);
      LogService.d('$item');
    } else {
      item = [];
    }
  }

  void delPost(String id) async {
    var response =
    await Network.DEL(Network.API_DELETE + id, Network.paramsEmpty());
    LogService.d(response.toString());
  }

}