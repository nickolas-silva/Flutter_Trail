import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State <Home> createState() =>  HomeState();
}

class  HomeState extends State <Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(onPressed: () => {}, icon: Icon(Icons.refresh),)
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(Icons.person_outlined, size: 120.0, color: Colors.green,),
              TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Peso (kg)",
                    labelStyle: TextStyle(color: Colors.green)
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 25
                  ),
                ),
                TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Altura (cm)",
                      labelStyle: TextStyle(color: Colors.green)
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green,fontSize: 25),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Container(
                      height: 50,
                      child: TextButton(onPressed: () => {},
                      child: Text("Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                      
                    ),
                    color: Colors.green,
                    ),
                  ),
                  Text("Info",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25),)
            ],
            
          
          ),
      ),

    );
  }
}