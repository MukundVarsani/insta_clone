
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class User{
  final String email;
  final String uid;
  final String photoUrl;
  final String username;
  final String bio;
  final List followers;
  final List following;

  const User({
  required this.email,
  required this.uid,
  required this.photoUrl,
  required this.username,
  required this.bio,
  required this.followers,
  required this.following,
  });

  static User fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String ,dynamic>;

    return User(
      username: snapshot['username'],
      uid: snapshot['uid'],
      email: snapshot['email'],
      bio: snapshot['bio'],
      photoUrl: snapshot['photoUrl'],
      followers: snapshot['followers'],
      following: snapshot['following']
    );
  }

  Map<String ,dynamic> toJSON()=>{
    'username': username,
    'uid': uid,
    'email': email,
    'bio': bio,
    'followers': [],
    'following': [],
    'photoUrl' : photoUrl
  };

}