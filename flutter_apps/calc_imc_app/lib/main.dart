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
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados";

  void _resetFields(){
    pesoController.text = "";
    alturaController.text = "";
    setState(() {
      _infoText = 'Informe seus Dados';
      _formKey = GlobalKey<FormState>();
    });
  }

  void calc(){
    setState(() {
    double peso = double.parse(pesoController.text);
    double altura = double.parse(alturaController.text) / 100;
    double imc = peso / (altura * altura);
    if(imc < 18.6){
      _infoText = 'Abaixo do Peso (${imc.toStringAsPrecision(2)})';
    } else if(imc >= 18.6 && imc <24.9){
      _infoText = 'Peso Ideal (${imc.toStringAsPrecision(2)})';
    } else if (imc >= 24.9 && imc < 29.9){
      _infoText = 'Levemente acima do Peso (${imc.toStringAsPrecision(2)})';
    } else if (imc >= 29.9 && imc < 34.9){
      _infoText = 'Obesidade Grau I (${imc.toStringAsPrecision(2)})';
    } else if (imc >= 34.9 && imc < 39.9){
      _infoText = 'Obesidade Grau II (${imc.toStringAsPrecision(2)})';
    } else if (imc >= 40){
      _infoText = 'Obesidade Grau III (${imc.toStringAsPrecision(2)})';
    }
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            onPressed: _resetFields,
            icon: Icon(Icons.refresh),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.person_outlined,
                size: 120.0,
                color: Colors.green,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Peso (kg)",
                    labelStyle: TextStyle(color: Colors.green)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25),
                controller: pesoController,
                validator: (value) {
                  if(value!.isEmpty){
                    return "Insira seu peso";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Altura (cm)",
                    labelStyle: TextStyle(color: Colors.green)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25),
                controller: alturaController,
                validator: (value) {
                  if(value!.isEmpty){
                    return 'Insira sua Altura';
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Container(
                  height: 50,
                  color: Colors.green,
                  child: TextButton(
                    onPressed: () {
                      if(_formKey.currentState!.validate()){
                        calc();
                      }
                      
                    },
                    child: const Text(
                      "Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25),
              )
            ],
          ),
        ),
      ),
    );
  }
}
