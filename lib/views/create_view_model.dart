import 'package:flutter/cupertino.dart';
import 'package:github_info/services/log_service.dart';

import '../model/post_model.dart';
import '../services/http_service.dart';

class CreateViewModel extends ChangeNotifier{
  final TextEditingController controllerBody = TextEditingController();
  final TextEditingController controllerTitle = TextEditingController();
  final TextEditingController controllerId = TextEditingController();
  final TextEditingController controllerUserId = TextEditingController();


  void apiCreatePost (int id, String title, String body, int userId) {
   var response= Network.POST(
        Network.API_CREATE,
        Network.paramsCreate(
            Post(id: id, title: title, body: body, userId: userId)));
   LogService.d(response.toString());
  }

}