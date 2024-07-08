
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/Screen/feed_screen.dart';
import 'package:instagram_clone/provider/user_provider.dart';
import 'package:instagram_clone/resources/firestore_methods.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/pick_image.dart';
import 'package:provider/provider.dart';

import '../model/user.dart';

class AddPost extends StatefulWidget{
  const AddPost({super.key});
  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {

  bool isLoading = false;
  Uint8List? _file;
 final TextEditingController _descriptionController = TextEditingController();


  _selectImage(BuildContext context)async{
    return await showDialog(
        context: context,
        builder: (context){
          return SimpleDialog(
            title: const Text("Create a post"),
            children: [
            SimpleDialogOption(
              padding:  EdgeInsets.all(20),
              child: Text("Take a photo"),
              onPressed: () async{
                Navigator.of(context).pop();
                Uint8List file = await pickImage(ImageSource.camera);

                setState(() {
                  _file = file;
                });
              },
            ),
            SimpleDialogOption(
              padding:  EdgeInsets.all(20),
              child: const Text("choose from gallery"),
              onPressed: () async{
                Navigator.of(context).pop();
                Uint8List file = await pickImage(ImageSource.gallery);
                setState(() {
                  _file = file;
                });
              },
            ),
            SimpleDialogOption(
              padding:  const EdgeInsets.all(20),
              child: const Text("cancel"),
              onPressed: () async{
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const FeedScreen()));
              },
            ),
          ]
          );
        });
  }

  void postImage(
      String uid,
      String username,
      String profImage
      )async{

    try{
      setState(() {
        isLoading = true;
      });

      String res = await FirestoreMethods().uploadPost(
          _descriptionController.text,
          _file!,
          uid,
          username,
          profImage);
      setState(() {
        isLoading = false;
      });
      if(res=='success'){
        showSnackBar('posted!', context);
        clearImage();
      }else{
        showSnackBar(res, context);
      }
    }catch(e){
     showSnackBar(e.toString(), context);
    }
  }

  void clearImage(){
    setState(() {
      _file = null;
    });
  }

  @override
  void dispose() {
      _descriptionController;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final User user = Provider.of<UserProvider>(context).getUser;
      return _file == null ? Center(
        child:  IconButton(
          onPressed: ()=> _selectImage(context),
          icon: const Icon(Icons.upload),
        ),
      )
    : Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        leading: IconButton( onPressed: () => clearImage(), icon: const Icon(Icons.arrow_back,)),
        title: const Text("Post to"),
        actions: [
              TextButton(
                  onPressed:()=> postImage(user.uid ,user.username ,user.photoUrl) , child: const Text("Post" , style:  TextStyle(fontWeight: FontWeight.bold , fontSize: 16),)
              )

        ],
      ),
      body: Column(
        children: [
          isLoading ? const LinearProgressIndicator() : const Padding(padding: EdgeInsets.all(0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(user.photoUrl),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width*0.4,
                child:  TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    hintText: "write a caption..",
                    border: InputBorder.none,
                  ),
                  maxLines: 8,
                ),
              ),
              SizedBox(
                height: 45,
                width: 45,
                child: AspectRatio(
                  aspectRatio: 487/451,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: MemoryImage(_file!),
                        fit: BoxFit.cover,
                        alignment: FractionalOffset.topCenter

                      )
                    ),
                  ),
                ),
              ),
              const Divider(),
            ],
          )
        ],
      ),
    );
  }
}