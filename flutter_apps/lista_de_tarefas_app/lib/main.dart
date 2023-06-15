import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _todoList = [];

  final listController = TextEditingController();

  Map<String, dynamic>? _removed;
  int? removedpos;
  
  @override
  void initState(){
    super.initState();

    _readData().then((value) {
      setState(() {
        _todoList = json.decode(value);
      });
    });
  }
  


  void addTodo(){
    setState(() {
    Map<String, dynamic> newTodo = Map();
    newTodo["title"] = listController.text;
    listController.text = "";
    newTodo["ok"] = false;
    _todoList.add(newTodo);
    _saveData();
    });
  }

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data.json");
  }

  Future<File> _saveData() async {
    String data = json.encode(_todoList);
    final file = await _getFile();
    return file.writeAsString(data);
  }

  Future<String> _readData() async{
    try{
      final file = await _getFile();
      return file.readAsString();
    } catch (e){
      return 'erro';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Tarefas'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(17, 1, 7, 1),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Nova Tarefa',
                      labelStyle: TextStyle(color: Colors.blue)
                    ),
                    controller: listController,
                  ),
                  
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blueAccent,

                  ),
                  onPressed: () => addTodo(),
                  child: const Text(
                    'ADD',
                    style: TextStyle(color: Colors.white),
                  )
                )
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => _refresh(),
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 10),
                itemCount: _todoList.length,
                itemBuilder: buildItem
            
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildItem(context, index) {
    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      background: Container(
        color: Colors.red,
        child: const Align(
          alignment: Alignment(-0.9, 0),
          child: Icon(Icons.delete,color: Colors.white,),
        ),
      ),
      direction: DismissDirection.startToEnd,
      child: CheckboxListTile(
      title: Text(_todoList[index]["title"]),
      value: _todoList[index]["ok"],
      secondary: CircleAvatar(
        child: Icon(_todoList[index]["ok"] ? Icons.check : Icons.error),
      ),
      onChanged: (value) {
        setState(() {
          _todoList[index]["ok"] = value;
          _saveData();
        });
      },
    ),
    onDismissed: (direction) {
      setState(() {
        _removed = Map.from(_todoList[index]);
        removedpos = index;
        _todoList.removeAt(index);
  
       _saveData();

       final snack = SnackBar(
        content: Text("Tarefa \"${_removed!["title"]}\" removida!!"),
        action: SnackBarAction(label: "Desfazer",
          onPressed: () {
            setState(() {
              _todoList.insert(removedpos!, _removed);
              _saveData();
            });
          },
        ),
        duration: const Duration(seconds: 2),
       );
       ScaffoldMessenger.of(context).clearSnackBars();
       ScaffoldMessenger.of(context).showSnackBar(snack);
      });
    },
  );

    // return CheckboxListTile(
    //   title: Text(_todoList[index]["title"]),
    //   value: _todoList[index]["ok"],
    //   secondary: CircleAvatar(
    //     child: Icon(_todoList[index]["ok"] ? Icons.check : Icons.error),
    //   ),
    //   onChanged: (value) {
    //     setState(() {
    //       _todoList[index]["ok"] = value;
    //       _saveData();
    //     });
    //   },
    // );
  }

  Future<Null> _refresh() async{
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
    _todoList.sort((a, b) {
      if(a["ok"] && !b["ok"]) {
        return 1;
      } else if(!a["ok"] && b["ok"]) {
        return -1;
      } else {
        return 0;
      }      
      });
      _saveData();
    });
    return null;
  }
}

