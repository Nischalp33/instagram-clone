


import 'package:cloud_firestore/cloud_firestore.dart';

class Posts{
  final String description;
  final String uid;
  final String username;
  final String postId;
  final datePublished;
  final String postUrl;
  final String ProfileImage;
  final likes;

  const Posts({
    required this.description,
    required this.uid,
    required this.postId,
    required this.username,
    required this.datePublished,
    required this.postUrl,
    required this.ProfileImage,
    required this.likes,
  });
  Map<String, dynamic> toJson() => {
    "username" : username,
    "uid" : uid,
    "description" :description,
    "postId" : postId,
    "datePublished" : datePublished,
    "postUrl" : postUrl,
    "ProfileImage" : ProfileImage,
    "likes" : likes,
  };

  static Posts fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String, dynamic>;
    return Posts(
      username: snapshot['username'],
      uid: snapshot['uid'],
      description: snapshot['description'],
      postId: snapshot['postId'],
      datePublished: snapshot['datePublished'],
      postUrl: snapshot['postUrl'],
      ProfileImage: snapshot['ProfileImage'],
      likes: snapshot['likes'],
    );

  }

}