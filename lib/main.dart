import 'package:estore/providers/user_provider.dart';
import 'package:estore/responsive/mobile_screen_layout.dart';
import 'package:estore/responsive/responsive_layout.dart';
import 'package:estore/responsive/web_screen_layout.dart';
import 'package:estore/screens/login_screen.dart';
import 'package:estore/screens/signup_screen.dart';
import 'package:estore/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: 'AIzaSyAyXjbzUUDRJhsG-TUhD47P2A1R6CljYdg',
            appId: "1:1015823633218:web:34c33c3b2866fa5c7c16db",
            messagingSenderId: "1015823633218",
            projectId: "instagram-clone-5bf7b",
            storageBucket: "instagram-clone-5bf7b.appspot.com"));
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Insta clone',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  return ResponsiveLayout(
                    mobileScreenLayout: MobileScreenLayout(),
                    webScreenLayout: WebScreenLayout(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('${snapshot.error}'),
                  );
                }
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator(
                  color: primaryColor,
                ));
              }
              return LoginScreen();
            }),
      ),
    );
  }
}
