import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/colors.dart';

class ChatScreen extends StatefulWidget {



  const ChatScreen( {Key? key}) : super(key: key);


  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: Text("Chat_screen"),
      ),
      body: Container(
        color: Colors.lightBlue,
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child:  SingleChildScrollView(
          child: Column(
              children: [
                SizedBox(height:15),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        maxWidth: 300
                    ),
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12,vertical: 7),
                        decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.all(Radius.circular(12)).copyWith(
                                topLeft: Radius.circular(0)
                            )
                        ),
                        child: Text("hello how are you , how do you do", style: TextStyle(fontSize: 24),)),
                  ),
                ),
                SizedBox(height:15),
                Align(
                  alignment: Alignment.centerRight,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        maxWidth: 300
                    ),
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12,vertical: 7),
                        decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.all(Radius.circular(12)).copyWith(
                                topRight: Radius.circular(0)
                            )
                        ),
                        child: Text("hello how are you , how do you do", style: TextStyle(fontSize: 24),)),
                  ),
                ),
                SizedBox(height:15),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        maxWidth: 300
                    ),
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12,vertical: 7),
                        decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.all(Radius.circular(12)).copyWith(
                                topLeft: Radius.circular(0)
                            )
                        ),
                        child: Text("hello how are you , how do you do", style: TextStyle(fontSize: 24),)),
                  ),
                ),
                SizedBox(height:15),
                Align(
                  alignment: Alignment.centerRight,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        maxWidth: 300
                    ),
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12,vertical: 7),
                        decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.all(Radius.circular(12)).copyWith(
                                topRight: Radius.circular(0)
                            )
                        ),
                        child: Text("hello how are you , how do you do", style: TextStyle(fontSize: 24),)),
                  ),
                ),
                SizedBox(height:15),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        maxWidth: 300
                    ),
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12,vertical: 7),
                        decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.all(Radius.circular(12)).copyWith(
                                topLeft: Radius.circular(0)
                            )
                        ),
                        child: Text("hello how are you , how do you do", style: TextStyle(fontSize: 24),)),
                  ),
                ),
                SizedBox(height:15),
                Align(
                  alignment: Alignment.centerRight,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        maxWidth: 300
                    ),
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12,vertical: 7),
                        decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.all(Radius.circular(12)).copyWith(
                                topRight: Radius.circular(0)
                            )
                        ),
                        child: Text("hello how are you , how do you do", style: TextStyle(fontSize: 24),)),
                  ),
                ),
                SizedBox(height:15),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        maxWidth: 300
                    ),
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12,vertical: 7),
                        decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.all(Radius.circular(12)).copyWith(
                                topLeft: Radius.circular(0)
                            )
                        ),
                        child: Text("hello how are you , how do you do", style: TextStyle(fontSize: 24),)),
                  ),
                ),
                SizedBox(height:15),
                Align(
                  alignment: Alignment.centerRight,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        maxWidth: 300
                    ),
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12,vertical: 7),
                        decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.all(Radius.circular(12)).copyWith(
                                topRight: Radius.circular(0)
                            )
                        ),
                        child: Text("hello how are you , how do you do", style: TextStyle(fontSize: 24),)),
                  ),
                ),
                SizedBox(height:15),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        maxWidth: 300
                    ),
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12,vertical: 7),
                        decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.all(Radius.circular(12)).copyWith(
                                topLeft: Radius.circular(0)
                            )
                        ),
                        child: Text("hello how are you , how do you do", style: TextStyle(fontSize: 24),)),
                  ),
                ),
                SizedBox(height:15),
                Align(
                  alignment: Alignment.centerRight,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        maxWidth: 300
                    ),
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12,vertical: 7),
                        decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.all(Radius.circular(12)).copyWith(
                                topRight: Radius.circular(0)
                            )
                        ),
                        child: Text("hello how are you , how do you do", style: TextStyle(fontSize: 24),)),
                  ),
                ),



              ],
    ),
        ),)
    ,
    );
  }
}