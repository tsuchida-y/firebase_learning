import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}


class _AddPageState extends State<AddPage> {

  String newWord = '';


  //firebaseにデータを追加する
  Future addFirebaseData() async{
    await FirebaseFirestore.instance.collection("posts").add({//インスタンスを取得しコレクションを指定
      'name': 'Flutter',//追加するデータはmap型で指定
      'text': newWord,
      'createdAt': DateTime.now(),
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Page'),
      ),
      body: Column(
        children:[
          TextField(
            onChanged: (value){//文字が入力されるたびに呼ばれる。valueは入力された文字
              newWord = value;
            },
          ),
          ElevatedButton(
            onPressed: (){
              addFirebaseData();
              Navigator.pop(context);
            },
            child: const Text("追加"),
          )
        ] 
      ),
    );
  }
}