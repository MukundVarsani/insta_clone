import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Post {
  final String description;
  final String uid;
  final String username;
  final String postid;
  final datePublished;
  final String postUrl;
  final String profImage;
  final likes;

  const Post({
    required this.description,
    required this.uid,
    required this.username,
    required this.postid,
    required this.datePublished,
    required this.postUrl,
    required this.profImage,
    required this.likes,
  });

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
        description: snapshot['description'],
        uid: snapshot['uid'],
        username: snapshot['username'],
        postid: snapshot['postid'],
        datePublished: snapshot['datePublished'],
        postUrl: snapshot['postUrl'],
        profImage: snapshot['profImage'],
        likes: snapshot['likes']);
  }

  Map<String, dynamic> toJSON() => {
        'description': description,
        'uid': uid,
        'username': username,
        'postid': postid,
        'datePublished': datePublished,
        'profImage': profImage,
        'postUrl': postUrl,
        'likes': likes
      };
}
