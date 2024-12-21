import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_learning/next_page.dart';
import 'package:firebase_learning/post.dart';
import 'package:firebase_learning/update_page.dart';
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
  List <Post> posts = [];


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
          posts = docs.map((doc){
            final data = doc.data();
            final id = doc.id;
            final text = data['text'] as String;
            final createdAt = data['createdAt'].toDate();
            final updatedAt = data['updatedAt']?.toDate();

            return Post(
              id:id,
              text:text,
              createdAt:createdAt,
              updatedAt:updatedAt);
            },
            ).toList();
            
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
          children: posts
          .map((post) => InkWell(
            onTap: ()async{
              await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UpdatePage(post),)
            );

            await _fetchFirebaseData();
            },
            child:Padding(
            padding:const EdgeInsets.symmetric(
              horizontal:16,
              vertical:8,
            ),
            child:Row(
              children: [
              const Icon(
                Icons.person,
                size:48,
                ),
                Text(
                  post.text,
                  style:const TextStyle(
                    fontSize:24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
              ),
              )
          )
        ).toList(),
        ),
        ),
 
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPage())
          ).then((value) => _fetchFirebaseData());

          await _fetchFirebaseData();//画面遷移が終わったら実行
        },
        
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), 
    );
  }
}
