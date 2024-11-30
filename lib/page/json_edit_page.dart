import 'package:flutter/material.dart';
import 'package:github_info/views/edit_view_model.dart';
import 'package:provider/provider.dart';



class JsonEditPage extends StatefulWidget {
  const JsonEditPage({super.key});
  @override
  State<JsonEditPage> createState() => _JsonEditPageState();
}

class _JsonEditPageState extends State<JsonEditPage> {
  EditViewModel editViewModel = new EditViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit page'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),

      body: ChangeNotifierProvider(
          create: (context)=> editViewModel,
          child: Consumer<EditViewModel>(builder:(ctx , model , child) =>Container(
            padding:const EdgeInsets.all(30),
            child: Column(
              children: [
                TextField(
                  controller:editViewModel.updateControllerTitle ,
                  decoration:const InputDecoration(
                    labelText: "titni yangilang",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: editViewModel.updateControllerBody ,
                  decoration:const InputDecoration(
                    labelText: "bodyni yangilang",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {

                      editViewModel.apiPostEdit(editViewModel.id, editViewModel.updateControllerTitle.text,
                          editViewModel.updateControllerBody.text, editViewModel.userId);
                    });
                  },
                  child: const Text("Yangilash"),
                ),
              ],
            ),
          ),),
      )
    );
  }
}
