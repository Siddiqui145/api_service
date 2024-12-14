import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
  
}

class _HomeScreenState extends State<HomeScreen> {
  List <dynamic> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
           FloatingActionButton(onPressed: fetchUsers,
           backgroundColor: Colors.white38,
            child: const Icon(Icons.download, color: Colors.black54,),),
           


           ],
        title: const Text("Flutter REST API"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        
      ),
      body: ListView.builder(itemCount: users.length, itemBuilder: (context, index) {
          final user = users[index];
          final title = user['title'] ?? "No Title";
          final author = user['author'];
          final poem = (user['lines'] as List<dynamic>?)?.join('\n') ?? "No Content";
          final count = user['linecount'] ??  "0";

          return ListTile(
            title: Text(author),
            subtitle: Text(title), 
//trailing: Text(poem),
trailing: Text("$count lines"),
          onTap: () {
            showDialog(context: context, builder: (context) => AlertDialog(
              title: Text(title),
              content: SingleChildScrollView(child: Text(poem)),
            ));
          },

          );
      }),


      
    );
    

    
  }
  void fetchUsers() async {
  print("Fetch users called");
  const url = "https://poetrydb.org/author,title/Shakespeare;Sonnet";
  final uri = Uri.parse(url);
  final response = await http.get(uri);
  final body = response.body;

  final json = jsonDecode(body);
  setState(() {
    users = jsonDecode(body);
  });
  
}

}


