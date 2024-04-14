import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/colors.dart';

// import 'package:instagram_clone_flutter/utils/global_variable.dart';

class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({Key? key}) : super(key: key);

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Text('web view'),
    );
  }
}
