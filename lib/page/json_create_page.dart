import 'package:flutter/material.dart';
import 'package:github_info/views/create_view_model.dart';
import 'package:provider/provider.dart';


class JsonCreatePage extends StatefulWidget {
  const JsonCreatePage({super.key});

  @override
  State<JsonCreatePage> createState() => _JsonCreatePageState();
}

class _JsonCreatePageState extends State<JsonCreatePage> {
  CreateViewModel createViewModel = new CreateViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Page"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
        body: ChangeNotifierProvider(create: (context)=>createViewModel,
        child:Consumer<CreateViewModel>(builder: (ctx,model,child)=>Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              TextField(
                controller: createViewModel.controllerId,
                keyboardType: TextInputType.number,
                decoration:const InputDecoration(
                  labelText: "id",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: createViewModel.controllerTitle,
                decoration: const InputDecoration(
                  labelText: "titni yarat",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: createViewModel.controllerBody,
                decoration: const InputDecoration(
                  labelText: "bodyni yarat",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: createViewModel.controllerUserId,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "userId",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {

                    createViewModel.apiCreatePost(
                        int.parse(createViewModel.controllerId.text),
                        createViewModel.controllerTitle.text,
                        createViewModel.controllerBody.text,
                        int.parse(createViewModel.controllerUserId.text));
                  });
                },
                child: const Text("yaratish"),
              ),
            ],
          ),
        ),)
        )
    );

  }
}
