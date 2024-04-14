import 'package:estore/resources/auth_method.dart';
import 'package:estore/screens/signup_screen.dart';
import 'package:estore/utils/colors.dart';
import 'package:estore/utils/utils.dart';
import 'package:estore/widgets/text_field_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout.dart';
import '../responsive/web_screen_layout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _loading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);
    if (res == "Success") {
      showSnackBar(res, context);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => ResponsiveLayout(
              mobileScreenLayout: MobileScreenLayout(),
              webScreenLayout: WebScreenLayout(),
            )),
      );
    } else {
      showSnackBar(res, context);
    }
    setState(() {
      _loading = false;
    });
  }

  void navigateToSignup() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SignupScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Container(),
              flex: 2,
            ),
            SvgPicture.asset(
              "assets/ic_instagram.svg",
              color: primaryColor,
              height: 64,
            ),
            SizedBox(
              height: 64,
            ),
            //text field input for email
            TextFieldInput(
                textEditingController: _emailController,
                hintText: 'Enter your email',
                textInputeType: TextInputType.emailAddress),
            SizedBox(
              height: 24,
            ),
//text field input for password
            TextFieldInput(
                textEditingController: _passwordController,
                hintText: 'Enter your password',
                textInputeType: TextInputType.visiblePassword,
                isPass: true),

            SizedBox(
              height: 24,
            ),
            InkWell(
              onTap: loginUser,
              child: Container(
                child: _loading
                    ? CircularProgressIndicator(
                        color: primaryColor,
                      )
                    : Text('Login'),
                width: double.infinity,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    color: blueColor),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Flexible(
              child: Container(),
              flex: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text('Dont have an account?'),
                  padding: EdgeInsets.symmetric(vertical: 8),
                ),
                GestureDetector(
                  onTap: navigateToSignup,
                  child: Container(
                    child: Text(
                      'Sign up',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
