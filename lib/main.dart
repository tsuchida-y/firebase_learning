import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_learning/next_page.dart';
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


//この画面を開いたらこうするというのを定義  
  @override
  void initState() {
    super.initState();
    _fetchFirebaseData();
  }


//firebaseからデータを取得する
    Future _fetchFirebaseData() async{
    await FirebaseFirestore.instance
    .collection("posts")
    .orderBy('createdAt')
    .get()
    .then((event) {
      final docs = event.docs;
      
        setState(() {
          texts = docs.map((doc) => doc.data()['text'].toString()).toList();
        });  
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
        onPressed: ()async{
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPage())
          ).then((value) => _fetchFirebaseData());
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), 
    );
  }
}
