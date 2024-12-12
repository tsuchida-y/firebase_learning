import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  print("初期化前");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print("初期化後");
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

//firebaseからデータを取得する
  //   void _fetchFirebaseData() async{
  //     print("await前");
  //   await FirebaseFirestore.instance.collection("posts")
  //   .get()//postsコレクション内の全てのドキュメントを取得
  //   .then((event) {//データ取得完了後に実行されるコールバック関数を定義
  //   print("await後");
  //     for(var doc in event.docs) {
  //       print("${doc.id}=>${doc.data()}");
  //     }
  //   });
  //   print("メソッド終了");
  // }
void _fetchFirebaseData() async {
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("posts").get();
    for (var doc in querySnapshot.docs) {
      print("${doc.id} => ${doc.data()}");
    }
  } catch (e) {
    print("Error fetching data: $e");
  }
}


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchFirebaseData,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), 
    );
  }
}
