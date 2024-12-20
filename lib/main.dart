import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String firebaseData='';//Firebaseから取得したデータを格納
  List<String> texts = [];


//firebaseからデータを取得する
    void _fetchFirebaseData() async{
    await FirebaseFirestore.instance.collection("posts").get().then((event) {
      for(var doc in event.docs) {
        setState(() {
          final text = doc.data()['text'];
          texts.add(text);
        });  
      }
    });
  }


//firebaseにデータを追加する
  void addFirebaseData() async{
    await FirebaseFirestore.instance.collection("posts").add({
      'name': 'Flutter',
      'text': 'Hello Firebase',
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(
        child:ListView(
          children:texts.map((text) => Text(text)).toList(),
        ),


      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addFirebaseData,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), 
    );
  }
}
