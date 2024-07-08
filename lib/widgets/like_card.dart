import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';

class LikeCard extends StatelessWidget{

  final snap;
  const LikeCard({super.key,
    this.snap});

  @override
  Widget build(BuildContext context) {

    DateTime now = DateTime.now();
    DateTime givenDateTime = snap['datePublished'].toDate();
    Duration difference = now.difference(givenDateTime);
      String time= '';

    // time = difference.inSeconds > 60 ?  difference.inMinutes : difference.inSeconds;
    // time = difference.inMinutes > 60 ?difference.inHours :  difference.inMinutes;

  if(difference.inDays==0){
    if(difference.inHours ==0){
      if(difference.inMinutes ==0){
        time = '${difference.inSeconds} s';
      }else{
        time = '${difference.inSeconds} m';
      }
      time = '${difference.inMinutes} m';
    }else{
      time = '${difference.inHours} h';
    }
    time = '${difference.inHours} h';
  }else{
    time = '${difference.inDays} d';
  }

// print(time);


    return  Card(
      color: mobileBackgroundColor,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                  snap['profImage']
              ), // load the avatar image from the URL
            ),
            SizedBox(width: 10), // add some space between the avatar and the name
            Text(snap['username'], style: TextStyle(fontWeight: FontWeight.bold)), // display the user name in bold
            SizedBox(width: 50,),
            Text('likes yous post'), // display the text
            SizedBox(width: 10), // add some space between the text and the date
            Text(time.toString()), // display the date
            SizedBox(width: 10), // add some space between the date and the second avatar
            Image.network(
              snap['postUrl'],
              height: 40,
              width: 40,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}

