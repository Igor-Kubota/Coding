import 'package:flutter/material.dart';
import 'package:testegridview/game_json.dart';
import 'package:testegridview/home_screen.dart';
import 'package:http/http.dart' as http;
import 'package:testegridview/review_game_json.dart';
import 'dart:convert';
import 'network_helper.dart';




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
          primary: Colors.lightBlueAccent.shade400 ,
          secondary: const Color(0XFF1F1B24),
          surface: Colors.lightBlueAccent.shade400,
          
          
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
             return const Center(child: CircularProgressIndicator(),);
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
                  color: Colors.cyan.shade200,
                  
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
             return const Center(child: CircularProgressIndicator(),);
           }
         }
       ),
    );
  }
}


class GamePage3 extends StatefulWidget {
  const GamePage3({ Key? key }) : super(key: key);

  @override
  _GamePage3State createState() => _GamePage3State();
}

class _GamePage3State extends State<GamePage3> {
    
  Future<List<ReviewGameJson>> readjsondata() async {
    const url = "http://localhost:8080/games";
    //final http.Response jsonData= await http.get(Uri.parse(url));


    var response = await http.get(Uri.parse(url));
    var rb = response.body;

    // store json data into list
    var list = json.decode(rb) as List;

    // iterate over the list and map each object in list to Img by calling Img.fromJson
    List<ReviewGameJson> imgs = list.map((i)=>ReviewGameJson.fromJson(i)).toList();

    print(imgs.runtimeType); //returns List<Img>
    print(imgs[0].runtimeType); //returns Img

    return imgs;
}
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      
      appBar: AppBar(
        title: const Text("Game Review"),
      ),


       body: FutureBuilder(
         future: readjsondata(),

         builder: (context, data){
           if (data.hasError){
             return Center(child:Text("${data.error}"));

           }else if (data.hasData){
             var items = data.data as List<ReviewGameJson>;
             return ListView.builder(
               itemCount: 1,
               itemBuilder: (context, index){
            return Card(
            color: const Color(0XFF1F1B24),
            child: Padding(
              padding: const EdgeInsets.only(top: 32.0, bottom: 32.0, left: 16.0, right: 16.0),
              
              child: Container(
                color: const Color(0XFF1F1B24),

                height: 260,
                child: Card(
                  color: const Color(0XFF1F1B24),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 34,
                        child: Image.network(
                          'https://upload.wikimedia.org/wikipedia/commons/8/88/MIS%2C_SP%2C_6_%28entrada%29.JPG',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        flex: 66,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                      Expanded(
                        flex: 15,
                        child: Text(
                          items[index].name.toString(),
                          style: TextStyle(
                          fontSize: 36,
                          color: Colors.cyan.shade100,
                        )
                      ),
                    ),

                      Expanded(
                        flex: 15,
                        child: Text(
                          "Developer: " + items[index].developer.toString(),
                          style: TextStyle(
                          fontSize: 20,
                          color: Colors.blueGrey.shade200,
                        )
                      ),
                    ),
                      Expanded(
                        flex: 15,
                        child: Text(
                          "Genre: " + items[index].genre.toString(),
                          style: TextStyle(
                          fontSize: 20,
                          color: Colors.blueGrey.shade200,
                        )
                      ),
                    ),

                      Expanded(
                        flex: 15,
                        child: Text(
                          "Score: " + items[index].score.toString(),
                          style: TextStyle(
                          fontSize: 20,
                          color: Colors.blueGrey.shade200,
                        )
                      ),
                    ),

                      Expanded(
                        flex: 15,
                        child: Text(
                          "Release Date: "+ items[index].release.toString(),
                          style: TextStyle(
                          fontSize: 20,
                          color: Colors.blueGrey.shade200,
                        )
                      ),
                    ),

                      Expanded(
                        flex: 15,
                        child: Text(
                          "Platform: "+ items[index].consoles.toString(),
                          style: TextStyle(
                          fontSize: 20,
                          color: Colors.blueGrey.shade200,
                        )
                      ),
                    ),
                    
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      )
    );
  }
);
           }else{
             return const Center(child: CircularProgressIndicator(),);
           }
         }
       ),
    );
  }
}





class GamePage4 extends StatefulWidget {
  const GamePage4({ Key? key }) : super(key: key);

  @override
  _GamePage4State createState() => _GamePage4State();
}

class _GamePage4State extends State<GamePage4> {
    
  Future<List<GameJson>> ReadJsonData() async{
    const url = "http://localhost:8080/games";
    final http.Response jsonData= await http.get(Uri.parse(url));

    final list = jsonDecode(jsonData.body) as List<dynamic>;

    return list.map((e) => GameJson.fromJson(e)).toList();
  }


  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: const  BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0XFF0d324d),
            Color(0XFF000000)
          ],
        ),
      ), 

    child: Scaffold(
      backgroundColor: Colors.transparent,
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

          return Column(
            children: [
              Card(
              elevation: 0,
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.only(top: 32.0, bottom: 32.0, left: 16.0, right: 16.0),
              
              child: Container(
              
                color: Colors.transparent,

                height: 260,
                child: Card(
                  elevation: 0,
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 34,
                        child: Image.network(
                          'https://upload.wikimedia.org/wikipedia/commons/8/88/MIS%2C_SP%2C_6_%28entrada%29.JPG',
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      Expanded(
                        flex: 66,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                      Expanded(
                        flex: 15,
                        child: Text(
                          items[index+1].name.toString(),
                          style: TextStyle(
                          fontSize: 36,
                          color: Colors.cyan.shade100,
                        )
                      ),
                    ),

                      Expanded(
                        flex: 15,
                        child: Text(
                          "Developer: " + items[index+1].developer.toString(),
                          style: TextStyle(
                          fontSize: 20,
                          color: Colors.blueGrey.shade200,
                        )
                      ),
                    ),
                      Expanded(
                        flex: 15,
                        child: Text(
                          "Genre: " + items[index+1].genre.toString(),
                          style: TextStyle(
                          fontSize: 20,
                          color: Colors.blueGrey.shade200,
                        )
                      ),
                    ),

                      Expanded(
                        flex: 15,
                        child: Text(
                          "Score: " + items[index+1].score.toString(),
                          style: TextStyle(
                          fontSize: 20,
                          color: Colors.blueGrey.shade200,
                        )
                      ),
                    ),

                      Expanded(
                        flex: 15,
                        child: Text(
                          "Release Date: "+ items[index+1].release.toString(),
                          style: TextStyle(
                          fontSize: 20,
                          color: Colors.blueGrey.shade200,
                        )
                      ),
                    ),

                      Expanded(
                        flex: 15,
                        child: Text(
                          "Platform: "+ items[index+1].consoles.toString(),
                          style: TextStyle(
                          fontSize: 20,
                          color: Colors.blueGrey.shade200,
                          )
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )      
      )
    ),
    Card(
      
      elevation: 0,
      color: Colors.transparent,
      child: Padding(
              padding:const EdgeInsets.only(top: 32.0, bottom: 32.0, left: 16.0, right: 16.0),
              child: Column(
                children: [
                  TextButton.icon(
                  onPressed: ()async{
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MinhaListaDinamica()));
                },
        
                  icon: const Icon(Icons.sort), 
                  label: Text("Load Review Page",
                  style: TextStyle(
                          fontSize: 20,
                          color: Colors.blueGrey.shade200,
                    )
                  ),
                ),
              ],
            )
          )
        )
      ]
    );
  }
);
    

           }else{
             return const Center(child: CircularProgressIndicator(),);
           }
         }
       ),
      )
    );
  }
}

class MinhaListaDinamica extends StatefulWidget {
  const MinhaListaDinamica({ Key? key }) : super(key: key);

  @override
  State<MinhaListaDinamica> createState() => _MinhaListaDinamicaState();
}

class _MinhaListaDinamicaState extends State<MinhaListaDinamica> {
  List<Review> reviews = [];
  

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const  BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0XFF0d324d),
            Color(0XFF000000)
          ],
        ),
      ), 
    child: Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(title: const Text("Minha Lista Dinâmica"),),
      body: ListView.builder(
        itemCount: reviews.length,
        itemBuilder: (context, itemIndex){
          return ListTile(
            title: Text(
              reviews[itemIndex].review!,
              style: TextStyle(
                fontSize: 24,
                color: Colors.cyan.shade100
              ),
            ),
            leading: const Icon(
              Icons.account_circle,
              size: 40.0,
              ),
            subtitle: Text(
              "${reviews[itemIndex].user!.name}",
              style: TextStyle(
                fontSize: 18,
                color: Colors.blueGrey.shade200,
              ),
            ),
          ); 
        },
      ),  
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          NetworkHelper helper = NetworkHelper(url:"http://localhost:8080/games/4");
          ReviewGameJson randomUsers = ReviewGameJson.fromJson(await helper.getData());
          //Colocar mais usuários
          randomUsers.reviews!.forEach((element) {
          reviews.add(
              Review(
              review: element.review!,
              user: element.user! , 
              )
            );
 
          }
        );
          setState(() {});
        },
        label: const Text("Load All Reviews for this game"),
        icon: const Icon(Icons.sort,
        size: 40.0,),
        backgroundColor: Colors.cyan.shade100,

        ),     
      )
    );
  }
}
