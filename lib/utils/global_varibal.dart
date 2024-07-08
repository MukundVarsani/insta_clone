import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:instagram_clone/Screen/add_post_screen.dart';
import 'package:instagram_clone/Screen/feed_screen.dart';
import 'package:instagram_clone/Screen/like_screen.dart';
import 'package:instagram_clone/Screen/proflie_screen.dart';
import 'package:instagram_clone/Screen/search_screen.dart';

const webScreenSize = 600;

 List<Widget> homeScreenItem = [
  const FeedScreen(),
  const SearchScreen(),
  const AddPost(),
   LikeScreen(),
  ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid),
];