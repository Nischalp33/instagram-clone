
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estore/models/post_model.dart';
import 'package:estore/resources/storage_methods.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //upload post

  Future<String> uploadPost(
    String description,
    Uint8List file,
    String uid,
    String username,
    String profileImage,
    // String likes,
  ) async {
    String res = "Some error occurred";
    try {
      String postId = const Uuid().v1();
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);

      Posts post = Posts(
          description: description,
          uid: uid,
          postId: postId,
          username: username,
          datePublished: DateTime.now(),
          postUrl: photoUrl,
          ProfileImage: profileImage,
          likes: []);


       _firestore.collection('posts').doc(postId).set(post.toJson());
      res = "Success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<void> likePost(String postId, String uid, List likes) async{
    try{
      if(likes.contains(uid)){
       await _firestore.collection('posts').doc(postId).update({
          'likes' : FieldValue.arrayRemove([uid]),

        });
      }else{
       await  _firestore.collection('posts').doc(postId).update({
          'likes' : FieldValue.arrayUnion([uid]),
        });
      }

    }catch(e){
      print(e.toString());

    }
  }

  Future<void> postComment(String postId, String text, String uid, String name, String profilePic )async{

    try{
      if(text.isNotEmpty){
        String commentId = const Uuid().v1();
        await _firestore.collection('posts').doc(postId).collection('comments').doc(commentId).set({
        'profilePic' : profilePic,
        'name' : name,
          'text' : text,
          'commentId' : commentId,
          'uid' : uid,
          'datePublished' :DateTime.now(),
        });

        print('-------------------posted comment------------------------------');
      }else{
        print('text is empty');
      }

    }catch(e){
      print(e.toString());

    }

  }


  Future<void> deletePost(postId)async{
    try{
     await FirebaseFirestore.instance.collection('posts').doc(postId).delete();

    }catch(e){
print(e.toString());
    }
  }

  Future<void> followUser(
      String uid,
      String followId
      )async{

try{
  DocumentSnapshot snap = await _firestore.collection('users').doc(uid).get();

  List following = (snap.data()! as dynamic)['following'];

  if(following.contains(followId)){
    await _firestore.collection('users').doc(followId).update({
      'followers':FieldValue.arrayRemove([uid])
    });
    await _firestore.collection('users').doc(uid).update({
    'following' : FieldValue.arrayRemove([followId])
    });
  }else {
    await _firestore.collection('users').doc(followId).update({
      'followers' :FieldValue.arrayUnion([uid])
    });

    await _firestore.collection('users').doc(uid).update({
      'following' :FieldValue.arrayUnion([followId])
    });
  }


}catch(e){
  print(e);
}


  }
}
