import 'package:estore/screens/add_post_screen.dart';
import 'package:estore/screens/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../screens/feed_screen.dart';
import '../screens/search_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

const webScreen = 600;

List<Widget>homeScreenItems = [
  FeedScreen(),
  SearchScreen(),
  AddPostScreen(),
  Text('fav'),
  ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid,)
];
