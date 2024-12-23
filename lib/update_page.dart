import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_learning/post.dart';
import 'package:flutter/material.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage(this.post,{super.key});

  final Post post;//Postクラスのインスタンスを受け取る

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}


class _UpdatePageState extends State<UpdatePage> {

  String updatedWord = '';//ユーザーが入力した新しい文字列を格納する変数


  //firebaseにデータを追加する
  Future updateFirebaseData() async{
    await FirebaseFirestore.instance.collection("posts").doc(widget.post.id).update({//ドキュメントIDを使用して、特定のドキュメントを参照
      'name': 'Flutter',
      'text': updatedWord,
      'updatedAt': DateTime.now(),
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UpdatePage'),
      ),
      body: Column(
        children:[
          TextFormField(
            initialValue: widget.post.text,//Postクラスのtextフィールドを初期値として設定
            onChanged: (value){//文字が入力されるたびに呼ばれる
              updatedWord = value;
            },
          ),
          ElevatedButton(
            onPressed: (){
              updateFirebaseData();
              Navigator.pop(context);
            },
            child: const Text("更新"),
          )
        ] 
      ),
    );
  }
}