import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:instagram_clone/model/post.dart';
import 'package:instagram_clone/resources/storage_method.dart';
import 'package:instagram_clone/utils/pick_image.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // upload post

  Future<String> uploadPost(String description, Uint8List file, String uid,
      String username, String profImage) async {
    String res = "Something went wrong";
    try {
      String postid = const Uuid().v1();
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);
      Post post = Post(
          description: description,
          uid: uid,
          username: username,
          postid: postid,
          datePublished: DateTime.now(),
          postUrl: photoUrl,
          profImage: profImage,
          likes: []);
      _firestore.collection('posts').doc(postid).set(post.toJSON());

      res = "success";
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> likeinPost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
      } else {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> postComments(String postid, String text, String uid, String name,
      String profilePic) async {
    try {
      if (text.isNotEmpty) {
        String commentId = const Uuid().v1();
        _firestore
            .collection('posts')
            .doc(postid)
            .collection('comments')
            .doc(commentId)
            .set({
          'profilPic': profilePic,
          'name': name,
          'uid': uid,
          'comments': text,
          'commentId': commentId,
          'datePublished': DateTime.now()
        });
      } else {

          print("Text is empty");

      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deletePost(String postId, String currentuserId,
      String postuserId, BuildContext context) async {
    try {
      if (currentuserId == postuserId) {
        await _firestore.collection('posts').doc(postId).delete();
      } else {
        showSnackBar("You can delete only your post", context);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> followUser(String uid, String followId) async{
    try{

      DocumentSnapshot snap = await _firestore.collection('users').doc(uid).get();
      List following = (snap.data()! as dynamic)['following'];

      if(following.contains(followId)){
        await _firestore.collection('users').doc(followId).update({
          'followers' : FieldValue.arrayRemove([uid])
        });
        await _firestore.collection('users').doc(uid).update({
        'following' : FieldValue.arrayRemove([followId])
        });
      }else{                                   //yash_uid
        await _firestore.collection('users').doc(followId).update({
          'followers' : FieldValue.arrayUnion([uid]) // mukund_uid(current_user)
        });
        await _firestore.collection('users').doc(uid).update({
          'following' : FieldValue.arrayUnion([followId])
        });
      }
    }catch(e){
      print(e.toString());
    }
  }
}
