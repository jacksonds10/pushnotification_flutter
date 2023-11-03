import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 51, 190, 214),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Card(
               child:  ElevatedButton(
                  onPressed: () {
                    // Navegue para a rota '/notificacao' quando o botão for pressionado
                    Navigator.of(context).pushNamed('/notificacao');
                  },
                  child: Text('Ir para Notificação'),
                ),
                
              ),
              Text('Tela HOME')
            ],
          ),
        ),
      ),
    );
  }
}
