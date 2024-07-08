import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/Screen/chat_screen.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/widgets/post_card.dart';

import '../utils/global_varibal.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor:
            width > webScreenSize ? webBackgroundColor : mobileBackgroundColor,
        appBar: width > webScreenSize
            ? null
            : AppBar(
                backgroundColor: mobileBackgroundColor,
                title: SvgPicture.asset(
                  'assets/images/instagram.svg',
                  color: primaryColor,
                  height: 32,
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      final snapshot = FirebaseFirestore.instance.collection('posts').snapshots();
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        final chatScreen = ChatScreen();
                        // chatScreen.receiveSnapshot(snapshot);
                        return chatScreen;
                      }));

    },
                    icon: const Icon(Icons.message),
                  )
                ],
              ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('posts').snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) => Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: width > webScreenSize ? width * 0.35 : 0,
                          vertical: width > webScreenSize ? 15 : 0),
                      child: PostCard(snap: snapshot.data?.docs[index]),
                    ));
          },
        ));
  }
}
