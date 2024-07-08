import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/widgets/like_card.dart';
import 'package:instagram_clone/widgets/post_card.dart';

class LikeScreen extends StatefulWidget{
  @override
  State<LikeScreen> createState() => _LikeScreenState();
}

class _LikeScreenState extends State<LikeScreen> {
  
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text("Likes"),
     ),
     body:StreamBuilder(
       stream:_firestore.collection('posts').where('uid', isEqualTo:_auth.currentUser?.uid ).snapshots(),
       builder: (
           context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
         if(snapshot.connectionState == ConnectionState.waiting){
           return const Center(
             child: CircularProgressIndicator(),
           );
         }
         return ListView.builder(itemCount: snapshot.data?.docs.length,
             itemBuilder: (context ,index){
              return LikeCard(snap: snapshot.data?.docs[index],);
             });
       } ,
     ),
   );
  }
}




