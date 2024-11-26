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
  bool loader = true;
  bool update = false;
  bool create = false;
  int updateId =0;
  int userId = 0;
  final TextEditingController _updateControllerTitle = TextEditingController();
  final TextEditingController _updateControllerBody = TextEditingController();
  final TextEditingController _ControllerBody = TextEditingController();
  final TextEditingController _ControllerTitle = TextEditingController();
  final TextEditingController _ControllerId = TextEditingController();
  final TextEditingController _ControllerUserId = TextEditingController();

  @override

  void ApiPostEdit(int id ,String title , String body , int userId)async{
    var response = await Network.PUT(Network.API_UPDATE + id.toString(), Network.paramsUpdate(Post(id: id, title: title, body: body, userId: userId)));
    LogService.d(response.toString());
  }
  void ApiPostList() async{
    var response = await Network.GET(Network.API_LIST, Network.paramsEmpty());
    if(response != null){
        bool loader ;
        item = Network.parsePostList(response);
        LogService.d('$item');

    }else{
      item = [];
    }
  }

  void DelPost(String id) async{
    var respomse = await Network.DEL(Network.API_DELETE + id, Network.paramsEmpty());
    print(respomse);
  }

  void ApiCreatePost(int id , String title , String body , int userId){
    var response = Network.POST(Network.API_CREATE, Network.paramsCreate(Post(id: id, title: title, body: body, userId: userId)));
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
      body: create ? createPost(): Stack(
        children: [
         loader ? Center(
              child: update? updatePost() : ListView.builder(
                  itemCount: item.length,
                  itemBuilder: (context , index){
                    return itemOfPost(item[index]!);
                  }
              )
          ): Center(child: CircularProgressIndicator()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            setState(() {
              create = true;
            });
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),

      ),
    );
  }
  Widget itemOfPost(Post post) {
    return Slidable(
      key: ValueKey(post.id),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              setState(() {
                update = true;
                _updateControllerTitle.text = post.title;
                _updateControllerBody.text= post.body;
                updateId = post.id;
                userId = post.userId;
              });

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
              DelPost(post.id.toString());

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

  Widget updatePost(){
    return Container(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            TextField(
              controller: _updateControllerTitle,
              decoration: InputDecoration(
                labelText: "titni yangilang",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _updateControllerBody,
              decoration: InputDecoration(
                labelText: "bodyni yangilang",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: (){
                setState(() {
                  update = false;
                  ApiPostEdit(updateId, _updateControllerTitle.text, _updateControllerBody.text, userId);
                });
              },
              child: Text("Yangilash"),
            ),
          ],
        ),
    );
  }

  Widget createPost(){
    return Container(
      padding: EdgeInsets.all(30),
      child: Column(
        children: [
          TextField(
            controller: _ControllerId,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(

              labelText: "id",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: _ControllerTitle,
            decoration: InputDecoration(
              labelText: "titni yarat",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: _ControllerBody,
            decoration: InputDecoration(
              labelText: "bodyni yarat",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: _ControllerUserId,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(

              labelText: "userId",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: (){
              setState(() {
                create = false;
                ApiCreatePost(int.parse(_ControllerId.text), _ControllerTitle.text, _ControllerBody.text, int.parse(_ControllerUserId.text));
              });
            },
            child: Text("yaratish"),
          ),
        ],
      ),
    );
  }

}
