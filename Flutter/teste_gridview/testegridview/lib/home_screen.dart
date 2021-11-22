import 'package:flutter/material.dart';
import 'main.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final List<Map> myProducts =
      List.generate(12, (index) => {"id": index, "name": "Product $index"})
          .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kindacode.com'),
      ),


      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            itemCount: myProducts.length,
            itemBuilder: (BuildContext ctx, index) {

              return Container(
          alignment: Alignment.center,
          child: Material(
            color: Colors.blueGrey,
            elevation: 8,
            borderRadius: BorderRadius.circular(28),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: InkWell(
              splashColor: Colors.black26,
              onTap: (){
                if(index == 0){
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => GamePage1()));
               }else if(index == 1){
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => GamePage2()));
               }else{
                 Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => GamePage1()));
               }

              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(child:
                  Ink.image(
                    image: const NetworkImage("https://pbs.twimg.com/media/FEaCjohXIAQPVgl?format=jpg&name=small"),
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                  const SizedBox(height: 6),
                  const Text(
                    'Maru',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  const SizedBox(height: 3),
                ]
                
            ),
          ),
        ),      
      );
            }),
      ),
    );
  }
}

