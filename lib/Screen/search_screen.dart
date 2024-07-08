import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:instagram_clone/Screen/proflie_screen.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/global_varibal.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchcontroler = TextEditingController();

  bool isShowUser = false;
  String Lowercase = '';

  @override
  void dispose() {
    super.dispose();
    searchcontroler;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width > webScreenSize
              ? MediaQuery.of(context).size.width * 0.35
              : 0),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: mobileBackgroundColor,
            title: TextFormField(
              controller: searchcontroler,
              decoration: const InputDecoration(labelText: 'search for user'),
              onChanged: (String _) {
                setState(() {
                  isShowUser = true;
                  Lowercase = searchcontroler.text.toLowerCase();
                });
              },
            ),
          ),
          body: isShowUser
              ? FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .where('username',
                          isGreaterThanOrEqualTo: searchcontroler.text)
                      .where('username',
                          isLessThanOrEqualTo: '$Lowercase\uf8ff')
                      .get(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return ListView.builder(
                        itemCount: (snapshot.data as dynamic).docs.length,
                        itemBuilder: (context, index) {
                          // print((snapshot.data! as dynamic).docs[index]['username']);
                          return InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfileScreen(
                                        uid: (snapshot.data! as dynamic)
                                            .docs[index]['uid']))),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage((snapshot.data!
                                            as dynamic)
                                        .docs[index]['photoUrl'] ??
                                    'https://marketingaccesspass.com/wp-content/uploads/2015/10/Podcast-Website-Design-Background-Image.jpg'),
                              ),
                              title: Text((snapshot.data! as dynamic)
                                      .docs[index]['username'] ??
                                  "Not found"),
                            ),
                          );
                        });
                  },
                )
              : FutureBuilder(
                  future: FirebaseFirestore.instance.collection('posts').get(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return MasonryGridView.count(
                      crossAxisCount: 3,
                      itemCount: (snapshot.data! as dynamic).docs.length,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileScreen(
                                    uid: (snapshot.data! as dynamic).docs[index]
                                        ['uid']))),
                        child: Image.network(
                          (snapshot.data! as dynamic).docs[index]['postUrl'],
                          fit: BoxFit.cover,
                          // height:
                          //     MediaQuery.of(context).size.width > webScreenSize
                          //         ? 400
                          //         : 200,
                        ),
                      ),
                      mainAxisSpacing: 8.0,
                      crossAxisSpacing: 8.0,
                    );
                  })),
    );
  }
}
