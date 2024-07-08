import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/resources/firestore_methods.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/global_varibal.dart';
import 'package:instagram_clone/utils/pick_image.dart';

import '../widgets/follow_button.dart';

class ProfileScreen extends StatefulWidget {
  final String? uid;

  const ProfileScreen({super.key, required this.uid});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userdata = {};
  bool isLoading = false;
 int postLen = 0;
 int followers =0;
 int following =0;
 bool isFollowing = false;
 final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();
      var postSnap = await FirebaseFirestore.instance.collection('posts').where('uid', isEqualTo:_auth.currentUser?.uid).get();
      postLen = postSnap.docs.length;
      followers = userSnap.data()!['followers'].length;
      following = userSnap.data()!['following'].length;

      userdata = userSnap.data()!;
      isFollowing = userSnap
          .data()!['followers']
          .contains(FirebaseAuth.instance.currentUser!.uid);
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return !isLoading
        ? Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              title: Text(userdata['username'] ?? "loading"),
            ),
            body: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width>webScreenSize?MediaQuery.of(context).size.width*0.35 : 0),
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.grey,
                              backgroundImage: NetworkImage(userdata['photoUrl']),
                              radius: 40,
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      buildStateColumn(postLen, "posts"),
                                      buildStateColumn(following, "following"),
                                      buildStateColumn(followers, "followers"),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      _auth.currentUser?.uid == widget.uid ?
                                      FollowButton(
                                        text: 'sign out',
                                        backgroundColor: mobileBackgroundColor,
                                        textColor: primaryColor,
                                        borderColor: Colors.grey,
                                        function: () =>FirebaseAuth.instance.signOut(),
                                      ):
                                      isFollowing ? FollowButton(
                                        text: 'Unfollow',
                                        backgroundColor: Colors.white,
                                        textColor: Colors.black,
                                        borderColor: Colors.grey,
                                        function: ()async{
                                          await FirestoreMethods().followUser(_auth.currentUser!.uid, userdata['uid']).then((value) {
                                          setState(() {
                                            isFollowing  = false;
                                            followers--;
                                          });
                                          });
                                        },
                                      ):FollowButton(
                                        text: 'follow',
                                        backgroundColor: Colors.blue,
                                        textColor: Colors.white,
                                        borderColor: Colors.blue,
                                        function: ()async{
                                          await FirestoreMethods().followUser(_auth.currentUser!.uid, userdata['uid']).then((value) {
                                        setState(() {
                                          isFollowing  = true;
                                          followers++;
                                        });
                                          });
                                        },
                                      )

                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(top: 15),
                          child: Text(
                            userdata['username'],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(top: 1),
                          child: Text(
                            userdata['bio'],
                            style: const TextStyle(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  FutureBuilder(future: FirebaseFirestore.instance.collection('posts').where('uid',isEqualTo: widget.uid).get(),
                      builder: (context,snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return GridView.builder(
                      shrinkWrap: true,
                      itemCount: (snapshot.data! as dynamic).docs.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        childAspectRatio: 1
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        DocumentSnapshot snap = (snapshot.data! as dynamic).docs[index];
                        return
                            Container(
                              child: Image(
                                image: NetworkImage(
                                  snap['postUrl']
                                ),
                                fit: BoxFit.cover,
                              ),
                            );
                      },

                    );
                      })
                ],
              ),
            ),
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }

  Column buildStateColumn(int num, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          num.toString(),
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Container(
            margin: EdgeInsets.only(top: 4),
            child: Text(
              label,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey),
            )),
      ],
    );
  }
}
