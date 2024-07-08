import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/model/user.dart' as model;
import 'package:instagram_clone/resources/storage_method.dart';

class AuthMethod {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> signupUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file
  }) async {
    String res = "Some error occurred";

    try {
      if (email.isNotEmpty || password.isNotEmpty || username.isNotEmpty ||
          bio.isNotEmpty) {

        UserCredential credential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
      //
      String photoUrl = await StorageMethods().uploadImageToStorage("ProfilePics", file, false);

    model.User user = model.User(
        email: email,
        uid: _auth.currentUser!.uid,
        photoUrl: photoUrl,
        username: username,
        bio: bio,
        followers:[],
        following: []
    );
        _firestore.collection('users').doc(credential.user!.uid).set(user.toJSON());
      res = "success";
      }

    }  on FirebaseAuthException catch (e)  {
      if(e.code =='invalid-email'){
        res = 'The email is badly formted';
      }
      else if(e.code == 'weak-password'){
        res = 'password length must be greater than 6 letter';
      }
    }

    catch(err){
      res = err.toString();
    }

    return res;
    }


  Future<String> loginUser({
    required String email,
    required String password,
})async{
   String res = "Something went wrong";
   try{
    if(email.isNotEmpty && password.isNotEmpty){
    await _auth.signInWithEmailAndPassword(email: email, password: password).then((value) => res = "success");
    }else{
    res = "Please enter all the fields";
    }
   }catch(err){
     res = err.toString();
   }
   return res;
}


Future<model.User> getUserDetail()async{
    User currentuser = _auth.currentUser!;

    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection('users').doc(currentuser.uid).get();

    return model.User.fromSnap(documentSnapshot);
}
}