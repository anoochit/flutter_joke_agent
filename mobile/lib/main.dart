import 'package:flutter/material.dart';

void main() {
  runApp(const AiComedyClubApp());
}

class AiComedyClubApp extends StatelessWidget {
  const AiComedyClubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Comedy Club',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ComedyHomePage(),
    );
  }
}

class ComedyHomePage extends StatefulWidget {
  const ComedyHomePage({super.key});

  @override
  State<ComedyHomePage> createState() => _ComedyHomePageState();
}

class _ComedyHomePageState extends State<ComedyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Comedy Club 🎭'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Ready to laugh?', style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}
