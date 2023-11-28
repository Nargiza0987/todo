import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  Future<void> _writeData(Map<String, dynamic> data) async {
    await FirebaseFirestore.instance
        .collection('albums 1')
        .add(data)
        .then((doc) => print('Write Data - Ok!'))
        .catchError((err) => print(err.message));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Demo super'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                await _writeData({
                  'author': 'Queen король',
                  'name': 'The Miracle 1',
                  'year': 1989,
                });
                await _writeData({
                  'author': 'Deep Purple фиалет',
                  'name': 'Stormbringer 1',
                  'year': 1974,
                  'genre': 'Hard rock'
                });
              },
              child: const Text(
                'Write Data',
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final db = FirebaseFirestore.instance;
                await db.collection('albums').get().then((event) {
                  for (var doc in event.docs) {
                    print("${doc.id} => ${doc.data()}");
                  }
                });
              },
              child: const Text(
                'Read Data',
              ),
            )
          ],
        ),
      ),
    );
  }
}
