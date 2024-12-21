import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_learning/post.dart';
import 'package:flutter/material.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage(this.post,{super.key});

  final Post post;

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}


class _UpdatePageState extends State<UpdatePage> {

  String updatedWord = '';


  //firebaseにデータを追加する
  Future updateFirebaseData() async{
    await FirebaseFirestore.instance.collection("posts").doc(widget.post.id).update({
      'name': 'Flutter',
      'text': updatedWord,
      'updatedAt': DateTime.now(),
      //'createdAt': DateTime.now(),
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
            initialValue: widget.post.text,
            onChanged: (value){//文字が入力されるたびに呼ばれる
              updatedWord = value;
            },
          ),
          ElevatedButton(
            onPressed: (){
              updateFirebaseData();
              Navigator.pop(context);
            },
            child: const Text("追加"),
          )
        ] 
      ),
    );
  }
}