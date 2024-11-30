import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:github_info/services/log_service.dart';
import 'package:github_info/views/edit_view_model.dart';
import 'package:github_info/views/home_view_model.dart';

import '../model/post_model.dart';
import '../page/json_edit_page.dart';

Widget itemOfPost(Post post , ) {
  HomeViewModel homeViewModel = new HomeViewModel();
  EditViewModel editViewModel =EditViewModel();
  return Container(
    margin:const EdgeInsets.only(bottom: 10),
    decoration: BoxDecoration(

      border: Border.all(width: 1, color: Colors.black),
      borderRadius: BorderRadius.circular(25),
    ),

    child: Slidable(

      key: ValueKey(post.id),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context)  {

              editViewModel.id = post.id;
              editViewModel.userId=post.userId;
              editViewModel.updateControllerTitle.text = post.title;
              editViewModel.updateControllerBody.text = post.body;

              Navigator.push(context, MaterialPageRoute(builder: (context)=>const JsonEditPage()));

            },
            borderRadius: BorderRadius.circular(25),
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
              homeViewModel.delPost(post.id.toString());
            },
            borderRadius: BorderRadius.circular(25),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: ListTile(

        title: Text(post.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text(post.body , style: const TextStyle(fontSize: 14)),
        isThreeLine: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    ),
  );
}