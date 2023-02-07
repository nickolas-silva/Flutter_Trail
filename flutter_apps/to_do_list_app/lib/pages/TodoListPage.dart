import 'package:flutter/material.dart';

class TodoListPage extends StatelessWidget {
  TodoListPage({super.key});

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Adicione uma tarefa...",
                        
                      ),
                    ),
                  ),

                  SizedBox(width: 8),

                  ElevatedButton(
                    onPressed: () {}, 
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

              SizedBox(height: 16,),
              ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    color: Colors.red,
                    height: 50,
                  ),
                ],
              ),
              SizedBox(height: 16,),


              Row(
                children: [
                  Expanded(
                    child: Text('Você possui 0 tarefas pendentes',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
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
    );
  }
  void login(){
    String text = emailController.text;
    print(text);
    emailController.clear();
  }

  void onChanged(String text) {
    print(text);
  }

  // void onSubmitted(String text){
  //   print(text);
  // }
}