import 'package:flutter/material.dart';

import '../models/todo.dart';
import '../widgets/todo_list_item.dart';

class TodoListPage extends StatefulWidget {
  TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController todoController = TextEditingController();

  List<Todo> todos = [];
  Todo? deletedTodo;
  int? deletedpos;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: todoController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Adicione uma tarefa...",
                          
                        ),
                      ),
                    ),
    
                    SizedBox(width: 8),
    
                    ElevatedButton(
                      onPressed: () {
                        String text = todoController.text;
                        setState(() {
                          Todo newTodo = Todo(
                            title: text,
                            date: DateTime.now(),
                          );
                          todos.add(newTodo);
                        });
                        todoController.clear();
                      }, 
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff00d7f3),
                        padding: EdgeInsets.all(14)
                      ),
                      child: Icon(
                        Icons.add,
                        size: 30,
                      ),
                      )
                  ],
                ),
    
                SizedBox(height: 16),
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for(Todo todo in todos)
                        TodoListItem(
                          todo: todo,
                          onDelete: onDelete,
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
    
    
                Row(
                  children: [
                    Expanded(
                      child: Text('Você possui ${todos.length} tarefas pendentes',
                      ),
                    ),
                    ElevatedButton(
                      onPressed: showDeletedTodosConfirmationDialog,
                      child: Text('Limpar Tudo'),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff00d7f3),
                        padding: EdgeInsets.all(14)
                      ),
                     )
                  ],
                )
              ],
            ),
    
            
          ),
        ),
      ),
    );
  }

  void onDelete(Todo todo){
    deletedTodo = todo;
    deletedpos = todos.indexOf(todo);

    setState(() {
      todos.remove(todo);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Tarefa ${todo.title} foi removida com sucesso!', style: TextStyle(color: Color(0xff060708)),
      ),
        backgroundColor: Colors.white,
        action: SnackBarAction(
          label: 'Desfazer',
          textColor: const Color(0xff00d7f3),
          onPressed: () {
            setState(() {
              todos.insert(deletedpos!, deletedTodo!);
              
            });
          },
        ),
        duration: const Duration(seconds: 5),
      )
    );
  }

  void showDeletedTodosConfirmationDialog(){
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Limpar Tudo?'),
        content: Text('Você tem certeza que deseja apagar todas as tarefas?'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(primary: Color(0xff00d7f3)),
              child: Text('Cancelar')
            ),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                deleteAllTodos();
              },
              style: TextButton.styleFrom(primary: Colors.red),
              child: Text('Limpar Tudo')
            )
        ],
      ),
    );
  }
  void deleteAllTodos(){
    setState(() {
    todos.clear();
      
    });
  } 
  // void onChanged(String text) {
  //   print(text);
  // }

}