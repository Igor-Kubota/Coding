import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:testegridview/game_json.dart';
import 'package:testegridview/home_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Hide the debug banner
      debugShowCheckedModeBanner: false,
      title: 'Kindacode.com',
      theme: ThemeData(
        colorScheme: const ColorScheme.dark().copyWith(
          primary: Colors.deepPurple ,
          secondary: const Color(0XFF1F1B24),
          surface: Colors.deepPurple
        ),
        
        //brightness: Brightness.dark
      ),
      home: HomeScreen(),
    );
  }
}

class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: AppBar(
          title: Text("Hello world"),
        ),

        body: 
        
        Container(
          alignment: Alignment.bottomLeft,
          child: Material(
            color: Colors.blueGrey,
            elevation: 8,
            borderRadius: BorderRadius.circular(28),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: InkWell(
              splashColor: Colors.black26,
              onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => GamePage1()));
                        },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Ink.image(
                    image: const NetworkImage("https://pbs.twimg.com/media/FEaCjohXIAQPVgl?format=jpg&name=small"),
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 3),
                  const Text(
                    'Maru',
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                  const SizedBox(height: 3),
                ]
            ),  
          ),
        ),      
      ),       
    );  
  }


class GamePage1 extends StatefulWidget {
  const GamePage1({ Key? key }) : super(key: key);

  @override
  _GamePage1State createState() => _GamePage1State();
}

class _GamePage1State extends State<GamePage1> {
    
  Future<List<GameJson>> ReadJsonData() async{
    const url = "http://localhost:8080/games";
    final http.Response jsonData= await http.get(Uri.parse(url));

    final list = jsonDecode(jsonData.body) as List<dynamic>;

    return list.map((e) => GameJson.fromJson(e)).toList();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Game Review"),
      ),


       body: FutureBuilder(
         future: ReadJsonData(),
         builder: (context, data){
           if (data.hasError){
             return Center(child:Text("${data.error}"));

           }else if (data.hasData){
             var items = data.data as List<GameJson>;
             return ListView.builder(
               itemCount: 1,
               itemBuilder: (context, index){
          return Card(
            child: Padding(
              padding: const EdgeInsets.only(top: 32.0, bottom: 32.0, left: 16.0, right: 16.0),
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget> [
                Text(
                  items[index].name.toString(),
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.cyan.shade200
                  )
                ),

                Text(
                  items[index].summary.toString(),
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.cyan.shade200
                  )
                ),

                Text(
                  items[index].developer.toString(),
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.cyan.shade200
                  )
                ),

                Text(
                  items[index].consoles.toString(),
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.cyan.shade200
                  )
                ),

                Text(
                  items[index].release.toString(),
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.cyan.shade200
                  )
                ),
              ],
            ),
          )
        );
      },  
    ); 
               
           }else{
             return Center(child: CircularProgressIndicator(),);
           }
         }
       ),
    );
  }
}


class GamePage2 extends StatefulWidget {
  const GamePage2({ Key? key }) : super(key: key);

  @override
  _GamePage2State createState() => _GamePage2State();
}

class _GamePage2State extends State<GamePage2> {
    
  Future<List<GameJson>> ReadJsonData() async{
    const url = "http://localhost:8080/games";
    final http.Response jsonData= await http.get(Uri.parse(url));

    final list = jsonDecode(jsonData.body) as List<dynamic>;

    return list.map((e) => GameJson.fromJson(e)).toList();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Game Review"),
      ),


       body: FutureBuilder(
         future: ReadJsonData(),
         builder: (context, data){
           if (data.hasError){
             return Center(child:Text("${data.error}"));

           }else if (data.hasData){
             var items = data.data as List<GameJson>;
             return ListView.builder(
               itemCount: 1,
               itemBuilder: (context, index){
          return Card(
            child: Padding(
              padding: const EdgeInsets.only(top: 32.0, bottom: 32.0, left: 16.0, right: 16.0),
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget> [
                Text(
                  items[index+1].name.toString(),
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.cyan.shade200
                  )
                ),

                Text(
                  items[index+1].summary.toString(),
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.cyan.shade200
                  )
                ),

                Text(
                  items[index+1].developer.toString(),
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.cyan.shade200
                  )
                ),

                Text(
                  items[index+1].consoles.toString(),
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.cyan.shade200
                  )
                ),

                Text(
                  items[index+1].release.toString(),
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.cyan.shade200
                  )
                ),
              ],
            ),
          )
        );
      },  
    ); 
               
           }else{
             return Center(child: CircularProgressIndicator(),);
           }
         }
       ),
    );
  }
}

class GamePage3 extends StatelessWidget {
 GamePage3({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Game Review"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text("CCCCCCCCCCCCC"),
            leading: TextButton(
              child: Image.network("https://pbs.twimg.com/media/FEaCjohXIAQPVgl?format=jpg&name=small", fit: BoxFit.contain,),
              
              onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const MyPage()));
              }
            ),
            subtitle: const Text("cccccccccccc"),
          ),
        ],
      ),
    );
  }
}


class GamePage4 extends StatelessWidget {
 GamePage4({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Game Review"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text("DDDDDDDDDDDDDD"),
            leading: TextButton(
              child: Image.network("https://pbs.twimg.com/media/FEaCjohXIAQPVgl?format=jpg&name=small", fit: BoxFit.contain,),
              
              onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const MyPage()));
              }
            ),
            subtitle: const Text("ddddddddddddddd"),
          ),
        ],
      ),
    );
  }
}