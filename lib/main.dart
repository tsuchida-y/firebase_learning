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
    options: DefaultFirebaseOptions.currentPlatform,//現在のプラットフォーム(androidとか)FirebaseOptionsを取得
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase',
      theme: ThemeData(
      
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Firebase Learning!!'),
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


  //この画面を開いたらこうするというのを定義。一度だけ実行される 
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
    .then((event) {//コールバック関数を渡す
      final docs = event.docs;//取得したドキュメントのリスト
      
        setState(() {//画面を更新する
          posts = docs.map((doc){//各要素に対して処理を行う。docは現在のドキュメント
            final data = doc.data();//現在のドキュメントのデータを取得
            final id = doc.id;
            final text = data['text'] as String;
            final createdAt = data['createdAt'].toDate();//Timestamp型をDateTime型(日付や時間)に変換
            final updatedAt = data['updatedAt']?.toDate();

            return Post(//取得したデータを使用し、Postオブジェクトを生成し返す
              id:id,//左がPostクラスのフィールド、右が取得したデータ
              text:text,
              createdAt:createdAt,
              updatedAt:updatedAt
            );},
            ).toList();//Listに変換する
            
        });  
    });
  }




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,//背景色を設定

        title: Text(widget.title),
      ),
      body: Center(
        child:ListView(
          children: posts
          .map((post) => InkWell(//タップ可能にしエフェクトをつける
            onTap: ()async{
              await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UpdatePage(post),)
            );

            await _fetchFirebaseData();

            },
            child:Padding(//余白を設定
            padding:const EdgeInsets.symmetric(//上下左右に一定の余白を設定
              horizontal:16,//左右の余白
              vertical:8,//上下の余白
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
                    fontWeight: FontWeight.bold,//テキストの太さ
                  ),
                ),
              ],
            ),)
          )
        ).toList(),),
      ),
 
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPage())
          );
          await _fetchFirebaseData();//画面遷移が終わったら実行
        },
        
        tooltip: 'Increment',//長押しした時に表示されるテキスト
        child: const Icon(Icons.add),
      ), 
    );
  }
}
