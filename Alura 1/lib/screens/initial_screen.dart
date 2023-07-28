import 'package:flutter/material.dart';

import '../components/task.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  bool opacidade = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: const Text('Tarefas'),
      ),
      body: AnimatedOpacity(
        opacity: opacidade ? 1 : 0,
        duration: const Duration(milliseconds: 200),
        child: ListView(
          children: const [
            Task(
                'Aprender Flutter',
                'assets/images/flutter.png',
                3),
            Task(
                'Andar de bike',
                'assets/images/bike.jpg',
                4),
            Task(
                ' Meditar',
                'assets/images/meditar.jpeg',
                5),
            Task(' Jogar',
                'assets/images/jogo.jpg', 1),
            SizedBox(height: 80,)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            opacidade = !opacidade;
          });
        },
        child: const Icon(Icons.remove_red_eye),
      ),
    );
  }
}
