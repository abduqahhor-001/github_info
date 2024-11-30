import 'package:flutter/material.dart';
import 'package:github_info/page/json_create_page.dart';
import 'package:github_info/views/home_view_model.dart';
import 'package:provider/provider.dart';
import '../widgets/item_of_posts.dart';

class JsonHomePage extends StatefulWidget {
  const JsonHomePage({super.key});
  @override
  State<JsonHomePage> createState() => _JsonHomePageState();
}

class _JsonHomePageState extends State<JsonHomePage> {
  HomeViewModel homeViewModel =new HomeViewModel();

  @override
  void initState() {
    super.initState();
    setState(() {
    homeViewModel.apiPostList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('list'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: ChangeNotifierProvider(
          create: (context) => homeViewModel,
          child: Consumer<HomeViewModel>(builder: (ctx,model ,child) =>Stack(
            children: [
              homeViewModel.loader
                  ?const Center(child: CircularProgressIndicator()):
              Padding(
                  padding:const EdgeInsets.all(10),
                  child:  ListView.builder(
                      itemCount:homeViewModel.item.length,
                      itemBuilder: (context, index) {
                        return itemOfPost(homeViewModel.item[index]!);
                      }))
            ],
          ),),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            Navigator.push(

                context, MaterialPageRoute(
                builder: (context)=>const JsonCreatePage(),
            )

            );
          });
        },
        tooltip: 'Increment',
        child:const Icon(Icons.add),
      ),
    );
  }






}
