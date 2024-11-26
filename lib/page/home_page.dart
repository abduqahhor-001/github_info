import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
    Map<String ,dynamic> ? userData;

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getGitHubInfo();
  }

    Future<void>getGitHubInfo()async{
      final response = await http.get(Uri.parse('https://api.github.com/users/abduqahhor-001'));

      if(response.statusCode == 200){
        setState(() {
          userData = jsonDecode(response.body);
          print(userData);
        });
      }else{
        throw Exception('mallumot olishda xato bor ${response.statusCode}');
      }


    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GitHub Profil Ma\'lumotlari'),
      ),
      body: userData == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(userData!['avatar_url']),
              radius: 50,
            ),
            SizedBox(height: 10),
            Text(
              'Username: ${userData!['login']}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'Bio: ${userData!['bio'] ?? "Mavjud emas"}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Followers: ${userData!['followers']}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Following: ${userData!['following']}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Public Repos: ${userData!['public_repos']}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
