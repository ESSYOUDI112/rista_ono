import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: RistaOnoHome(),
  ));
}

class RistaOnoHome extends StatelessWidget {
  const RistaOnoHome({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rista Ono Chat'),
        backgroundColor: Colors.blueAccent,
      ),
      body: const Center(
        child: Text(
          'مرحباً بك في تطبيق ريستا أونو!\nتم بناء التطبيق بنجاح.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
