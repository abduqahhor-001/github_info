import 'package:flutter/cupertino.dart';

import '../model/post_model.dart';
import '../services/http_service.dart';
import '../services/log_service.dart';

class EditViewModel extends ChangeNotifier{
 int userId = 1;
 int id = 10;
 final TextEditingController updateControllerTitle = TextEditingController();
 final TextEditingController updateControllerBody = TextEditingController();


 void apiPostEdit(int id, String title, String body, int userId) async {
   var response = await Network.PUT(
       Network.API_UPDATE + id.toString(),
       Network.paramsUpdate(
           Post(id: id, title: title, body: body, userId: userId)));
   LogService.d(response.toString());
 }
}