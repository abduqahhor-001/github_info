import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:github_info/model/post_model.dart';
import 'package:github_info/services/http_service.dart';
import 'package:github_info/services/log_service.dart';



class JsonHomePage extends StatefulWidget {
  const JsonHomePage({super.key});

  @override
  State<JsonHomePage> createState() => _JsonHomePageState();
}

class _JsonHomePageState extends State<JsonHomePage> {
  List<Post?> item =[];
  @override


  void ApiPostList() async{
    var response = await Network.GET(Network.API_LIST, Network.paramsEmpty());
    if(response != null){
        item = Network.parsePostList(response);
        LogService.d('$item');
    }else{
      item = [];
    }
  }
 void initState() {
    // TODO: implement initState
    super.initState();
    ApiPostList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('list'),
      ),
      body: Center(
        child: ListView.builder(
            itemCount: item.length,
            itemBuilder: (context , index){
              return itemOfPost(item[index]!);
            }
        )
      ),
    );
  }
  Widget itemOfPost(Post post) {
    return Slidable(
      key: ValueKey(post.id), // Har bir element uchun unikal kalit
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              // Yangilash funksiyasi
              LogService.i('Update pressed for ${post.title}');
            },
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Update',
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              // O'chirish funksiyasi
              LogService.i('Delete pressed for ${post.title}');
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: ListTile(
        title: Text(post.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text(post.body ?? '', style: const TextStyle(fontSize: 14)),
        isThreeLine: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }


}
